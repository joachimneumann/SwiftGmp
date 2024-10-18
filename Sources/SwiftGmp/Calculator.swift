//
//  Calculator.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 27.09.24.
//

import Foundation

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
    public var displayBufferHasDigits: Bool {
        !displayBuffer.isEmpty
    }
    public func setPrecision(newPrecision: Int) {
        token.setPrecision(newPrecision)
    }
    
    public var isAllowedOperator: [String: Bool] = [:]
    public var pendingOperators: [any OpProtocol] = []
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

    public func clear() {
        token.clear()
        displayBuffer = ""
        for op in token.allOperationsSorted {
            isAllowedOperator[op.getRawValue()] = true
            pendingOperators = []
        }
    }
    
    public func press(_ op: any OpProtocol) {
        if let twoOperantOp = op as? TwoOperantOperation {
            displayToToken()
            // was the previous token also a TwoOperantOperation?
            // if yes, overwrite that one!
            
            if !token.tokens.isEmpty {
                if case .twoOperant = token.tokens.last!.tokenEnum {
                    token.tokens.removeLast()
                }
            }
            token.newToken(twoOperantOp)
            token.walkThroughTokens(tokens: &token.tokens)
        } else if let _ = op as? EqualOperation {
            displayToToken()
            if !token.tokens.isEmpty {
                token.walkThroughTokens(tokens: &token.tokens)
                // cleaning up
                while token.tokens.count > 1 {
                    token.tokens.removeLast()
                }
            }
        } else if let constOp = op as? ConstantOperation {
            displayBuffer = ""
            token.newToken(constOp)
        } else if let digitOp = op as? DigitOperation {
            if !token.numberExpected {
                assert(token.tokens.count > 0)
                token.removeLastSwiftGmp()
            }
            if digitOp == .zero {
                if displayBuffer == "0" {
                    // ignore the zero
                    return
                }
                if displayBuffer.isEmpty {
                    displayBuffer = "0"
                    return
                }
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
        } else if let inPlaceOp = op as? InplaceOperation {
            guard inPlaceAllowed else { return }
            if let last = token.lastSwiftGmp {
                last.execute(inPlaceOp)
            } else {
                fatalError("last token not a SwiftGmp")
            }
        } else if let clearOperation = op as? ClearOperation {
            switch clearOperation {
            case .clear:
                clear()
            case .back:
                displayBuffer.removeLast()
                if displayBuffer == "0" {
                    displayBuffer = ""
                }
            }
        } else if let _ = op as? PercentOperation {
            displayToToken()
            token.percent()
        } else if let parenthesis = op as? ParenthesisOperation {
            switch parenthesis {
            case .left:
                token.newTokenParenthesesLeft()
            case .right:
                displayToToken()
                token.newTokenParenthesesRight()
                token.walkThroughTokens(tokens: &token.tokens)
            }
        } else {
            fatalError("Unsupported operation")
        }
        
        pendingOperators = []
        for op in token.allOperationsSorted {
            isAllowedOperator[op.getRawValue()] = true
        }
        for t in token.tokens {
            if case .twoOperant(let op) = t.tokenEnum {
                pendingOperators.append(op)
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

    public var localisedR: Representation {
        var tempR = R
        if tempR.mantissa != nil {
            tempR.mantissa = tempR.localizedMantissa(decimalSeparator: decimalSeparator, separateGroups: separateGroups)
        }
        return tempR
    }
    public var R: Representation {
        var tempR = Representation()
        if !displayBuffer.isEmpty {
            let parts = displayBuffer.split(separator: decimalSeparator.rawValue)
            if parts.count == 1 {
                // Integer
                if displayBuffer.count <= maxOutputLength {
                    tempR.mantissa = displayBuffer
                    return tempR
                }
            } else if parts.count == 2 {
                // float
                if parts[0].count <= maxOutputLength - 2 { // minimum dot and one digit
                    tempR.mantissa = String(displayBuffer.prefix(maxOutputLength))
                    return tempR
                }
            }
            // convert displaybuffer to swiftGmp and return that
            // keep the content of the displaBuffer
            let temp = SwiftGmp(withString: displayBuffer, bits: token.generousBits(for: token.precision))
            let (mantissa, exponent) = temp.mantissaExponent(len: 2*maxOutputLength)
            return Representation(mantissa: mantissa, exponent: exponent, maxOutputLength: maxOutputLength)
        }
        guard let last = token.lastSwiftGmp else {
            // displayBuffer is empty and no swiftGmp in tokens --> after clean(), revert to "0"
            tempR.mantissa = "0"
            return tempR
        }
        if last.isNan {
            tempR.error = "not a number"
            return tempR
        }
        if last.isInf {
            if last.isNegative() {
                tempR.error = "-inf"
                return tempR
            } else {
                tempR.error = "inf"
                return tempR
            }
        }

        if last.isZero {
            tempR.mantissa = "0"
            return tempR
        }

        let mantissaLength: Int = token.precision // approximation: accept integers with length = precision
        let (mantissa, exponent) = last.mantissaExponent(len: mantissaLength)
        tempR = Representation(mantissa: mantissa, exponent: exponent, maxOutputLength: maxOutputLength)
        return tempR
    }
    
    public func evaluateString(_ expression: String) -> Representation {
        displayBuffer = ""
        do {
            let opArray = try token.stringToPressCommands(expression)
            press(ClearOperation.clear)
            for op in opArray {
                press(op)
            }
            press(EqualOperation.equal)
            return R
        } catch {
            return Representation(error: error.localizedDescription)
        }
    }
    
    public var localizedString: String {
        var tempR = R
        tempR.mantissa = R.localizedMantissa(decimalSeparator: decimalSeparator, separateGroups: separateGroups)
        return tempR.string
    }
    
    public var double: Double {
        R.double
    }
    public var string: String {
        R.string
    }

    func asSwiftGmp(_ expression: String) -> SwiftGmp {
        do {
            let opArray = try token.stringToPressCommands(expression)
            press(ClearOperation.clear)
            for op in opArray {
                press(op)
            }
            press(EqualOperation.equal)
            if let last = token.lastSwiftGmp {
                return last
            }
        } catch {
        }
        return SwiftGmp(bits: token.generousBits(for: token.precision)) // nan
    }

}

extension Double {
    
    public func similar(to other: Double, precision: Double = 1e-3) -> Bool {
        if abs(self) > 1000 {
            return abs(self - other) <= precision * abs(self)
        } else {
            return abs(self - other) <= precision
        }
    }
}
