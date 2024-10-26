//
//  Calculator.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 27.09.24.
//

import Foundation

public class Calculator {
    
    var token: Token
    var display: Display = Display(
        raw: Raw(mantissa: "0", exponent: 0),
        displayLength: 10, decimalSeparator: DecimalSeparator.dot.character)
    
    private var privateDisplayBuffer: String
    private var privateZombieDisplayBuffer: String? = nil
    private var memory: SwiftGmp?
    
    public var displayWidth: Int
    
    public var length: (String) -> Int = { s in
        s.count
    }
    public var displayBufferExponentLength: (String) -> Int = { s in
        s.count
    }

    public var displayBuffer: String {
        if let ret = privateZombieDisplayBuffer { return ret }
        return privateDisplayBuffer
    }

//    public var R: Representation
    public init(precision: Int, displayWidth: Int = 10) {
        token = Token(precision: precision)
        privateDisplayBuffer = ""
//        R = Representation(length: length, displayBifferExponentLength: displayBifferExponentLength)
        self.displayWidth = displayWidth
    }
    
    public var privateDisplayBufferHasDigits: Bool {
        !privateDisplayBuffer.isEmpty
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
        privateDisplayBuffer = ""
        for op in token.allOperationsSorted {
            isAllowedOperator[op.getRawValue()] = true
            pendingOperators = []
        }
    }
    
    public func press(_ op: any OpProtocol) {
        if let _ = op as? TwoOperantOperation {
            privateZombieDisplayBuffer = displayBuffer
        } else {
            privateZombieDisplayBuffer = nil
        }
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
            privateDisplayBuffer = ""
            token.newToken(constOp)
        } else if let digitOp = op as? DigitOperation {
            if !token.numberExpected {
                assert(token.tokens.count > 0)
                token.removeLastSwiftGmp()
            }
            if digitOp == .zero {
                if privateDisplayBuffer == "0" {
                    // ignore the zero
                    return
                }
                if privateDisplayBuffer == "" {
                    privateDisplayBuffer = "0"
                    return
                }
            }
            if digitOp == .dot {
                if privateDisplayBuffer.contains(".") { return }
                if privateDisplayBuffer == "" {
                    privateDisplayBuffer = "0."
                } else {
                    privateDisplayBuffer.append(digitOp.rawValue)
                }
            } else {
                privateDisplayBuffer.append(digitOp.rawValue)
            }
        } else if let memOp = op as? MemoryOperation {
            switch memOp {
            case .recallM:
                guard let memory = self.memory else { return }
                privateDisplayBuffer = ""
                token.newToken(memory)
            case .addToM:
                if !privateDisplayBuffer.isEmpty { displayBufferToToken() }
                guard let last = token.lastSwiftGmp else { return }
                if self.memory == nil {
                    self.memory = last
                } else {
                    let mutableMemory = self.memory!.copy()
                    mutableMemory.execute(.add, other: last)
                    self.memory = mutableMemory.copy()
                }
            case .subFromM:
                if !privateDisplayBuffer.isEmpty { displayBufferToToken() }
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
                privateDisplayBuffer.removeLast()
                if privateDisplayBuffer == "0" {
                    privateDisplayBuffer = ""
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
        if !privateDisplayBuffer.isEmpty {
            let swiftGmp = SwiftGmp(withString: privateDisplayBuffer.replacingOccurrences(of: ",", with: "."), bits: token.generousBits(for: token.precision))
            token.newToken(swiftGmp)
            privateDisplayBuffer = ""
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
        privateDisplayBuffer = ""
        do {
            let opArray = try token.stringToPressCommands(expression)
            press(ClearOperation.clear)
            for op in opArray {
                press(op)
            }
            press(EqualOperation.equal)
        } catch {
            token.clear()
            privateDisplayBuffer = error.localizedDescription
        }
        if !privateDisplayBuffer.isEmpty {
            let asSubSequence = privateDisplayBuffer.prefix(displayWidth)
            display = Display(String(asSubSequence))
        } else {
            if let swiftGmp = token.lastSwiftGmp {
                let raw = swiftGmp.raw(digits: 10)
                display = Display(raw: raw, displayLength: 10, decimalSeparator: ".")
            }
        }
    }
    
    public var string: String {
        var asSubSequence: String.SubSequence
        if !privateDisplayBuffer.isEmpty {
            asSubSequence = privateDisplayBuffer.prefix(displayWidth)
            return String(asSubSequence)
        } else {
            if let swiftGmp = token.lastSwiftGmp {
                let raw = swiftGmp.raw(digits: 10)
                let display = Display(raw: raw, displayLength: 10, decimalSeparator: ".")
                return display.string
            }
        }
        return "0"
    }
    
    public var double: Double {
        if !privateDisplayBuffer.isEmpty {
            return Double(privateDisplayBuffer) ?? Double.nan
        } else {
            return token.lastSwiftGmp?.toDouble() ?? 0
        }
    }
    
    public var raw: Raw {
        let temp: SwiftGmp
        if !privateDisplayBuffer.isEmpty {
            temp = SwiftGmp(withString: privateDisplayBuffer.replacingOccurrences(of: ",", with: "."), bits: token.generousBits(for: token.precision))
        } else {
            temp = token.lastSwiftGmp!
        }
        return temp.raw(digits: displayWidth)
    }

}

extension Double {
    public func similar(to other: Double, precision: Double = 1e-5) -> Bool {
        if abs(self) > 1000 {
            return abs(self - other) <= precision * abs(self)
        } else if abs(self) > 1 {
            return abs(self - other) <= precision
        } else {
            return abs(self - other) <= precision * 0.1
        }
    }
}
