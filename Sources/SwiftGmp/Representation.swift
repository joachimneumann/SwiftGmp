//
//  Representation.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 25.09.24.
//

public struct LR {
    var left: String
    var right: String?
    init(_ left: String, _ right: String? = nil) {
        self.left = left
        self.right = right
    }
    
    public var string: String {
        left + (right ?? "")
    }

    var double: Double {
        if let d = Double(string) {
            return d
        } else {
            return Double.nan
        }
    }
}

struct Representation {
    var error: String?
    private var mantissa: String?
    private var exponent: Int?
    private var isNegative: Bool
    
    init(error: String) {
        self.error = error
        self.mantissa = nil
        self.exponent = nil
        self.isNegative = false
    }
    init(mantissa: String, exponent: Int) {
        self.error = nil
        if mantissa.starts(with: "-") {
            self.isNegative = true
            self.mantissa = String(mantissa.dropFirst())
        } else {
            self.isNegative = false
            self.mantissa = mantissa
        }
        self.exponent = exponent
    }

    protocol Separators {
        var decimalSeparator: DecimalSeparator   { get }
        var groupingSeparator: GroupingSeparator { get }
    }

    enum DecimalSeparator: String, Codable, CaseIterable {
        case comma
        case dot
        var character: Character {
            get {
                switch self {
                case .comma: return ","
                case .dot: return "."
                }
            }
        }
        var string: String {
            get {
                String(character)
            }
        }
    }
    enum GroupingSeparator: String, Codable, CaseIterable {
        case comma
        case dot
        case none
        var character: Character? {
            get {
                switch self {
                case .none: return nil
                case .comma: return ","
                case .dot: return "."
                }
            }
        }
        var string: String {
            get {
                guard let character = character else { return "" }
                return String(character)
            }
        }
    }
    
    var double: Double {
        leftRight(maxOutputLength: 10).double
    }

    func leftRight(maxOutputLength: Int, groupingSeparator: GroupingSeparator = .none, decimalSeparator: DecimalSeparator = .dot) -> LR {
        guard error == nil else { return LR(error!) }
        guard var mantissa = mantissa else { return LR("Invalid") }
        guard let exponent = exponent else { return LR("Invalid") }
        
        if mantissa.count <= exponent + 1 && exponent <= maxOutputLength {
            // integer
            mantissa = mantissa.padding(toLength: exponent+1, withPad: "0", startingAt: 0)
            let intString = (isNegative ? "-" : "") +
            injectSeparators(numberString: mantissa, groupingSeparator: groupingSeparator, decimalSeparator: decimalSeparator)
            return LR(intString)
        } else {
            // float
            if exponent >= 0 && exponent <= maxOutputLength - 3 {
                var floatString = mantissa
                let index = floatString.index(floatString.startIndex, offsetBy: exponent+1)
                //var indexInt: Int = floatString.distance(from: floatString.startIndex, to: index)
                floatString.insert(decimalSeparator.character, at: index)
                let maxLength = maxOutputLength - (isNegative ? 1 : 0)
                return LR((isNegative ? "-" : "") + floatString.prefix(maxLength))
            }
            if exponent < 0 {
                var floatString = mantissa
                for _ in 0..<(-1*exponent - 1) {
                    floatString = "0" + floatString
                }
                return LR((isNegative ? "-" : "") + "0" + decimalSeparator.string + floatString)
            }
            
            // scientific notation required
            let secondIndex = mantissa.index(mantissa.startIndex, offsetBy: 1)
            mantissa.insert(decimalSeparator.character, at: secondIndex)
            if mantissa.count == 2 { mantissa.append("0") }
            let exponentString = "e\(exponent)"
            let maxLength = maxOutputLength - (isNegative ? 1 : 0) - exponentString.count
            return LR((isNegative ? "-" : "") + String(mantissa.prefix(maxLength)), exponentString)
        }
    }
    
    private func injectSeparators(numberString: String, groupingSeparator: GroupingSeparator, decimalSeparator: DecimalSeparator) -> String {
        if numberString.starts(with: "-") {
            return "-" + nonNegativeInjectSeparators(numberString: String(numberString.dropFirst()), groupingSeparator: groupingSeparator, decimalSeparator: decimalSeparator)
        } else {
            return nonNegativeInjectSeparators(numberString: numberString, groupingSeparator: groupingSeparator, decimalSeparator: decimalSeparator)
        }
    }

    private func nonNegativeInjectSeparators(numberString: String, groupingSeparator: GroupingSeparator, decimalSeparator: DecimalSeparator) -> String {
        var ret: String = numberString
        if let c = groupingSeparator.character {
            var count = ret.count
            while count >= 4 {
                count = count - 3
                ret.insert(c, at: ret.index(ret.startIndex, offsetBy: count))
            }
        }
        return ret
    }

}

extension String {
    func before(first delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            let before = prefix(upTo: index)
            return String(before)
        }
        return ""
    }
    
    func after(first delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            let after = suffix(from: index).dropFirst()
            return String(after)
        }
        return ""
    }
    
    func replacingFirstOccurrence(of target: String, with replacement: String) -> String {
        guard let range = self.range(of: target) else { return self }
        return self.replacingCharacters(in: range, with: replacement)
    }
}
