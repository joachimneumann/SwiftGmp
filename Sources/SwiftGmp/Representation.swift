//
//  Representation.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 25.09.24.
//

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

    protocol Separators {
        var decimalSeparator: DecimalSeparator   { get }
        var groupingSeparator: GroupingSeparator { get }
    }

    enum DecimalSeparator: String, Codable, CaseIterable{
        case comma
        case dot
        var character: Character {
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
    }
    enum GroupingSeparator: String, Codable, CaseIterable{
        case comma
        case dot
        case none
        var character: Character? {
            get {
                switch self {
                case .none: return nil
                case .comma: return ","
                case .dot: return "."
                }
            }
        }
        var string: String {
            get {
                guard let character = character else { return "" }
                return String(character)
            }
        }
    }


    var allInOneLine: String {
        if let error { return error }
        guard var mantissa = mantissa else { return "Invalid" }
        guard let exponent = exponent else { return "Invalid" }
        let secondIndex = mantissa.index(mantissa.startIndex, offsetBy: 1)
        mantissa.insert(".", at: secondIndex)
        return (isNegative ? "-" : "") + "\(mantissa)e\(exponent)"
    }
    
    func toDouble() -> Double {
        guard error == nil else { return Double.nan }
        guard mantissa != nil else { return Double.nan }
        if let d = Double(allInOneLine) {
            return d
        } else {
            return Double.nan
        }
    }

    func LR(groupingSeparator: GroupingSeparator = .none, decimalSeparator: DecimalSeparator = .dot) -> (String, String?) {
        guard error == nil else { return (error!, nil) }
        guard var mantissa = mantissa else { return ("Invalid", nil) }
        guard let exponent = exponent else { return ("Invalid", nil) }
        
        if mantissa.count <= exponent + 1 {
            // integer
            mantissa = mantissa.padding(toLength: exponent+1, withPad: "0", startingAt: 0)
            let intString = (isNegative ? "-" : "") +
            injectSeparators(numberString: mantissa, groupingSeparator: groupingSeparator, decimalSeparator: decimalSeparator)
            return (intString, nil)
        } else {
            // float
            if exponent >= 0 {
                var floatString = mantissa
                let index = floatString.index(floatString.startIndex, offsetBy: exponent+1)
                //var indexInt: Int = floatString.distance(from: floatString.startIndex, to: index)
                floatString.insert(decimalSeparator.character, at: index)
                return ((isNegative ? "-" : "") + floatString, nil)
            }
            if exponent < 0 {
                var floatString = mantissa
                for _ in 0..<(-1*exponent - 1) {
                    floatString = "0" + floatString
                }
                return ((isNegative ? "-" : "") + "0" + decimalSeparator.string + floatString, nil)
            }
            
            // scientific notation required
            let secondIndex = mantissa.index(mantissa.startIndex, offsetBy: 1)
            mantissa.insert(decimalSeparator.character, at: secondIndex)
            let exponentString = "e\(exponent)"
            return ((isNegative ? "-" : "") + mantissa+exponentString, nil)
        }
    }

    func toString(groupingSeparator: GroupingSeparator = .none, decimalSeparator: DecimalSeparator = .dot) -> String {
        return LR().0
    }

    private func injectSeparators(numberString: String, groupingSeparator: GroupingSeparator, decimalSeparator: DecimalSeparator) -> String {
        if numberString.starts(with: "-") {
            return "-" + nonNegativeInjectSeparators(numberString: String(numberString.dropFirst()), groupingSeparator: groupingSeparator, decimalSeparator: decimalSeparator)
        } else {
            return nonNegativeInjectSeparators(numberString: numberString, groupingSeparator: groupingSeparator, decimalSeparator: decimalSeparator)
        }
    }

    private func nonNegativeInjectSeparators(numberString: String, groupingSeparator: GroupingSeparator, decimalSeparator: DecimalSeparator) -> String {
        var ret: String = numberString
        if let c = groupingSeparator.character {
            var count = ret.count
            while count >= 4 {
                count = count - 3
                ret.insert(c, at: ret.index(ret.startIndex, offsetBy: count))
            }
        }
        return ret
    }
            
//    func representation(forceScientific: Bool) -> Representation {
//        if let str = str {
//            let signAndSeparator: String
//            if str.starts(with: "-") {
//                signAndSeparator = withSeparators(numberString: String(str.dropFirst()), isNegative: true)
//            } else {
//                signAndSeparator = withSeparators(numberString: str, isNegative: false)
//            }
//            return Representation(left: signAndSeparator)
//        }
//        
//        if swiftGmp.isNan {
//            return Representation(left: "not a number")
//        }
//        if swiftGmp.isInf {
//            return Representation(left: "infinity")
//        }
//
//        if swiftGmp.isZero {
//            return Representation(left: "0")
//        }
//
//        let mantissaLength: Int
//        mantissaLength = precision // approximation: accept integers with length = precision
//        var (mantissa, exponent) = swiftGmp.mantissaExponent(len: mantissaLength)
//        
//        var returnValue: Representation = Representation(left: "error")
//        
//        if mantissa.isEmpty {
//            mantissa = "0"
//        }
//        
//        /// negative? Special treatment
//        let isNegative = mantissa.first == "-"
//        if isNegative {
//            mantissa.removeFirst()
//        }
//        
//        /// Can be displayed as Integer?
//        /*
//         123,456,789,012,345,678,901,123,456 --> 400 pixel
//         What can be displayed in 200 pixel?
//         - I dont want the separator as leading character!
//         */
//        if mantissa.count <= exponent + 1 && !forceScientific { /// smaller than because of possible trailing zeroes in the integer
//            mantissa = mantissa.padding(toLength: exponent+1, withPad: "0", startingAt: 0)
//            let withSeparators = withSeparators(numberString: mantissa, isNegative: isNegative)
//            returnValue.left = withSeparators
//            return returnValue
//        }
//        
//        /// Is floating point XXX,xxx?
//        if exponent >= 0 && !forceScientific {
//            var floatString = mantissa
//            let index = floatString.index(floatString.startIndex, offsetBy: exponent+1)
//            //var indexInt: Int = floatString.distance(from: floatString.startIndex, to: index)
//            floatString.insert(".", at: index)
//            floatString = withSeparators(numberString: floatString, isNegative: isNegative)
//            returnValue.left = floatString
//            return returnValue
//            /// is the comma visible in the first line and is there at least one digit after the comma?
//        }
//        
//        /// is floating point 0,xxxx
//        /// additional requirement: first non-zero digit in first line. If not -> Scientific
//        if exponent < 0 && !forceScientific {
//            let minusSign = isNegative ? "-" : ""
//            
//            var testFloat = minusSign + "0" + decimalSeparator.string
//            var floatString = mantissa
//            for _ in 0..<(-1*exponent - 1) {
//                floatString = "0" + floatString
//                testFloat += "0"
//            }
//            testFloat += "x"
//            floatString = minusSign + "0" + decimalSeparator.string + floatString
//            returnValue.left = floatString
//            return returnValue
//        }
//        
//        if isNegative {
//            mantissa.removeFirst()
//        }
//        
//        let secondIndex = mantissa.index(mantissa.startIndex, offsetBy: 1)
//        mantissa.insert(".", at: secondIndex)
//        if mantissa.count == 2 {
//            // 4.
//            mantissa.append("0")
//        }
//        mantissa = withSeparators(numberString: mantissa, isNegative: isNegative)
//        let exponentString = "e\(exponent)"
//        returnValue.left = mantissa
//        returnValue.right = exponentString
//        return returnValue
//    }

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
