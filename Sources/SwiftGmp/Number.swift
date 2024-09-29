//
//  Number.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 23.09.24.
//


import Foundation

public class Number: CustomDebugStringConvertible, Separators, ShowAs {
    var showAsInt: Bool = false
    var showAsFloat: Bool = false
    
    var decimalSeparator: DecimalSeparator = DecimalSeparator.dot
    var groupingSeparator: GroupingSeparator = GroupingSeparator.none
    
    public var debugDescription: String {
        if let _str {
            return "\(_str) precision \(precision) string"
        }
        return "\(_swiftGmp!.toDouble())  precision \(precision) gmp"
    }

    public private(set) var precision: Int = 0
    
    func setPrecision(_ newPrecision: Int) {
        precision = newPrecision
        swiftGmp.setBits(bits(for: precision))
    }
    
    public init(_ str: String, precision: Int) {
        _str = str
        _swiftGmp = nil
        self.precision = precision
    }

    public init(precision: Int) {
        _str = "0"
        _swiftGmp = nil
        self.precision = precision
    }

    public init(_ d: Double, precision: Int) {
        _str = nil
        _swiftGmp = SwiftGmp(withString: String(d), bits: bits(for: precision))
    }
    private init(_ gmp: SwiftGmp) {
        _str = nil
        _swiftGmp = gmp.copy()
        self.precision = precision(for: gmp.bits)
    }

    private var _str: String?
    private var _swiftGmp: SwiftGmp?
//    
    private var isStr: Bool { _str != nil }
    private var isSwiftGmp: Bool { _swiftGmp != nil }
    private var str: String? { return _str }
    public var swiftGmp: SwiftGmp {
        if isStr {
            _swiftGmp = SwiftGmp(withString: str!, bits: bits(for: precision))
            _str = nil
        }
        return _swiftGmp!
    }
//    public func toDouble() -> Double? {
//        if isStr {
//            let asDouble = Double(str!)
//            if (asDouble != nil) {
//                return asDouble!
//            } else {
//                return nil
//            }
//        }
//        return swiftGmp.toDouble()
//    }
//    
//    public static func ==(lhs: Number, rhs: Number) -> Bool {
//        if lhs.precision != rhs.precision { return false }
//
//        let selfIsStr = lhs.isStr
//        let otherIsStr = rhs.isStr
//        if selfIsStr && otherIsStr {
//            return lhs.str == rhs.str
//        }
//
//        let l = lhs
//        let r = rhs
//        return l.swiftGmp == r.swiftGmp
//    }
//    public static func !=(lhs: Number, rhs: Number) -> Bool {
//        return !(lhs == rhs)
//    }
//    public static func +(lhs: Number, rhs: Number) -> Number {
//        return Number(lhs.swiftGmp + rhs.swiftGmp)
//    }
//    public static func +(lhs: Double, rhs: Number) -> Number {
//        let l = Number(lhs, precision: rhs.precision)
//        return Number(l.swiftGmp + rhs.swiftGmp)
//    }
//    public static func +(lhs: Number, rhs: Double) -> Number {
//        let r = Number(rhs, precision: lhs.precision)
//        return Number(lhs.swiftGmp + r.swiftGmp)
//    }
//
//    public static func -(lhs: Number, rhs: Number) -> Number {
//        return Number(lhs.swiftGmp - rhs.swiftGmp)
//    }
//    public static func -(lhs: Double, rhs: Number) -> Number {
//        let l = Number(lhs, precision: rhs.precision)
//        return Number(l.swiftGmp - rhs.swiftGmp)
//    }
//    public static func -(lhs: Number, rhs: Double) -> Number {
//        let r = Number(rhs, precision: lhs.precision)
//        return Number(lhs.swiftGmp - r.swiftGmp)
//    }
//
//    public static func *(lhs: Number, rhs: Number) -> Number {
//        return Number(lhs.swiftGmp * rhs.swiftGmp)
//    }
//    public static func *(lhs: Double, rhs: Number) -> Number {
//        let l = Number(lhs, precision: rhs.precision)
//        return Number(l.swiftGmp * rhs.swiftGmp)
//    }
//    public static func *(lhs: Number, rhs: Double) -> Number {
//        let r = Number(rhs, precision: lhs.precision)
//        return Number(lhs.swiftGmp * r.swiftGmp)
//    }
//
//    public static func /(lhs: Number, rhs: Number) -> Number {
//        return Number(lhs.swiftGmp / rhs.swiftGmp)
//    }
//    public static func /(lhs: Double, rhs: Number) -> Number {
//        let l = Number(lhs, precision: rhs.precision)
//        return Number(l.swiftGmp / rhs.swiftGmp)
//    }
//    public static func /(lhs: Number, rhs: Double) -> Number {
//        let r = Number(rhs, precision: lhs.precision)
//        return Number(lhs.swiftGmp / r.swiftGmp)
//    }
//
    public var isNaN: Bool {
        get {
            if isStr { return false }
            return swiftGmp.isNan
        }
    }
    public var isValid: Bool {
        get {
            if isStr { return true }
            return swiftGmp.isValid
        }
    }

