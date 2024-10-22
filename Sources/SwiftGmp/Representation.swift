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

//    public func roundString(_ input: String) -> (String, Bool) {
//        // Ensure the input is non-empty.
//        guard !input.isEmpty else { return (input, false) }
//        
//        // If the input has only one character, do nothing
//        if input.count == 1 {
//            return (input, false)
//        }
//        
//        // Convert the input string into an array of characters.
//        var digits = Array(input)
//        
//        // Remove the last digit to decide rounding.
//        let lastDigit = digits.removeLast()
//        
//        // Determine if we need to round up.
//        var shouldRoundUp = lastDigit >= "5"
//        
//        // Index for the digit to round.
//        var index = digits.count - 1
//        
//        // Perform rounding if necessary.
//        while shouldRoundUp && index >= 0 {
//            if digits[index] == "9" {
//                // Set current digit to '0' and carry over.
//                digits[index] = "0"
//            } else if let digitValue = digits[index].wholeNumberValue {
//                // Increment the current digit.
//                let incrementedValue = digitValue + 1
//                digits[index] = Character("\(incrementedValue)")
//                shouldRoundUp = false  // No more rounding needed.
//            }
//            index -= 1
//        }
//        
//        var overflow = false
//        if shouldRoundUp && index < 0 {
//            overflow = true
//        }
//        
//        // Remove any trailing zeros.
//        var result = String(digits)
//        while result.last == "0" {
//            result.removeLast()
//        }
//        // If the result is empty after trimming, return "0".
//        return (result, overflow)
//    }
    
    private func containsOnly9(_ input: String) -> Bool {
        return !input.isEmpty && input.allSatisfy { $0 == "9" }
    }
    
    private func truncate(_ string: String, to width: Float) -> (String, Bool) {
        if length(string) <= width {
            var s = string
            while s.last == "0" {
                s.removeLast()
            }
            return (s, false)
        }
        // truncate!
        var offset = 1
        var index = string.index(string.startIndex, offsetBy: offset)
        var truncated = String(string[..<index])
        var afterTruncated: String = String(string[index...])
        while true {
            if length(truncated) >= width {
                if containsOnly9(afterTruncated) {
                    truncated = incrementAbsString(truncated)
                    return truncate(truncated, to: width)
                }
                while truncated.last == "0" {
                    truncated.removeLast()
                }
                return (truncated, false)
            }
            
            offset += 1
            index = string.index(string.startIndex, offsetBy: offset)
            truncated = String(string.prefix(upTo: index))
            afterTruncated = String(string[index...])
            if index == string.endIndex {
                truncated = truncated.removeTrailingZeroes()
                return (truncated, false)
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
        var overFlow: Bool
        let decimalIndex = mantissa.index(mantissa.startIndex, offsetBy: 1)
        var floatMantissa = mantissa
        floatMantissa.insert(separator, at: decimalIndex)
        if floatMantissa.count == 2 {
            floatMantissa.append("0")
        }
        let parts = floatMantissa.split(separator: separator)
        var beforeSeparator: String = String(parts[0])
        let beforeSeparatorAndDot = beforeSeparator + String(separator)
        let beforeSeparatorAndDotWidth = length(beforeSeparatorAndDot)
        var afterSeparator: String = String(parts[1])
        (afterSeparator, overFlow) = truncate(afterSeparator, to: width - beforeSeparatorAndDotWidth)
        if overFlow {
            beforeSeparator = incrementAbsString(beforeSeparator)
            // TODO: is beforeSeparator now longer: truncate again :(
        }
        return beforeSeparatorAndDot + afterSeparator
    }
    
    mutating private func setScientific(
    mantissa: String,
    exponent: Int,
    isDisplayBufferExponent: Bool) {
        let exponentString = "e\(exponent)"
        let exponentWidth = length(exponentString)
        let remainingMantissaWidth = width - exponentWidth
        let t = mantissa_1_float(
            mantissa: mantissa,
            separator: decimalSeparator.character,
            width: remainingMantissaWidth)
        number = Number(
            mantissa: t,
            exponent: exponentString,
            isDisplayBifferExponent: isDisplayBufferExponent)
        let w = totalWidth
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
        
        /// can the number be displayed in the non-scientific format (integer or float)?
        //
        // NON-SCIENTIFIC???
        // generousEstimateOfNumberOfDigits = width / smallestDigitWidth
        // get beforeSeparator (filling up)
        // if (beforeSeparator.textwidth <= width:
        //     if afterSeparator.isEmpty():
        //
        //         Integer!
        //     else:
        //         round(afterSeparator)
        //     everything = beforeSeparator + dot
        //     while everything.textwidth less than width
        //        round(after
        // else :
        //     scientific!

        // --> Is it an integer
        
        // Integer?
        // Note: mantissa could be 99.9999999999999999999999999999999999999999...

        if  exponent + 1 <= Int(width) {
            // could be an Integer
            
            if mantissa.count <= exponent+1 {
                // easy integer

                // pad mantissa with "0" and cut to generousEstimateOfNumberOfDigits
                mantissa = mantissa.padding(toLength: exponent + 1, withPad: "0", startingAt: 0)
                number = Number(mantissa: mantissa)
                return
            }
            
            

            mantissa = mantissa.padding(toLength: exponent + 1 + 3, withPad: "0", startingAt: 0)


            let dotIndex = mantissa.index(mantissa.startIndex, offsetBy: exponent + 1)
            var beforeSeparator: String = String(mantissa[..<dotIndex])
            var afterSeparator: String = String(mantissa[dotIndex...])
            print("beforeSeparator: \(beforeSeparator)")
            print("afterSeparator: \(afterSeparator)")
            if containsOnly9(afterSeparator) {
                beforeSeparator = incrementAbsString(beforeSeparator)
                number = Number(mantissa: beforeSeparator)
                return
            }
//            (afterSeparator, overflow) = roundString(afterSeparator)
//            print("afterSeparator, rounded: \(afterSeparator)")
//            if overflow {
//                beforeSeparator = negativeSign+incrementString(beforeSeparator)
//                let me = MantissaExponent(mantissa: beforeSeparator+afterSeparator, exponent: exponent)
//                setMantissaExponent(me, width: width)
//            }
//            if afterSeparator.isEmpty {
//                if beforeSeparator.textWidth(kerning: kerning, font) < width {
//                    number = Number(mantissa: Content(beforeSeparator, font: font))
//                    return
//                }
//            }
//        }
//        if mantissa.count <= exponent + 1 {
//            
//            // Pad mantissa with zeros to match the exponent
//            var integerMantissa = mantissa.padding(toLength: exponent + 1, withPad: "0", startingAt: 0)
//            integerMantissa = nonNegativeInjectGrouping(
//                numberString: integerMantissa,
//                decimalSeparator: decimalSeparator,
//                separateGroups: separateGroups)
//            integerMantissa = negativeSign + integerMantissa
//            
//            if integerMantissa.textWidth(kerning: kerning, font) <= width {
//                // the interger fits in the display
//                number = Number(mantissa: Content(integerMantissa, font: font))
//                assert(totalWidth <= width)
//                return
//            }
//            
//            // the interger is too large: show in scientific notation
//            setScientific(
//                mantissa: mantissa,
//                exponent: exponent,
//                useDisplayBufferExponentFont: true,
//                width: width)
//            assert(totalWidth <= width)
//            return
        }
        
        // scientific
        setScientific(
            mantissa: mantissa,
            exponent: exponent,
            isDisplayBufferExponent: false)
        assert(totalWidth <= width)
        return
    }
//            if exponent >= 0 {
//                // Floating-point representation without scientific notation
//                var floatString: String = mantissa
//                let decimalIndex = floatString.index(floatString.startIndex, offsetBy: exponent + 1)
//                floatString.insert(decimalSeparator.character, at: decimalIndex)
//                floatString = negativeSign + floatString
//                
//                let parts = floatString.split(separator: decimalSeparator.character)
//                let tempMantissa = nonNegativeInjectGrouping(
//                    numberString: String(parts[0]),
//                    decimalSeparator: decimalSeparator,
//                    separateGroups: separateGroups)
//                floatString = tempMantissa + decimalSeparator.string
//                if floatString.textWidth(kerning: kerning, font) < width {
//                    if parts.count == 2 {
//                        let parts_1: String
//                        // truncate!
//                        (parts_1, didOverFlow) = truncate(String(parts[1]), to: width, using: font)
//                        if didOverFlow {
//                            let newMantissaExponent = MantissaExponent(mantissa: negativeSign+parts_1, exponent: exponent + 1)
//                            let newR = Representation(mantissaExponent: newMantissaExponent, font: font, DisplayBufferExponentFont: DisplayBufferExponentFont, decimalSeparator: decimalSeparator, separateGroups: separateGroups, ePadding: ePadding, width: width)
//                            self = newR
//                            return
//                        }
//                        
//                        floatString += parts_1
//                    }
//                    
//                    // Is the dot and one trailing digit still visible in floatString?
//                    if didOverFlow && floatString.hasSuffix(decimalSeparator.string) {
//                        floatString += "0"
//                    }
//
//                    if !floatString.hasSuffix(decimalSeparator.string) {
//                        number = Number(
//                            mantissa: Content(floatString, appleFont: font))
//                        assert(totalWidth <= width)
//                        return
//                    }
//                }  // else: too long for width
//            }
//            if exponent < 0 {
//                // Floating-point representation with leading zeros (exponent is negative)
//                var floatString: String = mantissa
//
//                let zerosToInsert: Int = abs(exponent) - 1
//                let leadingZeros: String = String(repeating: "0", count: zerosToInsert)
//                let beforeFloatString = negativeSign + "0\(decimalSeparator.character)" + leadingZeros
//                let beforeFloatStringLength = beforeFloatString.textWidth(kerning: kerning, font)
//                
//                (floatString, didOverFlow) = truncate(floatString, to: width - beforeFloatStringLength, using: font)
//                if didOverFlow {
//                    let newMantissaExponent = MantissaExponent(mantissa: negativeSign+floatString, exponent: exponent + 1)
//                    let newR = Representation(mantissaExponent: newMantissaExponent, font: font, DisplayBufferExponentFont: DisplayBufferExponentFont, decimalSeparator: decimalSeparator, separateGroups: separateGroups, ePadding: ePadding, width: width)
//                    self = newR
//                    assert(totalWidth <= width)
//                    return
//                }
//                floatString = beforeFloatString + floatString
//                
//                number = Number(
//                    mantissa: Content(floatString, appleFont: font))
//                assert(totalWidth <= width)
//                return
    
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
