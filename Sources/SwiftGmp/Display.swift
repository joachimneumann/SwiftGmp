//
//  Display.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 25.10.2024.
//

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
    init(raw: Raw, displayLength l: Int? = nil, decimalSeparator: Character = ".") {
        let displayLength = l ?? raw.length
        // is raw an integer?
        if
        // only allow numbers > 1.0, i.e., exponents >0 =
        raw.exponent >= 0 &&
        // only allow small enough exponents. 100 has exponent 2, therefore + 1
        raw.exponent + 1 <= displayLength - length(raw.negativeSign) &&
        // only mantissas that are equal or shorter than the exponent + 1
        length(raw.mantissa) <= raw.exponent + 1 &&
        // only mantissas that are equal or shorter than the displayLength
        length(raw.negativeSign + raw.mantissa) <= displayLength {
            if length(raw.mantissa) < raw.exponent + 1 {
                var temp = raw.mantissa
                while length(temp) < raw.exponent + 1 {
                    temp = temp + "0"
                }
                left = raw.negativeSign + temp
            } else {
                left = raw.negativeSign + raw.mantissa
            }
            right = nil
            type = .integer
            return
        }
        
        // float > 1.0?
        if raw.exponent >= 0 && raw.exponent < displayLength - 2 - length(raw.negativeSign) {
            var temp = raw.mantissa
            let dotIndex = temp.index(temp.startIndex, offsetBy: raw.exponent + 1)
            temp.insert(decimalSeparator, at: dotIndex)
            temp = raw.negativeSign + temp
            temp = String(temp.prefix(displayLength))
            left = temp
            right = nil
            type = .floatLargerThanOne
            return
        }

        // float < 1.0?
        if raw.exponent < 0 && -1 * raw.exponent <= displayLength - 2 - length(raw.negativeSign) {
            var temp = raw.mantissa
            for _ in 0 ..< (-1 * raw.exponent) {
                temp = "0" + temp
            }
            let dotIndex = temp.index(temp.startIndex, offsetBy: 1)
            temp.insert(decimalSeparator, at: dotIndex)
            temp = raw.negativeSign + temp
            temp = String(temp.prefix(displayLength))
            left = temp
            right = nil
            type = .floatSmallerThanOne
            return
        }

        // Scientific!
        var temp = raw.mantissa
        let dotIndex = temp.index(temp.startIndex, offsetBy: 1)
        temp.insert(decimalSeparator, at: dotIndex)
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
