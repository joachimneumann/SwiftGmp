//
//  Tokenizer.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 26.09.24.
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

//public struct Token: CustomDebugStringConvertible {
//    enum TokenType {
//        case inplace
//        case twoOperand
//        case number
//    }
//    var tokenType: TokenType {
//        if inplaceOperator != nil {
//            return .inplace
//        }
//        if twoOperandOperator != nil {
//            return .twoOperand
//        }
//        return .number
//    }
//    public var debugDescription: String {
//        if let inplaceOperator {
//            return inplaceOperator.description ?? "unknown"
//        }
//        if let number {
//            return number.debugDescription
//        }
//        if let twoOperandOperator {
//            return twoOperandOperator.description ?? "unknown"
//        }
//        return ""
//    }
//    
//    let inplaceOperator: InplaceOperator?
//    let twoOperandOperator: TwoOperandOperator?
//    let number: Number?
//    init(_ inplaceOperator: InplaceOperator) {
//        self.inplaceOperator = inplaceOperator
//        self.twoOperandOperator = nil
//        self.number = nil
//    }
//    init(_ twoOperandOperator: TwoOperandOperator) {
//        self.inplaceOperator = nil
//        self.twoOperandOperator = twoOperandOperator
//        self.number = nil
//    }
//    init(_ number: Number) {
//        self.inplaceOperator = nil
//        self.twoOperandOperator = nil
//        self.number = number
//    }
//}

public struct Tokenizer {
    private var precision: Int
    public let allOperationsSorted: [OpProtocol]

    public mutating func setPrecision(newPrecision: Int) {
        precision = newPrecision
    }

    public init(precision: Int) {
        self.precision = precision
        let allOperations: [OpProtocol] = SwiftGmpInplaceOperation.allCases +
                                          SwiftGmpTwoOperantOperation.allCases +
                                          SwiftGmpParenthesisOperation.allCases
        allOperationsSorted = allOperations.sorted { $0.getRawValue().count > $1.getRawValue().count }
    }


    public mutating func parse(_ input: String) throws -> ([any OpProtocol], [Number]) {

        var operators: [any OpProtocol] = []
        var numbers: [Number] = []

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
                    numbers.append(Number(numberBuffer, precision: precision))
                    numberBuffer = ""
                    numberExpected = false
                }
            } else if char == "=" {
                // Ignore for now
            } else if char == "-" {
                if numberExpected {
                    numberBuffer.append(char) // unary minus (e.g., -5)
                } else {
                    if !numberBuffer.isEmpty {
                        numbers.append(Number(numberBuffer, precision: precision))
                        numberBuffer = ""
                    }
                    operators.append(SwiftGmpTwoOperantOperation.sub)  // subtraction operator
                }
            } else {
                var opFound = false
                for op in allOperationsSorted {
                    if input[index...].hasPrefix(op.getRawValue()) {
                        opFound = true
                        if !numberBuffer.isEmpty {
                            numbers.append(Number(numberBuffer, precision: precision))
                            numberBuffer = ""
                        }
                        operators.append(op)
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
            /*
            } else if char == "+" {
                // If there's a number in the buffer, flush it as a token
                if !numberBuffer.isEmpty {
                    numbers.append(Number(numberBuffer, precision: precision))
                    numberBuffer = ""
                }
                operators.append(SwiftGmpTwoOperantOperation.add)
                numberExpected = true
            } else if char == "*" {
                // If there's a number in the buffer, flush it as a token
                if !numberBuffer.isEmpty {
                    numbers.append(Number(numberBuffer, precision: precision))
                    numberBuffer = ""
                }
                operators.append(SwiftGmpTwoOperantOperation.mul)
                numberExpected = true
            } else if char == "/" {
                // If there's a number in the buffer, flush it as a token
                if !numberBuffer.isEmpty {
                    numbers.append(Number(numberBuffer, precision: precision))
                    numberBuffer = ""
                }
                operators.append(SwiftGmpTwoOperantOperation.div)
                numberExpected = true
            } else if char == "-" {
                if numberExpected {
                    numberBuffer.append(char) // unary minus (e.g., -5)
                } else {
                    if !numberBuffer.isEmpty {
                        numbers.append(Number(numberBuffer, precision: precision))
                        numberBuffer = ""
                    }
                    operators.append(SwiftGmpTwoOperantOperation.sub)  // subtraction operator
                }
            } else if char == "(" {
                if !numberBuffer.isEmpty {
                    numbers.append(Number(numberBuffer, precision: precision))
                    numberBuffer = ""
                }
                operators.append(SwiftGmpParenthesisOperation.leftParenthesis)
                numberExpected = true
            } else if char == ")" {
                if !numberBuffer.isEmpty {
                    numbers.append(Number(numberBuffer, precision: precision))
                    numberBuffer = ""
                }
                operators.append(SwiftGmpParenthesisOperation.rightParenthesis)
                numberExpected = true
            } else if input[index...].hasPrefix("sin") {
                if !numberBuffer.isEmpty {
                    numbers.append(Number(numberBuffer, precision: precision))
                    numberBuffer = ""
                }
                operators.append(SwiftGmpInplaceOperation.sin)
                index = input.index(index, offsetBy: 2) // Skip 'in' in 'sin'
                numberExpected = true
            } else {
                fatalError("Unexpected character: \(char)")
            }
             */
            
            index = input.index(after: index)
        }
        
        if !numberBuffer.isEmpty {
            numbers.append(Number(numberBuffer, precision: precision))
        }
        
        return (operators, numbers)

        

//        var operators: [OpProtocol] = []
//        var numbers: [Number] = []
//
//        var bloatedString = input
//        bloatedString = bloatedString.replacingOccurrences(of: "+", with: " add ")
//        bloatedString = bloatedString.replacingOccurrences(of: "-", with: " sub ")
//        bloatedString = bloatedString.replacingOccurrences(of: "*", with: " mul ")
//        bloatedString = bloatedString.replacingOccurrences(of: "/", with: " div ")
//        print(bloatedString)
//        let splitString = bloatedString.split(separator: " ")
//        for splitSubSequence in splitString {
//            let split = String(splitSubSequence)
//            if split.isEmpty { continue }
//            
//            if let op = SwiftGmpInplaceOperation(rawValue: split) {
//                operators.append(op)
//                continue
//            }
//            if let op = SwiftGmpTwoOperantOperation(rawValue: split) {
//                operators.append(op)
//                continue
//            }
//            if is19orMinus(split.first!) {
//                var okNumber: Bool = true
//                do {
//                    okNumber = try canBeNumber(split)
//                } catch {
//                    throw(TokenizerError.invalidNumber(op: split))
//                }
//                if okNumber {
//                    let n = Number(split, precision: precision)
//                    let tempGmp = SwiftGmp(withString: split, bits: n.bits(for: precision))
//                    if tempGmp.isValid && !tempGmp.isNan {
//                        numbers.append(n)
//                        continue
//                    } else {
//                        throw(TokenizerError.invalidNumber(op: split))
//                    }
//                }
//            }
//
//            // some tokens have not been processed
//            throw(TokenizerError.unprocessed(op: split))
//        }
//        return (operators, numbers)
    }
}

