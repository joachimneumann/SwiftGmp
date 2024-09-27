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
    
    public struct Token: CustomDebugStringConvertible {
        public var debugDescription: String {
            if let inplaceOperator {
                return inplaceOperator.description ?? "unknown"
            }
            if let number {
                return number.debugDescription
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
    private var basicTwoOperandOperator: [String: TwoOperandOperator] = [:]
    private var twoOperandOperator: [String: TwoOperandOperator] = [:]
    
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
        inplaceOperators["sqr"]     = InplaceOperator(Number.inplace_sqr, 1, description: "square")
        inplaceOperators["cubed"]      = InplaceOperator(Number.inplace_cubed, 1, description: "cubed")
        inplaceOperators["exp"]        = InplaceOperator(Number.inplace_exp, 1, description: "exp (to the power of e)")
        inplaceOperators["exp2"]       = InplaceOperator(Number.inplace_exp2, 1, description: "to the power of 2")
        inplaceOperators["exp10"]      = InplaceOperator(Number.inplace_exp10, 1, description: "to the power of 10")
        inplaceOperators["changeSign"] = InplaceOperator(Number.inplace_changeSign, 1, description: "changeSign")
        inplaceOperators["rez"]        = InplaceOperator(Number.inplace_rez, 1, description: "rez")
        inplaceOperators["fac"]        = InplaceOperator(Number.inplace_fac, 1, description: "fac")
        inplaceOperators["sinD"]       = InplaceOperator(Number.inplace_sinD, 1, description: "sinD")
        inplaceOperators["cosD"]       = InplaceOperator(Number.inplace_cosD, 1, description: "cosD")
        inplaceOperators["tanD"]       = InplaceOperator(Number.inplace_tanD, 1, description: "tanD")
        inplaceOperators["asinD"]      = InplaceOperator(Number.inplace_asinD, 1, description: "asinD")
        inplaceOperators["acosD"]      = InplaceOperator(Number.inplace_acosD, 1, description: "acosD")
        inplaceOperators["atand"]      = InplaceOperator(Number.inplace_atanD, 1, description: "atanD")

        basicTwoOperandOperator["+"]   = TwoOperandOperator(Number.add, 1, description: "add" )
        basicTwoOperandOperator["-"]   = TwoOperandOperator(Number.sub, 1, description: "subtract" )
        basicTwoOperandOperator["*"]   = TwoOperandOperator(Number.mul, 1, description: "multiply" )
        basicTwoOperandOperator["/"]   = TwoOperandOperator(Number.div, 1, description: "divide" )

        twoOperandOperator["pow_x_y"]  = TwoOperandOperator(Number.pow_x_y, 1, description: "x to the power of y" )
        twoOperandOperator["pow_y_x"]  = TwoOperandOperator(Number.pow_y_x, 1, description: "y to the power of x" )
        twoOperandOperator["sqrty"]    = TwoOperandOperator(Number.sqrty, 1, description: "y's root of x" )
        twoOperandOperator["logy"]     = TwoOperandOperator(Number.logy, 1, description: "log to the base of y" )
        twoOperandOperator["EE"]       = TwoOperandOperator(Number.EE, 1, description: "time to the the power of" )
    }
    
    func checkString(string: String) -> Bool {
        let without_dot = string.replacingOccurrences(of: ".", with: "")
        let digits = CharacterSet.decimalDigits
        
        let stringSet = CharacterSet(charactersIn: without_dot)

        return digits.isSuperset(of: stringSet)
    }

    func is19orMinus(_ str: String.Element) -> Bool {
        return str == "-" || (str >= "1" && str <= "9")
    }
    
    private func canBeNumber(_ str: String) throws -> Bool {
        guard str.filter{ $0 == "e" }.count <= 1 else { throw TokenizerError.invalidNumber(op: str) }
        guard str.filter{ $0 == "." }.count <= 2 else { throw TokenizerError.invalidNumber(op: str) }
        
        let without_e_minus = str.replacingFirstOccurrence(of: "e-", with: "")
        let without_e = without_e_minus.filter{ $0 != "e" }
        guard checkString(string: without_e) else { throw TokenizerError.invalidNumber(op: str) }

        func is19orMinus(_ str: String.Element) -> Bool {
            return str == "-" || (str >= "1" && str <= "9")
        }
             
        guard let firstChar = str.first else { return false } // Empty string case
        if firstChar == "." {
            guard let secondChar = str.dropFirst().first else { return false } // only .
            if is19orMinus(secondChar) {
                return true
            } else {
                throw TokenizerError.invalidNumber(op: str)
            }
        }
        if is19orMinus(firstChar) {
            return true
        } else {
            throw TokenizerError.invalidNumber(op: str)
        }
    }

    public mutating func parse(_ input: String) throws -> [Token] {
        var tokenArray: [Token] = []

        var bloatedString = input
        for key in basicTwoOperandOperator.keys {
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
            if let op = basicTwoOperandOperator[String(split)] {
                tokenArray.append(Token(op))
                continue
            }
            if let op = twoOperandOperator[String(split)] {
                tokenArray.append(Token(op))
                continue
            }
            if is19orMinus(split.first!) {
                var okNumber: Bool = true
                do {
                    okNumber = try canBeNumber(split)
                } catch {
                    throw(TokenizerError.invalidNumber(op: split))
                }
                if okNumber {
                    let n = Number(split, precision: 10)
                    let s = SwiftGmp(withString: split, precision: 10)
                    if s.isValid && !s.NaN {
                        tokenArray.append(Token(n))
                        continue
                    } else {
                        throw(TokenizerError.invalidNumber(op: split))
                    }
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