    public var isInfinity: Bool {
        get {
            if isStr { return str == "infinity" }
            return swiftGmp.isInf
        }
    }

    fileprivate func copy() -> Number {
        if isStr {
            return Number(str!, precision: precision)
        } else {
            return Number(swiftGmp.copy())
        }
    }
//
//    public func similarTo(_ other: Double, precision: Double = 1e-3) -> Bool {
//        guard let d = self.copy().toDouble() else { return false }
//        return abs(d - other) <= precision
//    }
//    public func similarTo(_ other: Number, precision: Double = 1e-3) -> Bool {
//        guard let d1 = self.copy().toDouble() else { return false }
//        guard let d2 = other.copy().toDouble() else { return false }
//        return abs(d1 - d2) <= precision
//    }
//
//    //
//    // inplace
//    //
////    public inPlace(op: InPlace) {
//        
//    }
//    private func inplace_zero()       { swiftGmp.zero() }
//    private func inplace_π()          { swiftGmp.π() }
//    private func inplace_e()          { swiftGmp.e() }
//    private func inplace_rand()       { swiftGmp.rand() }
//    private func inplace_abs()        { swiftGmp.abs() }
//    private func inplace_sqrt()       { swiftGmp.sqrt() }
//    private func inplace_sqrt3()      { swiftGmp.sqrt3() }
//    private func inplace_Z()          { swiftGmp.Z() }
//    private func inplace_ln()         { swiftGmp.ln() }
//    private func inplace_log10()      { swiftGmp.log10() }
//    private func inplace_log2()       { swiftGmp.log2() }
//    private func inplace_sin()        { swiftGmp.sin() }
//    private func inplace_cos()        { swiftGmp.cos() }
//    private func inplace_tan()        { swiftGmp.tan() }
//    private func inplace_asin()       { swiftGmp.asin() }
//    private func inplace_acos()       { swiftGmp.acos() }
//    private func inplace_atan()       { swiftGmp.atan() }
//    private func inplace_sinh()       { swiftGmp.sinh() }
//    private func inplace_cosh()       { swiftGmp.cosh() }
//    private func inplace_tanh()       { swiftGmp.tanh() }
//    private func inplace_asinh()      { swiftGmp.asinh() }
//    private func inplace_acosh()      { swiftGmp.acosh() }
//    private func inplace_atanh()      { swiftGmp.atanh() }
//    private func inplace_sqr()        { swiftGmp.sqr() }
//    private func inplace_cubed()      { swiftGmp.cubed() }
//    private func inplace_exp()        { swiftGmp.exp() }
//    private func inplace_exp2()       { swiftGmp.exp2() }
//    private func inplace_exp10()      { swiftGmp.exp10() }
//    private func inplace_changeSign() { swiftGmp.changeSign() }
//    private func inplace_rez()        { swiftGmp.rez() }
//    private func inplace_fac()        { swiftGmp.fac() }
//    private func inplace_sinD()       { swiftGmp.sinD() }
//    private func inplace_cosD()       { swiftGmp.cosD() }
//    private func inplace_tanD()       { swiftGmp.tanD() }
//    private func inplace_asinD()      { swiftGmp.asinD() }
//    private func inplace_acosD()      { swiftGmp.acosD() }
//    private func inplace_atanD()      { swiftGmp.atanD() }
//    
//    //
//    // twoOperant
//    //
//    public func add(other: Number)        { swiftGmp.add(other: other.swiftGmp) }
//    public func sub(other: Number)        { swiftGmp.sub(other: other.swiftGmp) }
//    public func mul(other: Number)        { swiftGmp.mul(other: other.swiftGmp) }
//    public func div(other: Number)        { swiftGmp.div(other: other.swiftGmp) }
//    public func pow_x_y(exponent: Number) { swiftGmp.pow_x_y(exponent: exponent.swiftGmp) }
//    public func pow_y_x(base: Number)     { swiftGmp.pow_y_x(base: base.swiftGmp) }
//    public func sqrty(exponent: Number)   { swiftGmp.sqrty(exponent: exponent.swiftGmp) }
//    public func logy(base: Number)        { swiftGmp.logy(base: base.swiftGmp) }
//    public func EE(other: Number)         { swiftGmp.EE(other: other.swiftGmp) }
//    
//    public func setValue(other number: Number) {
//        if number.isStr {
//            _str = number.str
//            _swiftGmp = nil
//        } else {
//            swiftGmp.setValue(other: number.swiftGmp)
//        }
//    }
//    
//    public func append(_ digit: String) {
//        if !isStr {
//            _str = digit
//            _swiftGmp = nil
//        } else if _str == "0" {
//            _str = digit
//        } else {
//            _str!.append(digit)
//        }
//    }
//    
//    public func appendDot() {
//        if _str == nil {
//            _str = "0."
//            _swiftGmp = nil
//        } else {
//            if !_str!.contains(".") { _str!.append(".") }
//        }
//    }
//    public var isNegative: Bool {
//        get {
//            if let _str {
//                return _str.starts(with: "-")
//            } else {
//                return swiftGmp.isNegative()
//            }
//        }
//    }
//    public func changeSign() {
//        if _str == nil {
//            swiftGmp.changeSign()
//        } else {
//            if _str! == "0" { return }
//            if _str!.starts(with: "-") {
//                _str!.removeFirst()
//            } else {
//                _str! = "-" + _str!
//            }
//        }
//    }
//        
    func internalPrecision(for precision: Int) -> Int {
        return precision
//        if precision <= 500 {
//            return 1000
//        } else if precision <= 10000 {
//            return 2 * precision
//        } else if precision <= 100000 {
//            return Int(round(1.5*Double(precision)))
//        } else {
//            return precision + 50000
//        }
    }
    
