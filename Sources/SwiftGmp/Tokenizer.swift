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
            return "Unprocessed token: \(op)"
        }
    }
}


public struct Tokenizer {
    
    public struct Token: CustomDebugStringConvertible {
        public var debugDescription: String {
            if let inplaceOperator {
                return inplaceOperator.description ?? "unknown"
            }
            if let number {
                if let d = number.toDouble() {
                    return String(d)
                }
                return "Nan"
            }
            if let twoOperandOperator {
                return twoOperandOperator.description ?? "unknown"
            }
            return ""
        }
        
        let inplaceOperator: InplaceOperator?
        let twoOperandOperator: TwoOperandOperator?
        let number: Number?
        init(_ inplaceOperator: InplaceOperator) {
            self.inplaceOperator = inplaceOperator
            self.twoOperandOperator = nil
            self.number = nil
        }
        init(_ twoOperandOperator: TwoOperandOperator) {
            self.inplaceOperator = nil
            self.twoOperandOperator = twoOperandOperator
            self.number = nil
        }
        init(_ number: Number) {
            self.inplaceOperator = nil
            self.twoOperandOperator = nil
            self.number = number
        }
    }

    
    private var inplaceOperators: [String: InplaceOperator] = [:]
    private var twoOperandOperators: [String: TwoOperandOperator] = [:]
    public var inplaceOperatorKeysSortedByLength: [String] = []
        
//    func op(_ key: String) -> Operator? {
//        if inplaceOperators[key] != nil {
//            return inplaceOperators[key]
//        }
//        return nil
//    }
    
    public func allOperators() -> [String] {
        return Array(inplaceOperators.keys)
    }

    public init() {
        inplaceOperators["zero"]       = InplaceOperator(Number.inplace_zero, 1, description: "zero")
        inplaceOperators["pi"]         = InplaceOperator(Number.inplace_π, 1, description: "π")
        inplaceOperators["e"]          = InplaceOperator(Number.inplace_e, 1, description: "e")
        inplaceOperators["rand"]       = InplaceOperator(Number.inplace_rand, 1, description: "rand")
        inplaceOperators["abs"]        = InplaceOperator(Number.inplace_abs, 1, description: "abs")
        inplaceOperators["sqrt"]       = InplaceOperator(Number.inplace_sqrt, 1, description: "sqrt")
        inplaceOperators["sqrt3"]      = InplaceOperator(Number.inplace_sqrt3, 1, description: "sqrt3")
        inplaceOperators["zeta"]       = InplaceOperator(Number.inplace_Z, 1, description: "Z")
        inplaceOperators["ln"]         = InplaceOperator(Number.inplace_ln, 1, description: "ln")
        inplaceOperators["log10"]      = InplaceOperator(Number.inplace_log10, 1, description: "log10")
        inplaceOperators["log2"]       = InplaceOperator(Number.inplace_log2, 1, description: "log2")
        inplaceOperators["sin"]        = InplaceOperator(Number.inplace_sin, 1, description: "sin")
        inplaceOperators["cos"]        = InplaceOperator(Number.inplace_cos, 1, description: "cos")
        inplaceOperators["tan"]        = InplaceOperator(Number.inplace_tan, 1, description: "tan")
        inplaceOperators["asin"]       = InplaceOperator(Number.inplace_asin, 1, description: "asin")
        inplaceOperators["acos"]       = InplaceOperator(Number.inplace_acos, 1, description: "acos")
        inplaceOperators["atan"]       = InplaceOperator(Number.inplace_atan, 1, description: "atan")
        inplaceOperators["sinh"]       = InplaceOperator(Number.inplace_sinh, 1, description: "sinh")
        inplaceOperators["cosh"]       = InplaceOperator(Number.inplace_cosh, 1, description: "cosh")
        inplaceOperators["tanh"]       = InplaceOperator(Number.inplace_tanh, 1, description: "tanh")
        inplaceOperators["asinh"]      = InplaceOperator(Number.inplace_asinh, 1, description: "asinh")
        inplaceOperators["acosh"]      = InplaceOperator(Number.inplace_acosh, 1, description: "acosh")
        inplaceOperators["atanh"]      = InplaceOperator(Number.inplace_atanh, 1, description: "atanh")
        inplaceOperators["pow_x_2"]    = InplaceOperator(Number.inplace_pow_x_2, 1, description: "pow_x_2")
        inplaceOperators["pow_e_x"]    = InplaceOperator(Number.inplace_pow_e_x, 1, description: "pow_e_x")
        inplaceOperators["pow_10_x"]   = InplaceOperator(Number.inplace_pow_10_x, 1, description: "pow_10_x")
        inplaceOperators["changeSign"] = InplaceOperator(Number.inplace_changeSign, 1, description: "changeSign")
        inplaceOperators["pow_x_3"]    = InplaceOperator(Number.inplace_pow_x_3, 1, description: "pow_x_3")
        inplaceOperators["pow_2_x"]    = InplaceOperator(Number.inplace_pow_2_x, 1, description: "pow_2_x")
        inplaceOperators["rez"]        = InplaceOperator(Number.inplace_rez, 1, description: "rez")
        inplaceOperators["fac"]        = InplaceOperator(Number.inplace_fac, 1, description: "fac")
        inplaceOperators["sinD"]       = InplaceOperator(Number.inplace_sinD, 1, description: "sinD")
        inplaceOperators["cosD"]       = InplaceOperator(Number.inplace_cosD, 1, description: "cosD")
        inplaceOperators["tanD"]       = InplaceOperator(Number.inplace_tanD, 1, description: "tanD")
        inplaceOperators["asinD"]      = InplaceOperator(Number.inplace_asinD, 1, description: "asinD")
        inplaceOperators["acosD"]      = InplaceOperator(Number.inplace_acosD, 1, description: "acosD")
        inplaceOperators["atand"]      = InplaceOperator(Number.inplace_atanD, 1, description: "atanD")
        inplaceOperatorKeysSortedByLength = inplaceOperators.keys.sorted { $0.count < $1.count }
    }
    
    private func startsWithNumberPrefix(_ str: String) -> Bool {
        guard let firstChar = str.first else {
            return false // Empty string case
        }
        return firstChar == "-" || (firstChar >= "1" && firstChar <= "9")
    }

    private func continuesWithNumberPrefix(_ str: String) -> Bool {
        guard let firstChar = str.first else {
            return false // Empty string case
        }
        
        return firstChar == "-" || (firstChar >= "1" && firstChar <= "9")
    }

    public mutating func parse(_ input: String) throws -> [Token] {
        var tokenArray: [Token] = []

        var bloatedString = input
        for key in inplaceOperatorKeysSortedByLength {
            if bloatedString.contains(key) {
                bloatedString = bloatedString.replacingOccurrences(of: key, with: " \(key) ")
            }
        }
        print(bloatedString)
        let splitString = bloatedString.split(separator: " ")
        for splitSubSequence in splitString {
            let split = String(splitSubSequence)
            if split.isEmpty { continue }
            if let op = inplaceOperators[String(split)] {
                tokenArray.append(Token(op))
                continue
            }
            if startsWithNumberPrefix(split) {
                let n = Number(split, precision: 10)
                let s = SwiftGmp(withString: split, precision: 10)
                if s.isValid {
                    tokenArray.append(Token(n))
                    continue
                } else {
                    throw(TokenizerError.invalidNumber(op: split))
                }
            }
            if split == "=" {
                return tokenArray
            }
            
            // some tokens have not been processed
            throw(TokenizerError.unprocessed(op: split))
        }
        return tokenArray
    }
}

