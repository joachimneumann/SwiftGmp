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
            index = input.index(after: index)
        }
        
        if !numberBuffer.isEmpty {
            numbers.append(Number(numberBuffer, precision: precision))
        }
        
        return (operators, numbers)
    }
}

