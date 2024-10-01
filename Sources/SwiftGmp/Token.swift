//
//  Token.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 30.09.24.
//

import Foundation

public enum TokenizerError: Error, LocalizedError {
    case unknownOperator(op: String)
    case invalidNumber(op: String)
    case unprocessed(op: String)
    
    public var errorDescription: String? {
        switch self {
        case .unknownOperator(let op):
            return "Unknown operator: \(op)"
        case .invalidNumber(let op):
            return "Invalid number: \(op)"
        case .unprocessed(let op):
            return "unknown: \(op)"
        }
    }
}

public struct Token {
    var tokens: [TokenEnum] = []
    private var precision: Int

    enum TokenEnum {
        case inPlace(SwiftGmpInplaceOperation) // e.g., sin, log
        case twoOperant(SwiftGmpTwoOperantOperation) // e.g., +, -, *, /
        case number(Number) // e.g., pi, e
        case parenthesesLeft
        case parenthesesRight
        
        var priority: Int {
            switch self {
            case .twoOperant(let op):
                if op == .mul || op == .div { return 2 } // Higher precedence for * and /
                return 1 // Lower precedence for + and -
            case .inPlace:
                return 3 // Highest precedence for in-place operators like sin, log
            case .parenthesesLeft, .parenthesesRight:
                return 0 // Parentheses control grouping, not direct precedence
            case .number:
                return 4 // Constants should be directly evaluated
            }
        }
    }
    
    public mutating func setPrecision(newPrecision: Int) {
        self.precision = newPrecision
        for token in tokens {
            if case .number(let n) = token {
                n.setPrecision(newPrecision)
            }
        }
    }

    public let allOperationsSorted: [OpProtocol]

    public mutating func clear() {
        tokens = []
    }
    public init(precision: Int) {
        self.precision = precision
        let allOperations: [OpProtocol] = SwiftGmpInplaceOperation.allCases +
                                          SwiftGmpTwoOperantOperation.allCases +
                                          SwiftGmpParenthesisOperation.allCases
        allOperationsSorted = allOperations.sorted { $0.getRawValue().count > $1.getRawValue().count }
    }

    mutating func shuntingYard() {
        var output: [TokenEnum] = []
        var operatorStack: [TokenEnum] = []
        
        var lastOperatorWasTwoOperant: Bool = false
        for token in tokens {
            switch token {
            case .number, .inPlace:
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
    
    mutating func evaluatePostfix() -> Number {
        var stack: [Number] = []
        
        for token in tokens {
            switch token {
            case .number(let number):
                stack.append(number) // Push constants to the stack
            case .inPlace(let operation):
                if let number = stack.popLast() {
                    number.swiftGmp.execute(operation)
                    stack.append(number) // Apply in-place operator
                }
            case .twoOperant(let operation):
                if let rhs = stack.popLast(), let lhs = stack.popLast() {
                    lhs.swiftGmp.execute(operation, other: rhs.swiftGmp)
                    stack.append(lhs) // Apply binary operator
                }
            default:
                break
            }
        }
        let ret: Number
        if stack.last != nil {
            ret = stack.last!
            stack.removeLast()
        } else {
            ret = Number(precision: 0)
        }
        tokens = []
        return ret
    }


    public mutating func tokenize(_ input: String) throws {
        var numberBuffer = ""
        var index = input.startIndex
        var numberExpected = true
        
        while index < input.endIndex {
            let char = input[index]
            
            if char.isNumber || char == "." || (char == "e" && !numberBuffer.isEmpty) || (char == "-" && numberBuffer.last == "e") {
                // Append characters that are part of a number (including scientific notation)
                numberBuffer.append(char)
            } else if char.isWhitespace {
                if !numberBuffer.isEmpty {
                    tokens.append(.number(Number(numberBuffer, precision: precision)))
                    numberBuffer = ""
                    numberExpected = false
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
                        tokens.append(.number(Number(numberBuffer, precision: precision)))
                        numberBuffer = ""
                    }
                    tokens.append(.twoOperant(.sub))  // subtraction operator
                }
            } else {
                var opFound = false
                for op in allOperationsSorted {
                    if !opFound && input[index...].hasPrefix(op.getRawValue()) {
                        opFound = true
                        if !numberBuffer.isEmpty {
                            tokens.append(.number(Number(numberBuffer, precision: precision)))
                            numberBuffer = ""
                        }
                        if let inPlace = op as? SwiftGmpInplaceOperation {
                            tokens.append(.inPlace(inPlace))
                        } else if let twoOperant = op as? SwiftGmpTwoOperantOperation {
                            tokens.append(.twoOperant(twoOperant))
                        } else if op.getRawValue() == "(" {
                            tokens.append(.parenthesesLeft)
                        } else if op.getRawValue() == ")" {
                            tokens.append(.parenthesesRight)
                        } else {
                            throw TokenizerError.unknownOperator(op: op.getRawValue())
                        }
                        numberExpected = true
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
            tokens.append(.number(Number(numberBuffer, precision: precision)))
        }
    }
}

