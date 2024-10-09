//
//  Calculator.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 27.09.24.
//

public class Calculator {
    var token: Token
    var displayBuffer: String
    private var memory: SwiftGmp?
    public var maxOutputLength: Int
    public var decimalSeparator: DecimalSeparator = .dot
    public var separateGroups: Bool = false
    public init(precision: Int, maxOutputLength: Int = 12) {
        self.maxOutputLength = maxOutputLength
        token = Token(precision: precision)
        displayBuffer = ""
    }
    public func setPrecision(newPrecision: Int) {
        token.setPrecision(newPrecision)
    }
    
    public var isAllowedOperator: [String: Bool] = [:]
    public var isPendingOperator: [String: Bool] = [:]
    public var allOperationsSorted: [any OpProtocol] { token.allOperationsSorted }
    var invalidOperators: [any OpProtocol] {
        var ret: [any OpProtocol] = []
        for op in allOperationsSorted {
            if let allowed = isAllowedOperator[op.getRawValue()] {
                if !allowed { ret.append(op) }
            }
        }
        return ret
    }

    var pendingOperators: [any OpProtocol] {
        var ret: [any OpProtocol] = []
        for op in allOperationsSorted {
            if let pending = isPendingOperator[op.getRawValue()] {
                if pending { ret.append(op) }
            }
        }
        return ret
    }

    public func press(_ op: any OpProtocol) {
        if let digitOp = op as? DigitOperation {
            if !token.numberExpected {
                assert(token.tokens.count > 0)
                token.removeLastSwiftGmp()
            }
            if digitOp == .dot {
                if displayBuffer.contains(DecimalSeparator.dot.rawValue) { return }
                if displayBuffer == "" {
                    displayBuffer = "0" + DecimalSeparator.dot.rawValue
                } else {
                    displayBuffer.append(digitOp.rawValue)
                }
            } else {
                displayBuffer.append(digitOp.rawValue)
            }
        } else if let memOp = op as? MemoryOperation {
            switch memOp {
            case .recallM:
                guard let memory = self.memory else { return }
                displayBuffer = ""
                token.newToken(memory)
            case .addToM:
                if !displayBuffer.isEmpty { displayToToken() }
                guard let last = token.lastSwiftGmp else { return }
                if self.memory == nil {
                    self.memory = last
                } else {
                    let mutableMemory = self.memory!.copy()
                    mutableMemory.execute(.add, other: last)
                    self.memory = mutableMemory.copy()
                }
            case .subFromM:
                if !displayBuffer.isEmpty { displayToToken() }
                guard let last = token.lastSwiftGmp else { return }
                if self.memory == nil {
                    self.memory = last
                } else {
                    let mutableMemory = self.memory!.copy()
                    mutableMemory.execute(TwoOperantOperation.sub, other: last)
                    self.memory = mutableMemory.copy()
                }
            case .clearM:
                memory = nil
            }
        } else if let constOp = op as? ConstantOperation {
            displayBuffer = ""
            token.newToken(constOp)
        } else if let inPlaceOp = op as? InplaceOperation {
            guard inPlaceAllowed else { return }
            if let last = token.lastSwiftGmp {
                last.execute(inPlaceOp)
            } else {
                fatalError("last token not a SwiftGmp")
            }
        } else if let _ = op as? ClearOperation {
            token.clear()
            displayBuffer = ""
        } else if let _ = op as? EqualOperation {
            if !token.tokens.isEmpty {
                displayToToken()
                token.shuntingYard()
                token.evaluatePostfix()
            }
        } else if let _ = op as? PercentOperation {
            displayToToken()
            token.percent()
        } else if let twoOperantOp = op as? TwoOperantOperation {
            displayToToken()
            if !token.tokens.isEmpty {
                if case .twoOperant = token.tokens.last {
                    token.tokens.removeLast()
                }
            }
            token.newToken(twoOperantOp)
            token.shuntingYard()
            token.evaluatePostfix()
        } else {
            fatalError("Unsupported operation")
        }

        for op in token.allOperationsSorted {
            isAllowedOperator[op.getRawValue()] = true
            isPendingOperator[op.getRawValue()] = false
        }
        for t in token.tokens {
            if case .inPlace(let op) = t {
                isPendingOperator[op.getRawValue()] = true
            }
            if case .twoOperant(let op) = t {
                isPendingOperator[op.getRawValue()] = true
            }
        }
        if let last = token.lastSwiftGmp {
            if !last.isValid {
                for op in token.allOperationsSorted {
                    if op.requiresValidNumber {
                        isAllowedOperator[op.getRawValue()] = false
                    }
                }
            }
        }
    }
    
