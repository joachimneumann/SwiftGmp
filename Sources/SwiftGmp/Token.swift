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
    private var precision: Int

    enum TokenEnum: CustomDebugStringConvertible {
        var debugDescription: String {
            switch self {
            case .inPlace(let op):
                "inPlace \(op)"
            case .percent:
                "op percent"
            case .twoOperant(let op):
                "twoOperant \(op)"
            case .swiftGmp(let s):
                String(s.toDouble())
            case .parenthesesLeft:
                "op ("

            case .parenthesesRight:
                "op )"
            }
        }
        
        case inPlace(SwiftGmpInplaceOperation)       // sin, log, etc
        case percent                                 // %
        case twoOperant(SwiftGmpTwoOperantOperation) // +, -, *, /, x^y, etc
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
            }
        }
    }
    
    func setPrecision(_ newPrecision: Int) {
        self.precision = newPrecision
        /// TODO set bits
//        for token in tokens {
//            if case .swiftGmp(let swiftGmp) = token {
//                swiftGmp.setBits(generousBits(for: newPrecision))
//            }
//        }
    }

    let allOperationsSorted: [OpProtocol]

    func clear() {
        tokens = []
    }
    init(precision: Int) {
        self.precision = precision
        let allOperations: [OpProtocol] =
        SwiftGmpInplaceOperation.allCases +
        SwiftGmpTwoOperantOperation.allCases +
        SwiftGmpParenthesisOperation.allCases +
        SwiftGmpConstantOperation.allCases
        allOperationsSorted = allOperations.sorted { $0.getRawValue().count > $1.getRawValue().count }
    }
    
    var numberExpected: Bool {
        guard !tokens.isEmpty else { return true }
        switch tokens.last! {
        case .inPlace(_):
            return false
        case .percent:
            return false
        case .twoOperant(_):
            return true
        case .swiftGmp(_):
            return false
        case .parenthesesLeft:
            return true
        case .parenthesesRight:
            return false
        }
    }
    
    var inPlaceAllowed: Bool {
        !numberExpected
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

    
    func newToken(_ constant: SwiftGmpConstantOperation) {
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

    func newToken(_ twoOperant: SwiftGmpTwoOperantOperation) {
        tokens.append(.twoOperant(twoOperant))
    }
    
    func newToken(_ inPlace: SwiftGmpInplaceOperation) {
        tokens.append(.inPlace(inPlace))
    }
    func newTokenPercent() {
        tokens.append(.percent)
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
        var numberBuffer = ""
        var index = input.startIndex
        
        // start with empty token array
        clear()
        
        while index < input.endIndex {
            let char = input[index]
            
            if char.isNumber || char == "." || (char == "e" && !numberBuffer.isEmpty) || (char == "-" && numberBuffer.last == "e") {
                // Append characters that are part of a number (including scientific notation)
                numberBuffer.append(char)
            } else if char.isWhitespace {
                if !numberBuffer.isEmpty {
                    newToken(SwiftGmp(withString: numberBuffer, bits: generousBits(for: precision)))
                    numberBuffer = ""
                }
            } else if char == "=" {
                // Ignore for now
            } else if char == "-" {
                var unaryMinus = numberExpected
                let count = input[index...].count
                let nextIndex = input.index(index, offsetBy: 1)
                let afterMinus: Character = input[nextIndex]
                if count > 1 && afterMinus == " " {
                    unaryMinus = false
                }
                
                if unaryMinus {
                    numberBuffer.append(char) // unary minus (e.g., -5)
                } else {
                    if !numberBuffer.isEmpty {
                        newToken(SwiftGmp(withString: numberBuffer, bits: generousBits(for: precision)))
                        numberBuffer = ""
                    }
                    newToken(SwiftGmpTwoOperantOperation.sub) // subtraction operator
                }
            } else if char == "%" {
                if !numberBuffer.isEmpty {
                    newToken(SwiftGmp(withString: numberBuffer, bits: generousBits(for: precision)))
                    numberBuffer = ""
                }
                newTokenPercent()
            } else {
                var opFound = false
                for op in allOperationsSorted {
                    if !opFound && input[index...].hasPrefix(op.getRawValue()) {
                        opFound = true
                        if !numberBuffer.isEmpty {
                            newToken(SwiftGmp(withString: numberBuffer, bits: generousBits(for: precision)))
                            numberBuffer = ""
                        }
                        if let inPlace = op as? SwiftGmpInplaceOperation {
                            newToken(inPlace)
                        } else if let constant = op as? SwiftGmpConstantOperation {
                            newToken(constant)
                        } else if let twoOperant = op as? SwiftGmpTwoOperantOperation {
                            newToken(twoOperant)
                        } else if op.getRawValue() == "(" {
                            newTokenParenthesesLeft()
                        } else if op.getRawValue() == ")" {
                            newTokenParenthesesRight()
                        } else {
                            throw TokenizerError.unknownOperator(op: op.getRawValue())
                        }
                        index = input.index(index, offsetBy: op.getRawValue().count - 1)
                    }
                }
                if !opFound {
                    var failedCandidate: String = String(input[index...])
                    if failedCandidate.contains(" ") {
                        failedCandidate = String(failedCandidate.split(separator: " ").first!)
                    }
                    throw(TokenizerError.unknownOperator(op: failedCandidate))
                }
            }
            index = input.index(after: index)
        }
        
        if !numberBuffer.isEmpty {
            newToken(SwiftGmp(withString: numberBuffer, bits: generousBits(for: precision)))
            numberBuffer = ""
        }
    }
    
    func shuntingYard() {
        var output: [TokenEnum] = []
        var operatorStack: [TokenEnum] = []
        
        var lastOperatorWasTwoOperant: Bool = false
        for token in tokens {
            switch token {
            case .swiftGmp, .inPlace, .percent:
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
            case .percent:
                // this operation in an inplace operation, but if no number is found
                // it creates a zero out of thin air and then oerates on the zero.
                let _001 = SwiftGmp(withString: "0.01", bits: generousBits(for: precision))
                if let n1 = stack.last,  case .twoOperant(let op) = tokens.last, let n2 = stack.secondLast {
                    tokens.removeLast()
                    stack.removeLast()
                    stack.removeLast()
                    n1.execute(.mul, other: _001)
                    n1.execute(.mul, other: n2)
                    n2.execute(op, other: n1)
                    stack.append(n2)
                } else if let swiftGmp = stack.popLast() {
                    swiftGmp.execute(.mul, other: _001)
                    stack.append(swiftGmp)
                } else {
                    // do nothing?
                }
                break
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

