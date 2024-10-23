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
    public var isDisplayBufferExponent: Bool
    init(mantissa: String, exponent: String? = nil, isDisplayBifferExponent: Bool = false) {
        self.mantissa = mantissa
        self.exponent = exponent
        self.isDisplayBufferExponent = isDisplayBifferExponent
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
    var width: Int
    var length: (String) -> Int
    var displayBifferExponentLength: (String) -> Int
    public var error: String?
    public var number: Number?
    private var decimalSeparator: DecimalSeparator
    private var separateGroups: Bool
    private let maxOutputLength = 10
    
    public init(length: @escaping (String) -> Int, displayBifferExponentLength: @escaping (String) -> Int) {
        self.length = length
        self.displayBifferExponentLength = displayBifferExponentLength
        error = nil
        number = Number(mantissa: "0")
        decimalSeparator = DecimalSeparator.dot
        separateGroups = false
        width = 10
    }
    
//    mutating public func setError(_ error: String) {
//        self.error = error
//        number = nil
//    }
//    
//    mutating private func setNumber(_ number: Number) {
//        self.error = nil
//        self.number = number
//    }
    
    private var totalWidth: Int {
        var ret: Int = 0
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
    
    mutating private func setScientific(
    mantissa: String,
    exponent: Int,
    negativeSign: String,
    isDisplayBufferExponent: Bool) {
        let exponentString = "e\(exponent)"
        let exponentWidth = length(exponentString)
        let remainingMantissaWidth = width - exponentWidth - length(negativeSign) - 1
        var sciMantissa = mantissa
        sciMantissa.correctFractionalPartNumericalErrors(after: remainingMantissaWidth)
        sciMantissa.insert(decimalSeparator.character, at: sciMantissa.index(sciMantissa.startIndex, offsetBy: 1))
        if sciMantissa.count == 2 {
            sciMantissa.append("0")
        }

        number = Number(
            mantissa: negativeSign+sciMantissa,
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

        if  exponent >= 0 {
            if exponent + 1 + length(negativeSign) <= width {
                // could be an Integer
                
                if let integerString = mantissa.integerWithoutNumericalErrors(exponent: exponent) {
                    number = Number(mantissa: negativeSign + integerString)
                    assert(totalWidth <= width)
                    return
                }

                // no integer, maybe float that is >= 1.0
                let floatMantissaLength = width - length(negativeSign) - 1 + 4
                let floatMantissa = mantissa.padding(toLength: floatMantissaLength, withPad: "0", startingAt: 0)
                let dotIndex = floatMantissa.index(floatMantissa.startIndex, offsetBy: exponent + 1)
                let beforeSeparator: String = String(floatMantissa[..<dotIndex])
                var afterSeparator: String = String(floatMantissa[dotIndex...])
                if length(beforeSeparator) <= width - 2 - length(negativeSign) {
                    let w = length(beforeSeparator) + length(decimalSeparator.string)
                    let remainingLength = width - w - length(negativeSign)
                    afterSeparator.correctFractionalPartNumericalErrors(after: remainingLength)
                    number = Number(mantissa: negativeSign + beforeSeparator + decimalSeparator.string + afterSeparator)
                    assert(totalWidth <= width)
                    return
                } else {
                    // beforeSeparator is too long, needs space for the dot ant at least one digit
                }
            }
        } else {
            // exponent < 0, maybe float that is < 1.0
            if exponent > -1 * width + 2 {
                var floatMantissa = mantissa
                for _ in 0 ..< -1 * exponent - 1 {
                    floatMantissa = "0" + floatMantissa
                }
                floatMantissa.correctFractionalPartNumericalErrors(after: -1 * exponent)
                floatMantissa = "0" + decimalSeparator.string + floatMantissa
                number = Number(mantissa: negativeSign + floatMantissa)
                assert(totalWidth <= width)
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

extension String {
    
    mutating func incrementAbsIntegerValue() {
        if self.last != nil {
            if self.last == "9" {
                self.removeLast()
                self.incrementAbsIntegerValue()
                self += "0"
            } else {
                let new = String(Int(String(self.last!))! + 1)
                self.removeLast()
                self += new
            }
        } else {
            self = "1"
        }
    }
    
    mutating func correctFractionalPartNumericalErrors(after position: Int) {
        if self.count < position + 3 {
            // the string is too short, so not correct anything
            return
        }
        let positionIndex = self.index(self.startIndex, offsetBy: position)
        let positionIndexPlus3 = self.index(self.startIndex, offsetBy: position+3)

        var cutOffString = String(self[..<positionIndex])
        if self[positionIndex..<positionIndexPlus3] == "999" {
            cutOffString.incrementAbsIntegerValue()
        } else if self.count >= position + 4 {
            let positionIndexPlus4 = self.index(self.startIndex, offsetBy: position+4)
            if self[positionIndex..<positionIndexPlus4] == "9989" {
                cutOffString.incrementAbsIntegerValue()
            }
        }
        cutOffString.removeTrailingZeroes()
        self = cutOffString
    }
    
    mutating func integerWithoutNumericalErrors(exponent: Int) -> String? {
        var integerMantissa = self
        if self.count < exponent + 1 {
            integerMantissa = self.padding(toLength: exponent + 1, withPad: "0", startingAt: 0)
        }

        if integerMantissa.count == exponent + 1 { return integerMantissa }
        
        integerMantissa = self.padding(toLength: exponent + 1 + 4, withPad: "0", startingAt: 0)
        
        let dotIndex = integerMantissa.index(integerMantissa.startIndex, offsetBy: exponent + 1)
        var beforeSeparator: String = String(integerMantissa[..<dotIndex])
        let afterSeparator: String = String(integerMantissa[dotIndex...])
        if afterSeparator.prefix(3) == "999" {
            beforeSeparator.incrementAbsIntegerValue()
            return beforeSeparator
        }
        if afterSeparator.prefix(4) == "9989" {
            beforeSeparator.incrementAbsIntegerValue()
            return beforeSeparator
        }

        return nil
    }
}
