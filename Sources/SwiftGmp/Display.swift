//
//  Display.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 25.10.2024.
//

import Foundation

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

struct Display {
    
    public var length: (String) -> Int = { s in
        s.count
    }
    
    public enum DisplayType {
        case unknown
        case integer
        case floatLargerThanOne
        case floatSmallerThanOne
        case scientifiNotation
    }
    let left: String
    let right: String?
    let type: DisplayType
    
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
    
    init(_ left: String, right: String? = nil, type: DisplayType = .unknown) {
        self.left = left
        self.right = right
        self.type = type
    }
    
    init(raw: Raw, displayLength l: Int? = nil, decimalSeparator: DecimalSeparator = DecimalSeparator.dot, separateGroups: Bool = false) {
        let displayLength = l ?? raw.length
        // is raw an integer?
        if
            
            // only allow numbers > 1.0, i.e., exponents >0 =
            raw.exponent >= 0 &&
                
            // only mantissas that are equal or shorter than the exponent + 1
            length(raw.mantissa) <= raw.exponent + 1 &&
            
            // only allow small enough exponents. 100 has exponent 2, therefore + 1
            raw.exponent + 1 <= displayLength - length(raw.negativeSign) &&
            
            // only mantissas that are equal or shorter than the displayLength
            length(raw.negativeSign + raw.mantissa) <= displayLength {
            
            var temp = raw.mantissa
            if length(raw.mantissa) < raw.exponent + 1 {
                // mantissa has the lenth that is smaller than the exponent:
                // --> not all digits are in the mantissa
                // --> add 0 at the end
                while length(temp) < raw.exponent + 1 {
                    temp = temp + "0"
                }
            }
            // add grouping
            if separateGroups {
                temp.injectGrouping(decimalSeparator.groupCharacter)
            }
            // check again if the Integer still fits into the display
            if length(temp) <= displayLength {
                left = raw.negativeSign + temp
                right = nil
                type = .integer
                return
            }
        }
        
        // float > 1.0?
        if raw.exponent >= 0 && raw.exponent < displayLength - 2 - length(raw.negativeSign) {
            var temp = raw.mantissa
                       
            var beforeSeparator = temp.sub(to: raw.exponent + 1)
            var afterSeparator = temp.sub(from: raw.exponent + 1)
            if separateGroups {
                beforeSeparator.injectGrouping(decimalSeparator.groupCharacter)
            }
            let remainingLength = displayLength - length(beforeSeparator) - length(decimalSeparator.string) - length(raw.negativeSign)
            if remainingLength >= 1 {
                afterSeparator = String(afterSeparator.prefix(remainingLength))
                temp = raw.negativeSign + beforeSeparator + decimalSeparator.string + afterSeparator
                left = temp
                right = nil
                type = .floatLargerThanOne
                return
            }
        }
        
        // float < 1.0?
        if raw.exponent < 0 && -1 * raw.exponent <= displayLength - 2 - length(raw.negativeSign) {
            var temp = raw.mantissa
            for _ in 0 ..< (-1 * raw.exponent) {
                temp = "0" + temp
            }
            temp.insert(decimalSeparator.character, at: 1)
            temp = raw.negativeSign + temp
            temp = String(temp.prefix(displayLength))
            left = temp
            right = nil
            type = .floatSmallerThanOne
            return
        }
        
        // Scientific!
        var temp = raw.mantissa
        temp.insert(decimalSeparator.character, at: 1)
        if temp.count == 2 {
            temp = temp + "0"
        }
        temp = raw.negativeSign + temp
        
        let exponentString: String = "e\(raw.exponent)"
        temp = String(temp.prefix(displayLength - length(exponentString)))
        left = temp
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

    func sub(from index: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: index)
        return String(self[start...])
    }

    func sub(to index: Int) -> String {
        let end = self.index(self.startIndex, offsetBy: index)
        return String(self[..<end])
    }

    func sub(from index1: Int, to index2: Int) -> String {
        let start = index(startIndex, offsetBy: index1)
        let end = index(startIndex, offsetBy: index2)
        return String(self[start..<end])
    }
    
    mutating func insert(_ c: Character, at: Int) {
        let index = self.index(self.startIndex, offsetBy: at)
        self.insert(c, at: index)

    }
}
