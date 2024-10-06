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
        String(decimalSeparator.character) +
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

public struct LR {
    public var left: String
    public var right: String?
    public init(_ left: String, _ right: String? = nil) {
        self.left = left
        self.right = right
    }
    
    public var string: String {
        left + (right ?? "")
    }
    public func withSeperators(decimalSeparator: DecimalSeparator, separateGroups: Bool) -> String {
        let x = self.string
        let y = injectGrouping(numberString: x, decimalSeparator: decimalSeparator, separateGroups: separateGroups)
        return y
    }
    
    var double: Double {
        if let d = Double(string) {
            return d
        } else {
            return Double.nan
        }
    }
}

public enum DecimalSeparator: String, Codable, CaseIterable {
    case comma
    case dot
    public var character: Character {
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
    public var groupCharacter: Character {
        get {
            switch self {
            case .comma: return "."
            case .dot: return ","
            }
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

    var double: Double {
        leftRight(maxOutputLength: 10).double
    }

    func leftRight(maxOutputLength: Int) -> LR {
        // Ensure there are no errors and that mantissa and exponent are valid
        guard error == nil else { return LR(error!) }
        guard var mantissa = mantissa else { return LR("Invalid") }
        guard let exponent = exponent else { return LR("Invalid") }

        let isNegativeSign: String = isNegative ? "-" : ""

        // Integer representation
        if mantissa.count <= exponent + 1 && exponent <= maxOutputLength {
            // Pad mantissa with zeros to match the exponent
            mantissa = mantissa.padding(toLength: exponent + 1, withPad: "0", startingAt: 0)
            return LR(isNegativeSign + mantissa)
        }
        // Floating-point representation without scientific notation
        else if exponent >= 0 && exponent <= maxOutputLength - 3 {
            var floatString: String = mantissa
            let decimalIndex = floatString.index(floatString.startIndex, offsetBy: exponent + 1)
            floatString.insert(DecimalSeparator.dot.character, at: decimalIndex)
            let maxLength: Int = maxOutputLength - isNegativeSign.count
            let outputString: String = isNegativeSign + String(floatString.prefix(maxLength))
            return LR(outputString)
        }
        // Floating-point representation with leading zeros (exponent is negative)
        else if exponent < 0 {
            let zerosToInsert: Int = abs(exponent) - 1
            let leadingZeros: String = String(repeating: "0", count: zerosToInsert)
            let floatString: String = isNegativeSign + "0" + String(DecimalSeparator.dot.character) + leadingZeros + mantissa
            return LR(String(floatString.prefix(maxOutputLength)))
        }
        // Scientific notation representation
        else {
            var sciMantissa: String = mantissa
            let decimalIndex = sciMantissa.index(sciMantissa.startIndex, offsetBy: 1)
            sciMantissa.insert(DecimalSeparator.dot.character, at: decimalIndex)
            if sciMantissa.count == 2 {
                sciMantissa.append("0")
            }
            let exponentString: String = "e\(exponent)"
            let maxLength: Int = maxOutputLength - isNegativeSign.count - exponentString.count
            let mantissaPrefix: String = String(sciMantissa.prefix(maxLength))
            let outputString: String = isNegativeSign + mantissaPrefix + exponentString
            return LR(outputString)
        }
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
