//
//  Representation.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 25.09.24.
//

func injectGrouping(numberString: String, decimalSeparator: DecimalSeparator, separateGroups: Bool) -> String {
    if numberString.starts(with: "-") {
        return "-" + nonNegativeInjectGrouping(numberString: String(numberString.dropFirst()), decimalSeparator: decimalSeparator, separateGroups: separateGroups)
    } else {
        return nonNegativeInjectGrouping(numberString: numberString, decimalSeparator: decimalSeparator, separateGroups: separateGroups)
    }
}

private func nonNegativeInjectGrouping(numberString: String, decimalSeparator: DecimalSeparator, separateGroups: Bool) -> String {
    let parts = numberString.split(separator: decimalSeparator.character)
    if parts.count == 2 {
        return nonNegativeInjectGrouping(
            numberString: String(parts[0]),
            decimalSeparator: decimalSeparator,
            separateGroups: separateGroups) +
            decimalSeparator.rawValue +
        parts[1]
    } else {
        var ret: String = numberString
        if separateGroups {
            var count = ret.count
            while count >= 4 {
                count = count - 3
                ret.insert(decimalSeparator.groupCharacter, at: ret.index(ret.startIndex, offsetBy: count))
            }
        }
        return ret
    }
}

public enum DecimalSeparator: String, Codable, CaseIterable {
    case comma = ","
    case dot = "."
    public var character: Character {
        get {
            switch self {
            case .comma: return ","
            case .dot: return "."
            }
        }
    }
    public var groupCharacter: Character {
        get {
            switch self {
            case .comma: return "."
            case .dot: return ","
            }
        }
    }
}


public struct Representation {
    public var error: String?
    public var mantissa: String?
    public var exponent: Int?
    public var isNegative: Bool

    public init() {
        error = nil
        mantissa = "0"
        exponent = nil
        isNegative = false
    }
    init(error: String) {
        self.error = error
        self.mantissa = nil
        self.exponent = nil
        self.isNegative = false
    }
    
    init(_ R: Representation) {
        self.error = R.error
        self.mantissa = R.mantissa
        self.exponent = R.exponent
        self.isNegative = R.isNegative
    }
    
    public init(mantissa: String, exponent: Int, maxOutputLength: Int) {
        var tempMantissa = mantissa
        self.error = nil
        if tempMantissa.starts(with: "-") {
            self.isNegative = true
            tempMantissa = String(tempMantissa.dropFirst())
        } else {
            self.isNegative = false
        }

        let isNegativeSign: String = isNegative ? "-" : ""
        
        // Integer representation
        if tempMantissa.count <= exponent + 1 && exponent < maxOutputLength {
            // Pad mantissa with zeros to match the exponent
            tempMantissa = tempMantissa.padding(toLength: exponent + 1, withPad: "0", startingAt: 0)
            self.mantissa = isNegativeSign + tempMantissa
            self.exponent = nil
        }
        // Floating-point representation without scientific notation
        else if exponent >= 0 && exponent <= maxOutputLength - 3 {
            var floatString: String = tempMantissa
            let decimalIndex = floatString.index(floatString.startIndex, offsetBy: exponent + 1)
            floatString.insert(DecimalSeparator.dot.character, at: decimalIndex)
            let maxLength: Int = maxOutputLength - isNegativeSign.count
            self.mantissa = isNegativeSign + String(floatString.prefix(maxLength))
            self.exponent = nil
        }
        // Floating-point representation with leading zeros (exponent is negative)
        else if exponent < 0 {
            let zerosToInsert: Int = abs(exponent) - 1
            let leadingZeros: String = String(repeating: "0", count: zerosToInsert)
            self.mantissa = isNegativeSign + "0" + DecimalSeparator.dot.rawValue + leadingZeros + tempMantissa
            let maxLength: Int = maxOutputLength - isNegativeSign.count
            self.mantissa = String(self.mantissa!.prefix(maxLength))
            self.exponent = nil
        }
        // Scientific notation representation
        else {
            var sciMantissa: String = tempMantissa
            let decimalIndex = sciMantissa.index(sciMantissa.startIndex, offsetBy: 1)
            sciMantissa.insert(DecimalSeparator.dot.character, at: decimalIndex)
            if sciMantissa.count == 2 {
                sciMantissa.append("0")
            }
            let exponentString: String = "e\(exponent)"
            let maxLength: Int = maxOutputLength - isNegativeSign.count - exponentString.count
            self.mantissa = String(sciMantissa.prefix(maxLength))
            self.exponent = exponent
        }
    }

    func localizedMantissa(decimalSeparator: DecimalSeparator, separateGroups: Bool) -> String? {
        if var tempMantissa = mantissa {
            if decimalSeparator != .dot {
                tempMantissa = tempMantissa.replacingOccurrences(of: DecimalSeparator.dot.rawValue, with: decimalSeparator.rawValue)
            }
            tempMantissa = injectGrouping(numberString: tempMantissa, decimalSeparator: decimalSeparator, separateGroups: separateGroups)
            return tempMantissa
        }
        return nil
    }

//    func localizedString(decimalSeparator: DecimalSeparator, separateGroups: Bool) -> String {
//        var tempR = self
//        tempR.mantissa = localizedMantissa(decimalSeparator: decimalSeparator, separateGroups: separateGroups)
//        return tempR.string
//    }
    
    public var string: String {
        guard error == nil else { return error! }
        if let exponent = exponent {
            if let mantissa = mantissa {
                return "\(mantissa)e\(exponent)"
            } else {
                return "undefined"
            }
        } else {
            if let mantissa = mantissa {
                return mantissa
            } else {
                return "undefined"
            }
        }
    }
    
    public var double: Double {
        Double(string) ?? Double.nan
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