    func bits(for precision: Int) -> Int {
        Int(Double(internalPrecision(for: precision)) * 3.32192809489)
    }
    func precision(for bits: Int) -> Int {
        Int(Double(precision) / 3.32192809489)
    }


    private func withSeparators(numberString: String, isNegative: Bool, separators: Separators) -> String {
        var integerPart: String
        let fractionalPart: String
        
        if numberString.contains(".") {
            integerPart = numberString.before(first: ".")
            fractionalPart = numberString.after(first: ".")
        } else {
            /// integer
            integerPart = numberString
            fractionalPart = ""
        }
        
        if let c = separators.groupingSeparator.character {
            var count = integerPart.count
            while count >= 4 {
                count = count - 3
                integerPart.insert(c, at: integerPart.index(integerPart.startIndex, offsetBy: count))
            }
        }
        let minusSign = isNegative ? "-" : ""
        if numberString.contains(".") {
            return minusSign + integerPart + separators.decimalSeparator.string + fractionalPart
        } else {
            return minusSign + integerPart
        }
    }
        
    private func fromStringNumber(
        _ stringNumber: String,
        separators: Separators,
        showAs: ShowAs,
        forceScientific: Bool) -> NumberRepresentation {
        
        assert(!stringNumber.contains(","))
        assert(!stringNumber.contains("e"))
            
        let signAndSeparator: String
        if stringNumber.starts(with: "-") {
            signAndSeparator = withSeparators(numberString: String(stringNumber.dropFirst()), isNegative: true, separators: separators)
        } else {
            signAndSeparator = withSeparators(numberString: stringNumber, isNegative: false, separators: separators)
        }
        return NumberRepresentation(left: signAndSeparator)
    }
    
