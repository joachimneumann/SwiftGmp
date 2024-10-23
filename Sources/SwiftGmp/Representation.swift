//
//  Representation.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 25.09.24.
//

public func injectGrouping(numberString: String, decimalSeparator: DecimalSeparator, separateGroups: Bool) -> String {
    if numberString.starts(with: "-") {
        return "-" + nonNegativeInjectGrouping(numberString: String(numberString.dropFirst()), decimalSeparator: decimalSeparator, separateGroups: separateGroups)
    } else {
        return nonNegativeInjectGrouping(numberString: numberString, decimalSeparator: decimalSeparator, separateGroups: separateGroups)
    }
}

private func nonNegativeInjectGrouping(numberString: String, decimalSeparator: DecimalSeparator, separateGroups: Bool) -> String {
    var ret: String
    if numberString.contains(decimalSeparator.character) {
        let parts = numberString.split(separator: decimalSeparator.character)
        ret = nonNegativeInjectGrouping(
            numberString: String(parts[0]),
            decimalSeparator: decimalSeparator,
            separateGroups: separateGroups) +
        decimalSeparator.string
        if parts.count == 2 {
            ret += parts[1]
        }
    } else {
        ret = numberString
        if separateGroups {
            var count = ret.count
            while count >= 4 {
                count = count - 3
                ret.insert(decimalSeparator.groupCharacter, at: ret.index(ret.startIndex, offsetBy: count))
            }
        }
    }
    return ret
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
    public var string: String {
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
    public var groupString: String {
        get {
            switch self {
            case .comma: return "."
            case .dot: return ","
            }
        }
    }
}

public struct Number: CustomDebugStringConvertible {
    public var mantissa: String
    public var exponent: String?
    public var isDisplayBifferExponent: Bool
    init(mantissa: String, exponent: String? = nil, isDisplayBifferExponent: Bool = false) {
        self.mantissa = mantissa
        self.exponent = exponent
        self.isDisplayBifferExponent = isDisplayBifferExponent
    }
    public var debugDescription: String {
        var ret = mantissa
        if let e = exponent {
            ret += e
        }
        return ret
    }
}

public struct Representation: CustomDebugStringConvertible {
    var width: Float
    var length: (String) -> Float
    var displayBifferExponentLength: (String) -> Float
    public var error: String?
    public var number: Number?
    private var decimalSeparator: DecimalSeparator
    private var separateGroups: Bool
    private let maxOutputLength = 10
    
    public init(length: @escaping (String) -> Float, displayBifferExponentLength: @escaping (String) -> Float) {
        self.length = length
        self.displayBifferExponentLength = displayBifferExponentLength
        error = nil
        number = Number(mantissa: "0")
        decimalSeparator = DecimalSeparator.dot
        separateGroups = false
        width = 10
    }
    
    mutating public func setError(_ error: String) {
        self.error = error
        number = nil
    }
    
    mutating private func setNumber(_ number: Number) {
        self.error = nil
        self.number = number
    }

    private func containsOnly9s(_ input: String) -> Bool {
        return !input.isEmpty && input.allSatisfy { $0 == "9" }
    }
    
    private func truncate(_ string: String, to width: Float) -> String {
        if length(string) <= width {
            var s = string
            while s.last == "0" {
                s.removeLast()
            }
            return s
        }
        // truncate!
        var offset = 1
        var index = string.index(string.startIndex, offsetBy: offset)
        var truncated = String(string[..<index])
        var afterTruncated: String = String(string[index...])
        while true {
            if length(truncated) >= width {
                if containsOnly9s(afterTruncated) {
                    // disregard afterTruncated and increase truncated instead
                    truncated = incrementAbsString(truncated)
                    truncated = truncate(truncated, to: width)
                }
                while truncated.last == "0" {
                    truncated.removeLast()
                }
                return truncated
            }
            
            offset += 1
            index = string.index(string.startIndex, offsetBy: offset)
            truncated = String(string.prefix(upTo: index))
            afterTruncated = String(string[index...])
            if index == string.endIndex {
                truncated = truncated.removeTrailingZeroes()
                return truncated
            }
        }
    }
    
    private var totalWidth: Float {
        var ret: Float = 0
        if let error {
            ret += length(error)
        }
        if let number {
            ret += length(number.mantissa)
            if let exponent = number.exponent {
                ret += length(exponent)
            }
        }
        return ret
    }
    
    func incrementAbsString(_ s: String) -> String {
        var ret: String = s
        if ret.last != nil {
            if ret.last == "9" {
                ret.removeLast()
                ret = incrementAbsString(ret)
                ret = ret + "0"
            } else {
                let new = String(Int(String(ret.last!))! + 1)
                ret.removeLast()
                ret = ret + new
            }
        } else {
            ret = "1"
        }
        return ret
    }
    
    private func mantissa_1_float(
    mantissa: String,
    separator: Character,
    width: Float) -> String {
        let decimalIndex = mantissa.index(mantissa.startIndex, offsetBy: 1)
        var floatMantissa = mantissa
        floatMantissa.insert(separator, at: decimalIndex)
        let parts = floatMantissa.split(separator: separator)
        let beforeSeparator: String = String(parts[0])
        let beforeSeparatorAndDot = beforeSeparator + String(separator)
        let beforeSeparatorAndDotWidth = length(beforeSeparatorAndDot)
        var afterSeparator: String = String(parts[1])
        afterSeparator = truncate(afterSeparator, to: width - beforeSeparatorAndDotWidth)
        var res = beforeSeparatorAndDot + afterSeparator
        if res.count == 2 {
            res.append("0")
        }
        return res
    }
    
    mutating private func setScientific(
    mantissa: String,
    exponent: Int,
    negativeSign: String,
    isDisplayBufferExponent: Bool) {
        let exponentString = "e\(exponent)"
        let exponentWidth = length(exponentString)
        let remainingMantissaWidth = width - exponentWidth - length(negativeSign)
        let t = mantissa_1_float(
            mantissa: mantissa,
            separator: decimalSeparator.character,
            width: remainingMantissaWidth)
        number = Number(
            mantissa: negativeSign+t,
            exponent: exponentString,
            isDisplayBifferExponent: isDisplayBufferExponent)
        assert(totalWidth <= width)
    }
        
    mutating public func setMantissaExponent(
    _ mantissaExponent: MantissaExponent) {
        self.error = nil
        
        var mantissa = mantissaExponent.mantissa
        let exponent = mantissaExponent.exponent

        let negativeSign: String
        if mantissa.starts(with: "-") {
            negativeSign = "-"
            mantissa = String(mantissa.dropFirst())
        } else {
            negativeSign = ""
        }

        if  exponent > 0 && Float(exponent + 1) + length(negativeSign) <= width {
            // could be an Integer
            
            if mantissa.count <= exponent+1 {
                // easy integer

                // pad mantissa with "0" and cut to generousEstimateOfNumberOfDigits
                mantissa = negativeSign + mantissa
                mantissa = mantissa.padding(toLength: Int(Float(exponent + 1) + length(negativeSign)), withPad: "0", startingAt: 0)
                number = Number(mantissa: mantissa)
                return
            }

            mantissa = mantissa.padding(toLength: exponent + 1 + 3, withPad: "0", startingAt: 0)


            let dotIndex = mantissa.index(mantissa.startIndex, offsetBy: exponent + 1)
            var beforeSeparator: String = String(mantissa[..<dotIndex])
            let afterSeparator: String = String(mantissa[dotIndex...])
            //print("beforeSeparator: \(beforeSeparator)")
            //print("afterSeparator: \(afterSeparator)")
            if containsOnly9s(afterSeparator) {
                beforeSeparator = incrementAbsString(beforeSeparator)
                number = Number(mantissa: negativeSign + beforeSeparator)
                return
            }
        }
        
        // scientific
        setScientific(
            mantissa: mantissa,
            exponent: exponent,
            negativeSign: negativeSign,
            isDisplayBufferExponent: false)
        assert(totalWidth <= width)
        return
    }
    
    public var debugDescription: String {
        if let error {
            return error.debugDescription
        }
        if let number {
            return number.debugDescription
        }
        return "undefined"
    }
}
