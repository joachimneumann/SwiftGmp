//
//  Token.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 30.09.24.
//

import Foundation

enum TokenizerError: Error, LocalizedError {
    case unknownOperator(op: String)
    case invalidSwiftGmp(swiftGmp: SwiftGmp)
    case unprocessed(op: String)
    case unexpectedSwiftGmp(swiftGmp: SwiftGmp)
    case memoryEmpty
    
    var errorDescription: String? {
        switch self {
        case .unknownOperator(let op):
            return "Unknown operator: \(op)"
        case .invalidSwiftGmp(let swiftGmp):
            return "Invalid swiftGmp: \(swiftGmp)"
        case .unprocessed(let op):
            return "unknown: \(op)"
        case .memoryEmpty:
            return "memory empty"
        case .unexpectedSwiftGmp(let swiftGmp):
            return "unexpected swiftGmp: \(swiftGmp)"
        }
    }
}

extension Array {
    var secondLast: Element? {
        if count > 1 { return self[count - 2] }
        return nil
    }
}
extension Array {
    var thirdLast: Element? {
        if count > 2 { return self[count - 3] }
        return nil
    }
}

class Token {
    var tokens: [TokenEnum] = []
    var precision: Int

    enum TokenEnum: CustomDebugStringConvertible {
        var debugDescription: String {
            switch self {
            case .inPlace(let op):
                "\(op.getRawValue())"
            case .twoOperant(let op):
                "\(op.getRawValue())"
            case .swiftGmp(let s):
                String(s.toDouble())
            case .parenthesesLeft:
                "("
            case .parenthesesRight:
                ")"
            case .clear:
                "C"
            case .equal:
                "="
            case .percent:
                "%"
            }
        }
        
        case inPlace(InplaceOperation)       // sin, log, etc
        case clear
        case equal
        case percent
        case twoOperant(TwoOperantOperation) // +, -, *, /, x^y, etc
        case swiftGmp(SwiftGmp)                          // -5.3
        case parenthesesLeft
        case parenthesesRight
        
        var priority: Int {
            switch self {
            case .twoOperant(let op):
                if op == .mul || op == .div { return 2 } // Higher precedence for * and /
                return 1 // Lower precedence for + and -
            case .inPlace, .percent:
                return 3 // Highest precedence for in-place operators like sin, log
            case .parenthesesLeft, .parenthesesRight:
                return 0 // Parentheses control grouping, not direct precedence
            case .swiftGmp:
                return 4 // Constants should be directly evaluated
            case .clear:
                return 5
            case .equal:
                return 4
            }
        }
    }
//    
    func setPrecision(_ newPrecision: Int) {
        self.precision = newPrecision
        // TODO set bits
        for token in tokens {
            if case .swiftGmp(let swiftGmp) = token {
                swiftGmp.setBits(generousBits(for: newPrecision))
            }
        }
    }

    let allOperationsSorted: [OpProtocol]

    func clear() {
        tokens = []
    }
    
    func percent() {
//         this operation in an inplace operation, but if no number is found
//         it creates a zero out of thin air and then oerates on the zero.
        let _001 = SwiftGmp(withString: "0.01", bits: generousBits(for: precision))
        if let n1 = lastSwiftGmp {
            if let n2 = secondLastSwiftGmp {
                if let op = lastTwoOperant {
                    dropLastSwiftGmp()
                    dropLastSwiftGmp()
                    n1.execute(.mul, other: _001)
                    n1.execute(.mul, other: n2)
                    n1.execute(op, other: n2)
                    newToken(n1)
                }
            } else {
                n1.execute(.mul, other: _001)
            }
        }
    }
    
