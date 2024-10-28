//
//  IntDisplay.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 25.10.2024.
//

import Foundation

public struct Separator: Codable {
    public enum SeparatorType: String, Codable, CaseIterable {
        case comma = ","
        case dot = "."
    }

    public init(separatorType: SeparatorType, groups: Bool) {
        self.separatorType = separatorType
        self.groups = groups
    }
    
    public var separatorType: SeparatorType
    public var groups: Bool

    public var character: Character {
        get {
            switch self.separatorType {
            case .comma: return ","
            case .dot: return "."
            }
        }
    }
    public var string: String {
        get {
            switch self.separatorType {
            case .comma: return ","
            case .dot: return "."
            }
        }
    }
    public var groupCharacter: Character? {
        get {
            if groups {
                switch self.separatorType {
                case .comma: return "."
                case .dot: return ","
                }
            } else {
                return nil
            }
        }
    }
    public var groupString: String? {
        get {
            if groups {
                switch self.separatorType {
                case .comma: return "."
                case .dot: return ","
                }
            } else {
                return nil
            }
        }
    }

}

/// Note:
///
/// To get a string of length displayWidth, I typically start with a small string and then
/// try adding one digit at a time until it does not fit in the display.
///
/// This logic is unneccesarly complicated for a test Display with Integer String lengths.
/// But this will allow to inherit a class FloatDisplay that uses a proportional font and
/// a displaywidth that is a CGFloat.
///

open class IntDisplay {
    public enum DisplayType {
        case unknown
        case integer
        case floatLargerThanOne
        case floatSmallerThanOne
        case scientifiNotation
    }
    public var left: String
    public var right: String?
    var type: DisplayType

    var displayWidth: Int
    var separator: Separator
    
    var maxDigits: Int {
        displayWidth
    }

    var string: String {
        switch type {
        case .unknown:
            return ""
        case .scientifiNotation:
            return left + (right ?? "")
        default:
            return left
        }
    }
    
    open func fits(_ mantissa: String, _ exponent: String? = nil) -> Bool {
        mantissa.count + (exponent != nil ? exponent!.count : 0) <= displayWidth
    }
    func repeatWidestDigit(_ count: Int) -> String { String(repeating: "0", count: count) }
    func repeatNarrowestDigit(_ count: Int) -> String { String(repeating: "0", count: count) }

    public init(displayWidth: Int, separator: Separator = Separator(separatorType: .dot, groups: false)) {
        self.displayWidth = displayWidth
        self.separator = separator
        self.left = "0"
        self.right = nil
        self.type = .unknown
    }
    
    public func update(raw: Raw) {
        // is raw an integer?
        if
            raw.canBeInteger &&
                
            // Math: only allow numbers > 1.0, i.e., exponents >0 =
            raw.exponent >= 0 &&
                
            // Math: only mantissas that are equal or shorter than the exponent + 1
            raw.mantissa.count <= raw.exponent + 1 &&
            
            // Logic: only allow small enough exponents. 100 has exponent 2, therefore + 1
            raw.exponent + 1 + raw.negativeSign.count <= maxDigits
        {
            
            var temp = raw.mantissa
            if raw.mantissa.count < raw.exponent + 1 {
                // mantissa has the lenth that is smaller than the exponent:
                // --> not all digits are in the mantissa
                // --> add 0 at the end
                while temp.count < raw.exponent + 1 {
                    temp = temp + "0"
                }
            }
            
            // add grouping
            if let c = separator.groupCharacter {
                temp.injectGrouping(c)
            }
            
            // check if the Integer fits into the display
            if fits(raw.negativeSign + temp) {
                left = raw.negativeSign + temp
                right = nil
                type = .integer
                return
            }
        }
        
        // float > 1.0?
        if
            // Math
            raw.exponent >= 0 &&
            
            // check if the float may fit into the display
            fits(raw.negativeSign + repeatNarrowestDigit(raw.exponent+1) + "." + repeatNarrowestDigit(1))
        {
            
            // group separator
            var beforeSeparator = raw.mantissa.sub(to: raw.exponent + 1)
            if let c = separator.groupCharacter {
                beforeSeparator.injectGrouping(c)
            }
            
            let afterSeparator = raw.mantissa.sub(from: raw.exponent + 1)
            
            if afterSeparator.count > 0 {
                var temp = beforeSeparator + separator.string + afterSeparator.at(0)
                var digitIndex = 1
                while
                    digitIndex < afterSeparator.count &&
                    fits(raw.negativeSign + temp + afterSeparator.at(digitIndex))
                {
                    temp = temp + afterSeparator.at(digitIndex)
                    digitIndex += 1
                }
                left = raw.negativeSign + temp
                right = nil
                type = .floatLargerThanOne
                return
            }
        }
        
        // float < 1.0?
        if
            // Math
            raw.exponent < 0 &&
            raw.mantissa.count > 0 &&

            // 0.001 --> exponent = -3
            fits(repeatNarrowestDigit(0) + separator.string + repeatNarrowestDigit(-1 * raw.exponent))
        {
            var temp = "0."
            for _ in 1 ..< (-1 * raw.exponent) {
                temp += "0"
            }
            temp += raw.mantissa.at(0)
            if fits(raw.negativeSign + temp) {
                var digitIndex = 1
                while
                    digitIndex < raw.mantissa.count &&
                    fits(raw.negativeSign + temp + raw.mantissa.at(digitIndex))
                {
                    temp += raw.mantissa.at(digitIndex)
                    digitIndex += 1
                }
                left = raw.negativeSign + temp
                right = nil
                type = .floatSmallerThanOne
                return
            }
        }
        
        // Scientific. Must work.
        var exponentString: String = "e\(raw.exponent)"
        // add grouping
        if let c = separator.groupCharacter {
            exponentString.injectGrouping(c)
        }

        guard raw.mantissa.count >= 1 else {
            left = "error"
            right = nil
            type = .unknown
            return
        }
        
        var mantissaString = raw.mantissa.at(0) + separator.string
        if raw.mantissa.count == 1 {
            mantissaString += "0"
        }
        
        var digitIndex = 1
        while
            digitIndex < raw.mantissa.count &&
            fits(raw.negativeSign + mantissaString + raw.mantissa.at(digitIndex), exponentString)
        {
            mantissaString += raw.mantissa.at(digitIndex)
            digitIndex += 1
        }
        left = raw.negativeSign + mantissaString
        right = exponentString
        type = .scientifiNotation
    }
}

extension String {
    mutating func injectGrouping(_ c: Character) {
        var count = self.count
        while count >= 4 {
            count = count - 3
            self.insert(c, at: count)
        }
    }

    func sub(from position: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: position)
        return String(self[start...])
    }

    func sub(to position: Int) -> String {
        let end = self.index(self.startIndex, offsetBy: position)
        return String(self[..<end])
    }

    func at(_ position: Int) -> String {
        sub(from: position, to: position+1)
    }

    func sub(from position1: Int, to position2: Int) -> String {
        let start = index(startIndex, offsetBy: position1)
        let end = index(startIndex, offsetBy: position2)
        return String(self[start..<end])
    }
    
    mutating func insert(_ c: Character, at: Int) {
        let position = self.index(self.startIndex, offsetBy: at)
        self.insert(c, at: position)

    }
}
