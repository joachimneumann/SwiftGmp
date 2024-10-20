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
    if numberString.contains(".") {
        let parts = numberString.split(separator: decimalSeparator.character)
        ret = nonNegativeInjectGrouping(
            numberString: String(parts[0]),
            decimalSeparator: decimalSeparator,
            separateGroups: separateGroups) +
        "."
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
    
    
    //    let parts = numberString.split(separator: decimalSeparator.character)
    //    if parts.count == 2 {
    //        return nonNegativeInjectGrouping(
    //            numberString: String(parts[0]),
    //            decimalSeparator: decimalSeparator,
    //            separateGroups: separateGroups) +
    //            decimalSeparator.rawValue +
    //        parts[1]
    //    } else {
    //        var ret: String = numberString
    //        if separateGroups {
    //            var count = ret.count
    //            while count >= 4 {
    //                count = count - 3
    //                ret.insert(decimalSeparator.groupCharacter, at: ret.index(ret.startIndex, offsetBy: count))
    //            }
    //        }
    //        return ret
    //    }
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
    
    public init(mantissa: String, appleFont: AppleFont) {
        self.error = nil
        self.number = Number(mantissa: Content(mantissa, appleFont: appleFont))
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
        
        // If we've carried over past the first digit.
        var incrementExponent = false
        if shouldRoundUp && index < 0 {
            digits.insert("1", at: 0)
            incrementExponent = true
        }
        
        // Remove any trailing zeros.
        var result = String(digits)
        while result.last == "0" {
            result.removeLast()
        }
        // If the result is empty after trimming, return "0".
        return (result.isEmpty ? "0" : result, incrementExponent)
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
    
    public init(
        mantissaExponent: MantissaExponent,
        proportionalFont: AppleFont,
        monoSpacedFont: AppleFont,
        decimalSeparator: DecimalSeparator,
        separateGroups: Bool,
        ePadding: CGFloat,
        width: CGFloat) {
            self.error = nil
            self.kerning = 0
            self.ePadding = ePadding
            
            // let dummy1 = "1111".textWidth(kerning: 0.0, proportionalFont)
            // let dummy2 = "1111".textWidth(kerning: 0.0, monoSpacedFont)
            
            var mantissa = mantissaExponent.mantissa
            var exponent = mantissaExponent.exponent
            var incrementExponent: Bool = false
            let negativeSign: String
            if mantissa.starts(with: "-") {
                negativeSign = "-"
                mantissa = String(mantissa.dropFirst())
            } else {
                negativeSign = ""
            }
            
            // Integer
            if mantissa.count <= exponent + 1 {
                // Pad mantissa with zeros to match the exponent
                var tempMantissa = mantissa
                tempMantissa = tempMantissa.padding(toLength: exponent + 1, withPad: "0", startingAt: 0)
                tempMantissa = nonNegativeInjectGrouping(
                    numberString: tempMantissa,
                    decimalSeparator: decimalSeparator,
                    separateGroups: separateGroups)
                tempMantissa = negativeSign + tempMantissa
                if tempMantissa.textWidth(kerning: kerning, proportionalFont) <= width {
                    // the interger fits in the display
                    number = Number(mantissa: Content(tempMantissa, appleFont: proportionalFont))
                    return
                }
                
                // the interger is too large: show in scientific notation
                var sciMantissa: String = mantissa
                let decimalIndex = sciMantissa.index(sciMantissa.startIndex, offsetBy: 1)
                sciMantissa.insert(DecimalSeparator.dot.character, at: decimalIndex)
                if sciMantissa.count == 2 {
                    sciMantissa.append("0")
                }
                let exponentString = "e\(exponent)"
                let exponentWidth = exponentString.textWidth(kerning: kerning, monoSpacedFont)
                let remainingMantissaWidth = width - exponentWidth - ePadding
                (sciMantissa, incrementExponent) = truncate(sciMantissa, to: remainingMantissaWidth, using: proportionalFont)
                if incrementExponent { exponent += 1 }
                if sciMantissa.hasSuffix(".") {
                    sciMantissa += "0"
                }
                number = Number(
                    mantissa: Content(sciMantissa, appleFont: proportionalFont),
                    exponent: Content(exponentString, appleFont: monoSpacedFont))
                return
            }
            if exponent >= 0 {
                // Floating-point representation without scientific notation
                var floatString: String = mantissa
                let decimalIndex = floatString.index(floatString.startIndex, offsetBy: exponent + 1)
                floatString.insert(DecimalSeparator.dot.character, at: decimalIndex)
                floatString = negativeSign + floatString
                
                let parts = floatString.split(separator: ".")
                let tempMantissa = nonNegativeInjectGrouping(
                    numberString: String(parts[0]),
                    decimalSeparator: decimalSeparator,
                    separateGroups: separateGroups)
                floatString = tempMantissa + "."
                if floatString.textWidth(kerning: kerning, proportionalFont) < width {
                    if parts.count == 2 {
                        let parts_1: String
                        // truncate!
                        (parts_1, incrementExponent) = truncate(String(parts[1]), to: width, using: proportionalFont)
                        if incrementExponent {
                            let newMantissaExponent = MantissaExponent(mantissa: negativeSign+parts_1, exponent: exponent + 1)
                            let newR = Representation(mantissaExponent: newMantissaExponent, proportionalFont: proportionalFont, monoSpacedFont: monoSpacedFont, decimalSeparator: decimalSeparator, separateGroups: separateGroups, ePadding: ePadding, width: width)
                            self = newR
                            return
                        }
                        
                        floatString += parts_1
                    }
                    
                    // Is the dot and one trailing digit still visible in floatString?
                    if incrementExponent && floatString.hasSuffix(".") {
                        floatString += "0"
                    }

                    if !floatString.hasSuffix(".") {
                        number = Number(
                            mantissa: Content(floatString, appleFont: proportionalFont))
                        return
                    }
                }  // else: too long for width
            }
            if exponent < 0 {
                // Floating-point representation with leading zeros (exponent is negative)
                var floatString: String = mantissa
                let zerosToInsert: Int = abs(exponent) - 1
                let leadingZeros: String = String(repeating: "0", count: zerosToInsert)
                let beforeFloatString = negativeSign + "0." + leadingZeros
                let beforeFloatStringLength = beforeFloatString.textWidth(kerning: kerning, proportionalFont)
                
                (floatString, incrementExponent) = truncate(floatString, to: width - beforeFloatStringLength, using: proportionalFont)
                if incrementExponent {
                    let newMantissaExponent = MantissaExponent(mantissa: negativeSign+floatString, exponent: exponent + 1)
                    let newR = Representation(mantissaExponent: newMantissaExponent, proportionalFont: proportionalFont, monoSpacedFont: monoSpacedFont, decimalSeparator: decimalSeparator, separateGroups: separateGroups, ePadding: ePadding, width: width)
                    self = newR
                    return
                }
                floatString = beforeFloatString + floatString
                
                number = Number(
                    mantissa: Content(floatString, appleFont: proportionalFont))
                return
            }
            
            // Scientific
            var sciMantissa: String = mantissa
            let decimalIndex = sciMantissa.index(sciMantissa.startIndex, offsetBy: 1)
            sciMantissa.insert(DecimalSeparator.dot.character, at: decimalIndex)
            if sciMantissa.count == 2 {
                sciMantissa.append("0")
            }
            var exponentString = "e\(exponent)"
            let exponentWidth = exponentString.textWidth(kerning: kerning, proportionalFont)
            let remainingMantissaWidth = width - exponentWidth - ePadding
            (sciMantissa, incrementExponent) = truncate(sciMantissa, to: remainingMantissaWidth, using: proportionalFont)
            exponentString = "e\(exponent+1)"
            
            number = Number(
                mantissa: Content(sciMantissa, appleFont: proportionalFont),
                exponent: Content(exponentString, appleFont: proportionalFont))
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

//        var tempMantissa = mantissa
//        self.error = nil
//        if tempMantissa.starts(with: "-") {
//            self.isNegative = true
//            tempMantissa = String(tempMantissa.dropFirst())
//        } else {
//            self.isNegative = false
//        }
//
//        let isNegativeSign: String = isNegative ? "-" : ""
//
//        // Integer representation
//        if tempMantissa.count <= exponent + 1 && exponent < maxOutputLength {
//            // Pad mantissa with zeros to match the exponent
//            tempMantissa = tempMantissa.padding(toLength: exponent + 1, withPad: "0", startingAt: 0)
//            self.mantissa = isNegativeSign + tempMantissa
//            self.exponent = nil
//        }
//        // Floating-point representation without scientific notation
//        else if exponent >= 0 && exponent <= maxOutputLength - 3 {
//            var floatString: String = tempMantissa
//            let decimalIndex = floatString.index(floatString.startIndex, offsetBy: exponent + 1)
//            floatString.insert(DecimalSeparator.dot.character, at: decimalIndex)
//            let maxLength: Int = maxOutputLength - isNegativeSign.count
//            self.mantissa = isNegativeSign + String(floatString.prefix(maxLength))
//            self.exponent = nil
//        }
//        // Floating-point representation with leading zeros (exponent is negative)
//        else if exponent < 0 {
//            let zerosToInsert: Int = abs(exponent) - 1
//            let leadingZeros: String = String(repeating: "0", count: zerosToInsert)
//            self.mantissa = isNegativeSign + "0" + DecimalSeparator.dot.rawValue + leadingZeros + tempMantissa
//            let maxLength: Int = maxOutputLength - isNegativeSign.count
//            self.mantissa = String(self.mantissa!.prefix(maxLength))
//            self.exponent = nil
//        }
//        // Scientific notation representation
//        else {
//            var sciMantissa: String = tempMantissa
//            let decimalIndex = sciMantissa.index(sciMantissa.startIndex, offsetBy: 1)
//            sciMantissa.insert(DecimalSeparator.dot.character, at: decimalIndex)
//            if sciMantissa.count == 2 {
//                sciMantissa.append("0")
//            }
//            let exponentString: String = "e\(exponent)"
//            let maxLength: Int = maxOutputLength - isNegativeSign.count - exponentString.count
//            self.mantissa = String(sciMantissa.prefix(maxLength))
//            self.exponent = exponent
//        }
//    }
//
//    func localizedMantissa(decimalSeparator: DecimalSeparator, separateGroups: Bool) -> String? {
//        if var tempMantissa = mantissa {
//            if decimalSeparator != .dot {
//                tempMantissa = tempMantissa.replacingOccurrences(of: DecimalSeparator.dot.rawValue, with: decimalSeparator.rawValue)
//            }
//            tempMantissa = injectGrouping(numberString: tempMantissa, decimalSeparator: decimalSeparator, separateGroups: separateGroups)
//            return tempMantissa
//        }
//        return nil
//    }
//
////    func localizedString(decimalSeparator: DecimalSeparator, separateGroups: Bool) -> String {
////        var tempR = self
////        tempR.mantissa = localizedMantissa(decimalSeparator: decimalSeparator, separateGroups: separateGroups)
////        return tempR.string
////    }
//
//    public var string: String {
//        guard error == nil else { return error! }
//        if let exponent = exponent {
//            if let mantissa = mantissa {
//                return "\(mantissa)e\(exponent)"
//            } else {
//                return "undefined"
//            }
//        } else {
//            if let mantissa = mantissa {
//                return mantissa
//            } else {
//                return "undefined"
//            }
//        }
//    }
//
//    public var double: Double {
//        Double(string) ?? Double.nan
//    }

//extension String {
//    func before(first delimiter: Character) -> String {
//        if let index = firstIndex(of: delimiter) {
//            let before = prefix(upTo: index)
//            return String(before)
//        }
//        return ""
//    }
//
//    func after(first delimiter: Character) -> String {
//        if let index = firstIndex(of: delimiter) {
//            let after = suffix(from: index).dropFirst()
//            return String(after)
//        }
//        return ""
//    }
//
//    func replacingFirstOccurrence(of target: String, with replacement: String) -> String {
//        guard let range = self.range(of: target) else { return self }
//        return self.replacingCharacters(in: range, with: replacement)
//    }
//}

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
