//
//  Representation.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 25.09.24.
//

#if os(macOS)
import AppKit
public typealias AppleFont = NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
import UIKit
public typealias AppleFont = UIFont
#endif


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

public struct Content: CustomDebugStringConvertible {
    public let text: String
    public let appleFont: AppleFont
    init(_ text: String, appleFont: AppleFont) {
        self.text = text
        self.appleFont = appleFont
    }
    public var debugDescription: String {
        text
    }
}

public struct Number: CustomDebugStringConvertible {
    public let mantissa: Content
    public let exponent: Content?
    init(mantissa: Content, exponent: Content? = nil) {
        self.mantissa = mantissa
        self.exponent = exponent
    }
    public var debugDescription: String {
        var ret = mantissa.text
        if let e = exponent {
            ret += "\(e.text)"
        }
        return ret
    }
}

public struct Representation: CustomDebugStringConvertible {
    public var error: Content?
    public var number: Number?
    public var kerning: CGFloat
    var ePadding: CGFloat
    
    public init() {
        error = nil
        number = Number(mantissa: Content("0", appleFont: .systemFont(ofSize: 40)))
        kerning = 0
        ePadding = 0
    }
    
    public init(error: String, appleFont: AppleFont) {
        self.error = Content(error, appleFont: appleFont)
        self.number = nil
        kerning = 0
        ePadding = 0
    }
    
    public init(number: Number) {
        self.error = nil
        self.number = number
        kerning = 0
        ePadding = 0
    }

    public func roundString(_ input: String) -> (String, Bool) {
        // Ensure the input is non-empty.
        guard !input.isEmpty else { return (input, false) }
        
        // If the input has only one character, do nothing
        if input.count == 1 {
            return (input, false)
        }
        
        // Convert the input string into an array of characters.
        var digits = Array(input)
        
        // Remove the last digit to decide rounding.
        let lastDigit = digits.removeLast()
        
        // Determine if we need to round up.
        var shouldRoundUp = lastDigit >= "5"
        
        // Index for the digit to round.
        var index = digits.count - 1
        
        // Perform rounding if necessary.
        while shouldRoundUp && index >= 0 {
            if digits[index] == "9" {
                // Set current digit to '0' and carry over.
                digits[index] = "0"
            } else if let digitValue = digits[index].wholeNumberValue {
                // Increment the current digit.
                let incrementedValue = digitValue + 1
                digits[index] = Character("\(incrementedValue)")
                shouldRoundUp = false  // No more rounding needed.
            }
            index -= 1
        }
        
        var overflow = false
        if shouldRoundUp && index < 0 {
            overflow = true
        }
        
        // Remove any trailing zeros.
        var result = String(digits)
        while result.last == "0" {
            result.removeLast()
        }
        // If the result is empty after trimming, return "0".
        return (result, overflow)
    }
    
    private func truncate(_ string: String, to width: CGFloat, using font: AppleFont) -> (String, Bool) {
        if string.textWidth(kerning: kerning, font) <= width {
            return (string, false)
        }
        // truncate!
        var offset = 1
        var index = string.index(string.startIndex, offsetBy: offset)
        var truncated = String(string.prefix(upTo: index))
        while true {
            if truncated.textWidth(kerning: kerning, font) > width {
                let notRounded = String(string.prefix(upTo: index))
                let rounded = roundString(notRounded)
                return rounded
            }
            
            offset += 1
            index = string.index(string.startIndex, offsetBy: offset)
            truncated = String(string.prefix(upTo: index))
            if index == string.endIndex {
                truncated = truncated.removeTrailingZeroes()
                return (truncated, false)
            }
        }
    }
    
    private var totalWidth: CGFloat {
        var ret: CGFloat = 0
        if let error {
            ret += error.text.textWidth(kerning: kerning, error.appleFont)
        }
        if let number {
            ret += number.mantissa.text.textWidth(kerning: kerning, number.mantissa.appleFont)
            if let exponent = number.exponent {
                ret += ePadding
                ret += exponent.text.textWidth(kerning: kerning, exponent.appleFont)
            }
        }
        return ret
    }
    
    private func incrementString(_ s: String) -> String {
        var ret: String = s
        if ret.last != nil {
            if ret.last == "9" {
                ret.removeLast()
                ret = incrementString(ret)
                ret = ret + "0"
            } else {
                let new = String(Int(String(ret.last!))! + 1)
                ret.removeLast()
                ret = ret + new
            }
        }
        return s
    }
    