    init(precision: Int) {
        self.precision = precision
        let x1: [InplaceOperation] = InplaceOperation.allCases
        let x2: [TwoOperantOperation] = TwoOperantOperation.allCases
        let x3: [ConstantOperation] = ConstantOperation.allCases
        let x4: [ClearOperation] = ClearOperation.allCases
        let x5: [EqualOperation] = EqualOperation.allCases
        let x6: [ParenthesisOperation] = ParenthesisOperation.allCases
        let x7: [PercentOperation] = PercentOperation.allCases
        var allOperationsUnsorted: [OpProtocol] = []
        allOperationsUnsorted.append(contentsOf: x1)
        allOperationsUnsorted.append(contentsOf: x2)
        allOperationsUnsorted.append(contentsOf: x3)
        allOperationsUnsorted.append(contentsOf: x4)
        allOperationsUnsorted.append(contentsOf: x5)
        allOperationsUnsorted.append(contentsOf: x6)
        allOperationsUnsorted.append(contentsOf: x7)
        allOperationsSorted = allOperationsUnsorted.sorted { $0.getRawValue().count > $1.getRawValue().count }
    }
//    
    var numberExpected: Bool {
        guard !tokens.isEmpty else { return true }
        switch tokens.last! {
        case .inPlace(_):
            return false
        case .twoOperant(_):
            return true
        case .swiftGmp(_):
            return false
        case .parenthesesLeft:
            return true
        case .parenthesesRight:
            return false
        case .clear:
            return true
        case .equal:
            return true
        case .percent:
            return false
        }
        return false
    }

    var pendingOperators: [OpProtocol] {
        var ret: [OpProtocol] = []
        for token in tokens {
            if case .inPlace(let op) = token {
                ret.append(op)
            }
            if case .twoOperant(let op) = token {
                ret.append(op)
            }
        }
        return ret
    }
    
    var inPlaceAllowed: Bool {
        !numberExpected
    }
  
    func dropLastSwiftGmp() {
        guard !tokens.isEmpty else { return }
        
        // check from the end
        for index in stride(from: tokens.count - 1, through: 0, by: -1) {
            if case .swiftGmp(_) = tokens[index] {
                tokens.remove(at: index)
            }
        }
        return
    }
    
    var lastSwiftGmp: SwiftGmp? {
        guard !tokens.isEmpty else { return nil }
        
        // check from the end
        for index in stride(from: tokens.count - 1, through: 0, by: -1) {
            if case .swiftGmp(let last) = tokens[index] {
                return last
            }
        }
        return nil
    }

    var secondLastSwiftGmp: SwiftGmp? {
        guard !tokens.isEmpty else { return nil }
        
        // check from the end
        var oneFound = false
        for index in stride(from: tokens.count - 1, through: 0, by: -1) {
            if case .swiftGmp(let last) = tokens[index] {
                if oneFound {
                    return last
                } else {
                    oneFound = true
                }
            }
        }
        return nil
    }

    var lastTwoOperant: TwoOperantOperation? {
        guard !tokens.isEmpty else { return nil }
        
        // check from the end
        for index in stride(from: tokens.count - 1, through: 0, by: -1) {
            if case .twoOperant(let op) = tokens[index] {
                return op
            }
        }
        return nil
    }

    func removeLastSwiftGmp() {
        guard !tokens.isEmpty else { return }

        // check from the end
        for index in stride(from: tokens.count - 1, through: 0, by: -1) {
            if case .swiftGmp(_) = tokens[index] {
                tokens.remove(at: index)
                return
            }
        }
        return
    }

    func newToken(_ constant: ConstantOperation) {
        if numberExpected {
            let temp = SwiftGmp(withString: "0", bits: generousBits(for: precision))
            temp.execute(constant)
            tokens.append(.swiftGmp(temp))
        } else {
            if let last = lastSwiftGmp {
                last.execute(constant)
            } else {
                fatalError("Expected a number or a constant but found ")
            }
        }
    }
    
    func newToken(_ swiftGmp: SwiftGmp) {
        tokens.append(.swiftGmp(swiftGmp))
    }
    func newSwiftGmpToken(_ s: String) {
        tokens.append(.swiftGmp(SwiftGmp(withString: s, bits: generousBits(for: precision))))
    }

