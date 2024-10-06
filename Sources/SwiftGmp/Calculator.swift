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
    public var maxOutputLength: Int? = nil
    public init(precision: Int) {
        token = Token(precision: precision)
        displayBuffer = ""
    }
    public func setPrecision(newPrecision: Int) {
        token.setPrecision(newPrecision)
    }

    public func press(_ op: OpProtocol) {
        if let digitOp = op as? DigitOperation {
            if !token.numberExpected {
                assert(token.tokens.count > 0)
                token.removeLastSwiftGmp()
            }
            if displayBuffer == "0" || displayBuffer == "" {
                displayBuffer = digitOp.rawValue
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
            token.shuntingYard()
            token.evaluatePostfix()
        } else if let _ = op as? PercentOperation {
            displayToToken()
            token.percent()
        } else if let twoOperantOp = op as? TwoOperantOperation {
            displayToToken()
            token.newToken(twoOperantOp)
        } else {
            fatalError("Unsupported operation")
        }
    }
    
    func displayToToken() {
        if !displayBuffer.isEmpty {
            token.newSwiftGmpToken(displayBuffer.replacingOccurrences(of: ",", with: "."))
        }
        displayBuffer = ""
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
    
    public var lr: LR {
        if !displayBuffer.isEmpty {
            return LR(displayBuffer)
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
        return R.leftRight(maxOutputLength: maxOutputLength ?? 10)
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
            return lr
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