    private func float(
    mantissa: String,
    separator: Character,
    font: AppleFont,
    width: CGFloat) -> String {
        var overFlow: Bool
        let decimalIndex = mantissa.index(mantissa.startIndex, offsetBy: 1)
        var floatMantissa = mantissa
        floatMantissa.insert(separator, at: decimalIndex)
        if floatMantissa.count == 2 {
            floatMantissa.append("0")
        }
        let parts = floatMantissa.split(separator: separator)
        var beforeSeparator: String = String(parts[0])
        var beforeSeparatorAndDot = beforeSeparator + String(separator)
        let beforeSeparatorAndDotWidth = beforeSeparatorAndDot.textWidth(kerning: kerning, font)
        var afterSeparator: String = String(parts[1])
        (afterSeparator, overFlow) = truncate(afterSeparator, to: width - beforeSeparatorAndDotWidth, using: font)
        if overFlow {
            beforeSeparator = incrementString(beforeSeparator)
            // TODO: is beforeSeparator now logner: truncate again :(
        }
        return beforeSeparator + String(separator) + afterSeparator
    }
    
    private func scientific(
    mantissa: String,
    exponent: Int,
    separator: Character,
    mantissaFont: AppleFont,
    exponentFont: AppleFont,
    width: CGFloat) -> Representation {
        let exponentString = "e\(exponent)"
        let exponentWidth = exponentString.textWidth(kerning: kerning, exponentFont)
        let remainingMantissaWidth = width - exponentWidth - ePadding
        
        let mantissa = float(
            mantissa: mantissa,
            separator: separator,
            font: mantissaFont,
            width: remainingMantissaWidth)
        
        let number = Number(
            mantissa: Content(mantissa, appleFont: mantissaFont),
            exponent: Content(exponentString, appleFont: exponentFont))
        let R = Representation(number: number)
        assert(R.totalWidth <= width)
        return R
    }
        
    public init(
    mantissaExponent: MantissaExponent,
    font: AppleFont,
    displayBufferExponentFont: AppleFont,
    decimalSeparator: DecimalSeparator,
    separateGroups: Bool,
    ePadding: CGFloat,
    width: CGFloat) {
        self.error = nil
        self.kerning = 0
        self.ePadding = ePadding
        
        // let dummy1 = "1111".textWidth(kerning: 0.0, font)
        // let dummy2 = "1111".textWidth(kerning: 0.0, DisplayBufferExponentFont)
        
        var mantissa = mantissaExponent.mantissa
        var exponent = mantissaExponent.exponent

        let negativeSign: String
        if mantissa.starts(with: "-") {
            negativeSign = "-"
            mantissa = String(mantissa.dropFirst())
        } else {
            negativeSign = ""
        }
        
        /// can the number be displayed in the non-scientific format (integer or float)?
        ///
        //
        // write tests for round()
        // write tests for truncate()
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
        
        // Integer
        if mantissa.count <= exponent + 1 {
            
            // Pad mantissa with zeros to match the exponent
            var integerMantissa = mantissa.padding(toLength: exponent + 1, withPad: "0", startingAt: 0)
            integerMantissa = nonNegativeInjectGrouping(
                numberString: integerMantissa,
                decimalSeparator: decimalSeparator,
                separateGroups: separateGroups)
            integerMantissa = negativeSign + integerMantissa
            
            if integerMantissa.textWidth(kerning: kerning, font) <= width {
                // the interger fits in the display
                number = Number(mantissa: Content(integerMantissa, appleFont: font))
                assert(totalWidth <= width)
                return
            }
            
            // the interger is too large: show in scientific notation
            self = scientific(
                mantissa: mantissa,
                exponent: exponent,
                separator: decimalSeparator.character,
                mantissaFont: font,
                exponentFont: displayBufferExponentFont,
                width: width)
            assert(totalWidth <= width)
            return
        }
        
        // scientific
        self = scientific(
            mantissa: mantissa,
            exponent: exponent,
            separator: decimalSeparator.character,
            mantissaFont: font,
            exponentFont: font,
            width: width)
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

extension String {
    func textWidth(kerning: CGFloat, _ font: AppleFont) -> CGFloat {
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.kern] = kerning
        attributes[.font] = font
        return self.size(withAttributes: attributes).width
    }
    
    func textHeight(kerning: CGFloat, _ font: AppleFont) -> CGFloat {
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.kern] = kerning
        attributes[.font] = font
        return self.size(withAttributes: attributes).height
    }
    
}