    func displayToToken() {
        if !displayBuffer.isEmpty {
            let swiftGmp = SwiftGmp(withString: displayBuffer.replacingOccurrences(of: ",", with: "."), bits: token.generousBits(for: token.precision))
            token.newToken(swiftGmp)
            displayBuffer = ""
        }
    }
    private var inPlaceAllowed: Bool {
        displayToToken()
        return token.lastSwiftGmp != nil
    }

    public func evaluate() {
        displayToToken()
        guard !token.tokens.isEmpty else { return }
        token.shuntingYard()
        token.evaluatePostfix()
    }
    
    func withSeparators(_ s: String) -> String {
        var ret = s
        if decimalSeparator != .dot {
            ret = ret.replacingOccurrences(of: DecimalSeparator.dot.rawValue, with: decimalSeparator.rawValue)
        }
        ret = injectGrouping(numberString: ret, decimalSeparator: decimalSeparator, separateGroups: separateGroups)
        return ret
    }
    public func addSeparators(lr: LR) -> LR {
        var lr = lr
        lr.left = withSeparators(lr.left)
        return lr
    }
    public var lrWithSeparators: LR {
        addSeparators(lr: lr)
    }
    public var lr: LR {
        if !displayBuffer.isEmpty {
            let parts = displayBuffer.split(separator: decimalSeparator.rawValue)
            if parts.count == 1 {
                // Integer
                if displayBuffer.count <= maxOutputLength {
                    return LR(displayBuffer)
                }
            } else if parts.count == 2 {
                // float
                if parts[0].count <= maxOutputLength - 2 { // minimum dot and one digit
                    return LR(String(displayBuffer.prefix(maxOutputLength)))
                }
            }
            // convert displaybuffer to swiftGmp and return that
            // keep the content of the displaBuffer
            let temp = SwiftGmp(withString: displayBuffer, bits: token.generousBits(for: token.precision))
            let (mantissa, exponent) = temp.mantissaExponent(len: 2*maxOutputLength)
            let R = Representation(mantissa: mantissa, exponent: exponent)
            return R.leftRight(maxOutputLength: maxOutputLength)
        }
        guard let last = token.lastSwiftGmp else {
            // displayBuffer is empty and no swiftGmp in tokens --> after clean(), revert to "0"
            return LR("0")
        }
        if last.isNan {
            return LR("not a number")
        }
        if last.isInf {
            if last.isNegative() {
                return LR("-inf")
            } else {
                return LR("inf")
            }
        }

        if last.isZero {
            return LR("0")
        }

        let mantissaLength: Int = token.precision // approximation: accept integers with length = precision
        let (mantissa, exponent) = last.mantissaExponent(len: mantissaLength)
        let R = Representation(mantissa: mantissa, exponent: exponent)
        return R.leftRight(maxOutputLength: maxOutputLength)
    }
    
    public func evaluateString(_ expression: String) -> LR {
        displayBuffer = ""
        var trimmedExpression = expression.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedExpression.hasSuffix("=") {
            trimmedExpression = String(trimmedExpression.dropLast())
        }
        trimmedExpression = expression.trimmingCharacters(in: .whitespacesAndNewlines)

        do {
            try token.stringToTokenArray(trimmedExpression)
            token.shuntingYard()
            token.evaluatePostfix()
            let lr = lr
            return addSeparators(lr: lr)
        } catch {
            return LR(error.localizedDescription)
        }
    }
    
    public func asDouble(_ expression: String) -> Double {
        let lr = evaluateString(expression)
        if let d = Double(lr.string) {
            return d
        } else {
            return Double.nan
        }
    }
}

extension Double {
    public func similarTo(_ other: Double, precision: Double = 1e-3) -> Bool {
        if abs(self) > 1000 {
            return abs(self - other) <= precision * abs(self)
        } else {
            return abs(self - other) <= precision
        }
    }
}