    func newToken(_ twoOperant: TwoOperantOperation) {
        tokens.append(.twoOperant(twoOperant))
    }
    
    func newTokenClear() {
        tokens.append(.clear)
    }
    func newTokenEqual() {
        tokens.append(.equal)
    }
    func newTokenPercent() {
        tokens.append(.percent)
    }

    func newToken(_ inPlace: InplaceOperation) {
        tokens.append(.inPlace(inPlace))
    }
    func newTokenParenthesesLeft() {
        tokens.append(.parenthesesLeft)
    }
    func newTokenParenthesesRight() {
        tokens.append(.parenthesesRight)
    }
    func generousBits(for precision: Int) -> Int {
        Int(Double(generousPrecision(for: precision)) * 3.32192809489)
    }
    func generousPrecision(for precision: Int) -> Int {
        return precision + 20
//        if precision <= 500 {
//            return 1000
//        } else if precision <= 10000 {
//            return 2 * precision
//        } else if precision <= 100000 {
//            return Int(round(1.5*Double(precision)))
//        } else {
//            return precision + 50000
//        }
    }

    func stringToTokenArray(_ input: String) throws {
        var numberBuffer: String = ""
        var index: String.Index = input.startIndex
        
        // Start with an empty token array
        clear()
        
        let inputEndIndex: String.Index = input.endIndex
        
        // Main loop to parse the input string
        while index < inputEndIndex {
            let char: Character = input[index]
            
            // Check if the character is part of a number
            if char.isNumber || char == "." || (char == "e" && !numberBuffer.isEmpty) || (char == "-" && numberBuffer.last == "e") {
                // Append characters that are part of a number (including scientific notation)
                numberBuffer.append(char)
            }
            // Check for whitespace
            else if char.isWhitespace {
                if !numberBuffer.isEmpty {
                    let tokenValue: SwiftGmp = SwiftGmp(withString: numberBuffer, bits: generousBits(for: precision))
                    newToken(tokenValue)
                    numberBuffer = ""
                }
            }
            // Ignore '=' character for now
            else if char == "=" {
                // Do nothing
            }
            // Handle '-' character
            else if char == "-" {
                var unaryMinus: Bool = numberExpected
                let remainingCharsCount: Int = input.distance(from: index, to: inputEndIndex)
                let nextIndex: String.Index = input.index(after: index)
                
                // Ensure nextIndex is within bounds
                if remainingCharsCount > 1, nextIndex < inputEndIndex {
                    let afterMinus: Character = input[nextIndex]
                    if afterMinus == " " {
                        unaryMinus = false
                    }
                }
                
                if unaryMinus {
                    // Unary minus (e.g., -5)
                    numberBuffer.append(char)
                } else {
                    // Subtraction operator
                    if !numberBuffer.isEmpty {
                        let tokenValue: SwiftGmp = SwiftGmp(withString: numberBuffer, bits: generousBits(for: precision))
                        newToken(tokenValue)
                        numberBuffer = ""
                    }
                    newToken(TwoOperantOperation.sub)
                }
            }
            // Handle operators and parentheses
            else {
                var opFound: Bool = false
                let inputSlice: Substring = input[index...]
                
                for op in allOperationsSorted {
                    let opRawValue: String = op.getRawValue()
                    
                    if inputSlice.hasPrefix(opRawValue) {
                        opFound = true
                        
                        if !numberBuffer.isEmpty {
                            let tokenValue: SwiftGmp = SwiftGmp(withString: numberBuffer, bits: generousBits(for: precision))
                            newToken(tokenValue)
                            numberBuffer = ""
                        }
                        
                        // Add the corresponding token based on the operation type
                        if let inPlace = op as? InplaceOperation {
                            newToken(inPlace)
                        } else if let _ = op as? PercentOperation {
                            self.percent()
                        } else if let constant = op as? ConstantOperation {
                            newToken(constant)
                        } else if let twoOperant = op as? TwoOperantOperation {
                            newToken(twoOperant)
                        } else if opRawValue == "(" {
                            newTokenParenthesesLeft()
                        } else if opRawValue == ")" {
                            newTokenParenthesesRight()
                        } else {
                            throw TokenizerError.unknownOperator(op: opRawValue)
                        }
                        
                        // Advance the index by the length of the operator minus one (since we'll increment it at the end of the loop)
                        index = input.index(index, offsetBy: opRawValue.count - 1)
                        break // Exit the loop since we found a matching operator
                    }
                }
                
                if !opFound {
                    var failedCandidate: String = String(inputSlice)
                    if let spaceIndex = failedCandidate.firstIndex(of: " ") {
                        failedCandidate = String(failedCandidate[..<spaceIndex])
                    }
                    throw TokenizerError.unknownOperator(op: failedCandidate)
                }
            }
            
            // Move to the next character
            index = input.index(after: index)
        }
        
        // If there's any remaining number in the buffer, add it as a token
        if !numberBuffer.isEmpty {
            let tokenValue: SwiftGmp = SwiftGmp(withString: numberBuffer, bits: generousBits(for: precision))
            newToken(tokenValue)
        }
    }
    