    public func representation() -> NumberRepresentation {
        if let str = _str {
            return fromStringNumber(str, separators: self, showAs: self, forceScientific: false)
        }
        
        if swiftGmp.isNan {
            return NumberRepresentation(left: "not a number")
        }
        if swiftGmp.isInf {
            return NumberRepresentation(left: "infinity")
        }

        if swiftGmp.isZero {
            return NumberRepresentation(left: "0")
        }

        let mantissaLength: Int
        mantissaLength = precision
        let (mantissa, exponent) = swiftGmp.mantissaExponent(len: mantissaLength)
        
        return fromMantissaAndExponent(mantissa, exponent, separators: self, showAs: self, forceScientific: false)
    }
    
    private func fromMantissaAndExponent(
        _ mantissa_: String,
        _ exponent: Int,
        separators: Separators,
        showAs: ShowAs,
        forceScientific: Bool) -> NumberRepresentation {

        //print("showAs", showAs.showAsInt, showAs.showAsFloat)
        var returnValue: NumberRepresentation = NumberRepresentation(left: "error")
        var mantissa = mantissa_
        
        if mantissa.isEmpty {
            mantissa = "0"
        }
        
        /// negative? Special treatment
        let isNegative = mantissa.first == "-"
        if isNegative {
            mantissa.removeFirst()
        }
        
        /// Can be displayed as Integer?
        /*
         123,456,789,012,345,678,901,123,456 --> 400 pixel
         What can be displayed in 200 pixel?
         - I dont want the separator as leading character!
         */
        if mantissa.count <= exponent + 1 && !forceScientific { /// smaller than because of possible trailing zeroes in the integer
            mantissa = mantissa.padding(toLength: exponent+1, withPad: "0", startingAt: 0)
            let withSeparators = withSeparators(numberString: mantissa, isNegative: isNegative, separators: separators)
            returnValue.left = withSeparators
            return returnValue
        }
        
        /// Is floating point XXX,xxx?
        if exponent >= 0 && !forceScientific {
            var floatString = mantissa
            let index = floatString.index(floatString.startIndex, offsetBy: exponent+1)
            //var indexInt: Int = floatString.distance(from: floatString.startIndex, to: index)
            floatString.insert(".", at: index)
            floatString = withSeparators(numberString: floatString, isNegative: isNegative, separators: separators)
            returnValue.left = floatString
            return returnValue
            /// is the comma visible in the first line and is there at least one digit after the comma?
        }
        
        /// is floating point 0,xxxx
        /// additional requirement: first non-zero digit in first line. If not -> Scientific
        if exponent < 0 && !forceScientific {
            let minusSign = isNegative ? "-" : ""
            
            var testFloat = minusSign + "0" + separators.decimalSeparator.string
            var floatString = mantissa
            for _ in 0..<(-1*exponent - 1) {
                floatString = "0" + floatString
                testFloat += "0"
            }
            testFloat += "x"
            floatString = minusSign + "0" + separators.decimalSeparator.string + floatString
            returnValue.left = floatString
            return returnValue
        }
        
        mantissa = mantissa_
        if isNegative {
            mantissa.removeFirst()
        }
        
        let secondIndex = mantissa.index(mantissa.startIndex, offsetBy: 1)
        mantissa.insert(".", at: secondIndex)
        if mantissa.count == 2 {
            // 4.
            mantissa.append("0")
        }
        mantissa = withSeparators(numberString: mantissa, isNegative: isNegative, separators: separators)
        let exponentString = "e\(exponent)"
        returnValue.left = mantissa
        returnValue.right = exponentString
        return returnValue
    }


}
//
//
//public extension String {
//    func position(of char: Character) -> Int? {
//        return firstIndex(of: char)?.utf16Offset(in: self)
//    }
//}
//
public extension Double {
    func similarTo(_ other: Double, precision: Double = 1e-3) -> Bool {
        abs(self - other) <= precision
    }
}
