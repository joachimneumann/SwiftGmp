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
        displayBuffer = "0"
    }
    public func setPrecision(newPrecision: Int) {
        token.setPrecision(newPrecision)
    }

    public func press(_ digit: DigitOperation) {
        if !token.numberExpected {
            assert(token.tokens.count > 0)
            token.removeLastSwiftGmp()
        }
        if displayBuffer == "0" || displayBuffer == "" {
            displayBuffer = digit.rawValue
        } else {
            displayBuffer.append(digit.rawValue)
        }
    }
    
    public func memory(_ m: MemoryOperation) -> Bool {
        switch m {
        case .recall:
            guard let memory = self.memory else { return false }
            displayBuffer = ""
            token.newToken(memory)
            return true
        case .add:
            if !displayBuffer.isEmpty { displayToToken() }
            guard let last = token.lastSwiftGmp else { return false }
            if self.memory == nil {
                self.memory = last
            } else {
                let mutableMemory = self.memory!.copy()
                mutableMemory.execute(TwoOperantOperation.add, other: last)
                self.memory = mutableMemory.copy()
            }
            return true
        case .sub:
            if !displayBuffer.isEmpty { displayToToken() }
            guard let last = token.lastSwiftGmp else { return false }
            if self.memory == nil {
                self.memory = last
            } else {
                let mutableMemory = self.memory!.copy()
                mutableMemory.execute(TwoOperantOperation.sub, other: last)
                self.memory = mutableMemory.copy()
            }
            return true
        case .clear:
            memory = nil
            return true
        }
    }

    public func press(_ constant: ConstantOperation) {
        displayBuffer = ""
        token.newToken(constant)
    }
    private func displayToToken() {
        if !displayBuffer.isEmpty {
            token.newSwiftGmpToken(displayBuffer)
        }
        displayBuffer = ""
    }
    private var inPlaceAllowed: Bool {
        displayToToken()
        return token.lastSwiftGmp != nil
    }
    public func operate(_ inPlace: InplaceOperation) -> Bool {
        guard inPlaceAllowed else { return false }
        if let last = token.lastSwiftGmp {
            last.execute(inPlace)
        } else {
            fatalError("last token not a SwiftGmp")
        }
        return true
    }
    
    public func operate(_ twoOperant: TwoOperantOperation) -> Bool {
        displayToToken()
        token.newToken(twoOperant)
        return true
    }
    
    public func evaluate() {
        displayToToken()
        guard !token.tokens.isEmpty else { return }
        token.shuntingYard()
        token.evaluatePostfix()
    }

    public func clear() {
        token.clear()
        displayBuffer = ""
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
