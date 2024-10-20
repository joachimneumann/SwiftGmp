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
    public var separateGroups: Bool = true
    public var maxOutputLength: Int
    
    public init(precision: Int, maxOutputLength: Int = 12) {
        token = Token(precision: precision)
        self.maxOutputLength = maxOutputLength
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
            displayBufferToToken()
            
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
            displayBufferToToken()
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
                if displayBuffer.contains(".") { return }
                if displayBuffer == "" {
                    displayBuffer = "0."
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
                if !displayBuffer.isEmpty { displayBufferToToken() }
                guard let last = token.lastSwiftGmp else { return }
                if self.memory == nil {
                    self.memory = last
                } else {
                    let mutableMemory = self.memory!.copy()
                    mutableMemory.execute(.add, other: last)
                    self.memory = mutableMemory.copy()
                }
            case .subFromM:
                if !displayBuffer.isEmpty { displayBufferToToken() }
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
                if !last.isZero || !op.isEqual(to: InplaceOperation.changeSign) {
                    last.execute(inPlaceOp)
                }
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
            displayBufferToToken()
            token.percent()
        } else if let parenthesis = op as? ParenthesisOperation {
            switch parenthesis {
            case .left:
                token.newTokenParenthesesLeft()
            case .right:
                displayBufferToToken()
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
    
    func displayBufferToToken() {
        if !displayBuffer.isEmpty {
            let swiftGmp = SwiftGmp(withString: displayBuffer.replacingOccurrences(of: ",", with: "."), bits: token.generousBits(for: token.precision))
            token.newToken(swiftGmp)
            displayBuffer = ""
        }
    }
    private var inPlaceAllowed: Bool {
        displayBufferToToken()
        return token.lastSwiftGmp != nil
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

    public func evaluateString(_ expression: String) {
        displayBuffer = ""
        do {
            let opArray = try token.stringToPressCommands(expression)
            press(ClearOperation.clear)
            for op in opArray {
                press(op)
            }
            press(EqualOperation.equal)
        } catch {
            token.clear()
            displayBuffer = error.localizedDescription
        }
    }
    
    public var string: String {
        var asSubSequence: String.SubSequence
        var asString: String
        let asDouble: Double
        if !displayBuffer.isEmpty {
            if displayBuffer.hasSuffix(".0") {
                displayBuffer = String(displayBuffer.dropLast(2))
            }
            asSubSequence = displayBuffer.prefix(maxOutputLength)
            return String(asSubSequence)
        } else {
            asDouble = token.lastSwiftGmp?.toDouble() ?? 0
            asString = String(asDouble)
            if asString.hasSuffix(".0") {
                asString = String(asString.dropLast(2))
            }
            if asString.contains(".") {
                // float or scientific
                let parts = asString.split(separator: ".")
                if parts[0].count >= maxOutputLength - 1 {
                    return "too large"
                }
                asSubSequence = asString.prefix(maxOutputLength)
                asString = String(asSubSequence)
                return asString
            } else {
                // Integer
                if asString.count > maxOutputLength {
                    return "too large"
                } else {
                    return asString
                }
            }
        }
    }
    
    public var double: Double {
        if !displayBuffer.isEmpty {
            return Double(displayBuffer) ?? Double.nan
        } else {
            return token.lastSwiftGmp?.toDouble() ?? 0
        }
    }
    
    public var mantissaExponent: MantissaExponent? {
        let temp: SwiftGmp?
        if !displayBuffer.isEmpty {
            temp = SwiftGmp(withString: displayBuffer.replacingOccurrences(of: ",", with: "."), bits: token.generousBits(for: token.precision))
        } else {
            temp = token.lastSwiftGmp
        }
        if temp == nil { return nil }

        return temp!.mantissaExponent(len: max(1000, maxOutputLength))
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
