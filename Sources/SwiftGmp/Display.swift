//
//  Display.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 25.10.2024.
//

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
    
    init(raw: Raw, displayLength: Int, decimalSeparator: Character) {
        
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
        if raw.exponent >= 0 && raw.exponent < displayLength - 2 {
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
        left = "0"
        right = nil
        type = .unknown
    }
}