    func shuntingYard() {
        var output: [TokenEnum] = []
        var operatorStack: [TokenEnum] = []
        
        var lastOperatorWasTwoOperant: Bool = false
        for token in tokens {
            switch token {
            case .swiftGmp, .inPlace:
                output.append(token) // Directly add constants and in-place operators to output
                lastOperatorWasTwoOperant = false
            case .twoOperant:
                while let top = operatorStack.last, top.priority >= token.priority {
                    if lastOperatorWasTwoOperant {
                        operatorStack.removeLast() // remove the last one from the output
                    } else {
                        output.append(operatorStack.removeLast()) // Pop from operator stack to output
                    }
                }
                operatorStack.append(token) // Push current operator onto the stack
                lastOperatorWasTwoOperant = true
            case .parenthesesLeft:
                operatorStack.append(token) // Push '(' onto the stack
                lastOperatorWasTwoOperant = false
            case .parenthesesRight:
                var stillLooking = true
                while stillLooking, let top = operatorStack.last {
                    if case .parenthesesLeft = top {
                        stillLooking = false
                    } else {
                        output.append(operatorStack.removeLast()) // Pop until '(' is found
                    }
                }
                _ = operatorStack.popLast() // Remove the '('
                lastOperatorWasTwoOperant = false
            case .clear:
                break
            case .equal:
                break
            case .percent:
                break
            }
        }
        
        while !operatorStack.isEmpty {
            output.append(operatorStack.removeLast()) // Append remaining operators
        }
        
        tokens = output
    }
    
    func evaluatePostfix() {
        var stack: [SwiftGmp] = []
        
        while tokens.count > 0 {
            let token = tokens.first
            tokens.removeFirst()
            switch token {
            case .swiftGmp(let swiftGmp):
                stack.append(swiftGmp) // Push constants to the stack
            case .inPlace(let operation):
                if let swiftGmp = stack.popLast() {
                    swiftGmp.execute(operation)
                    stack.append(swiftGmp) // Apply in-place operator
                }
            case .twoOperant(let operation):
                if stack.count >= 2 {
                    if let rhs = stack.popLast(), let lhs = stack.popLast() {
                        lhs.execute(operation, other: rhs)
                        stack.append(lhs) // Apply binary operator
                    }
                }
            default:
                break
            }
        }
        if tokens.isEmpty {
            // something went wrong
            if !stack.isEmpty {
                newToken(stack.last!)
            } else {
                fatalError("Empty tokens after evaluation")
            }
        }
    }
    
}

