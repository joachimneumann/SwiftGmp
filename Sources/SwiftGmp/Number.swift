//
//  Number.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 23.09.24.
//


import Foundation

public func rez(_ n: Number) -> Number { let ret = n.copy(); ret.inplace_rez(); return ret }

public class Number: CustomDebugStringConvertible  {
    public var debugDescription: String {
        if let _str {
            return "\(_str) precision \(precision) string"
        }
        return "\(_swiftGmp!.toDouble())  precision \(precision) gmp"
    }

    
    public private(set) var precision: Int = 0
    
    func setPrecision(_ newPrecision: Int) {
        precision = newPrecision
        swiftGmp.setPrecision(precision)
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
        _swiftGmp = SwiftGmp(withString: String(d), precision: precision)
    }
    private init(_ gmp: SwiftGmp) {
        //print("Number init()")
        _str = nil
        _swiftGmp = gmp.copy()
        self.precision = gmp.precision
    }


    private var _str: String?
    private var _swiftGmp: SwiftGmp?
    
    private var isStr: Bool { _str != nil }
    private var isSwiftGmp: Bool { _swiftGmp != nil }
    private var str: String? { return _str }
    private var swiftGmp: SwiftGmp {
        if isStr {
            _swiftGmp = SwiftGmp(withString: str!, precision: precision)
            _str = nil
        }
        return _swiftGmp!
    }
    public func toDouble() -> Double {
        if isStr {
            return Double(str!)!
        }
        return swiftGmp.toDouble()
    }
    
    public static func ==(lhs: Number, rhs: Number) -> Bool {
        if lhs.precision != rhs.precision { return false }

        let selfIsStr = lhs.isStr
        let otherIsStr = rhs.isStr
        if selfIsStr && otherIsStr {
            return lhs.str == rhs.str
        }

        let l = lhs
        let r = rhs
        return l.swiftGmp == r.swiftGmp
    }
    public static func !=(lhs: Number, rhs: Number) -> Bool {
        return !(lhs == rhs)
    }
    public static func +(lhs: Number, rhs: Number) -> Number {
        return Number(lhs.swiftGmp + rhs.swiftGmp)
    }
    public static func +(lhs: Double, rhs: Number) -> Number {
        let l = Number(lhs, precision: rhs.precision)
        return Number(l.swiftGmp + rhs.swiftGmp)
    }
    public static func +(lhs: Number, rhs: Double) -> Number {
        let r = Number(rhs, precision: lhs.precision)
        return Number(lhs.swiftGmp + r.swiftGmp)
    }

    public static func -(lhs: Number, rhs: Number) -> Number {
        return Number(lhs.swiftGmp - rhs.swiftGmp)
    }
    public static func -(lhs: Double, rhs: Number) -> Number {
        let l = Number(lhs, precision: rhs.precision)
        return Number(l.swiftGmp - rhs.swiftGmp)
    }
    public static func -(lhs: Number, rhs: Double) -> Number {
        let r = Number(rhs, precision: lhs.precision)
        return Number(lhs.swiftGmp - r.swiftGmp)
    }

    public static func *(lhs: Number, rhs: Number) -> Number {
        return Number(lhs.swiftGmp * rhs.swiftGmp)
    }
    public static func *(lhs: Double, rhs: Number) -> Number {
        let l = Number(lhs, precision: rhs.precision)
        return Number(l.swiftGmp * rhs.swiftGmp)
    }
    public static func *(lhs: Number, rhs: Double) -> Number {
        let r = Number(rhs, precision: lhs.precision)
        return Number(lhs.swiftGmp * r.swiftGmp)
    }

    public static func /(lhs: Number, rhs: Number) -> Number {
        return Number(lhs.swiftGmp / rhs.swiftGmp)
    }
    public static func /(lhs: Double, rhs: Number) -> Number {
        let l = Number(lhs, precision: rhs.precision)
        return Number(l.swiftGmp / rhs.swiftGmp)
    }
    public static func /(lhs: Number, rhs: Double) -> Number {
        let r = Number(rhs, precision: lhs.precision)
        return Number(lhs.swiftGmp / r.swiftGmp)
    }

    public var isValid: Bool {
        get {
            if isStr { return true }
            return swiftGmp.isValid
        }
    }
    fileprivate func copy() -> Number {
        if isStr {
            return Number(str!, precision: precision)
        } else {
            return Number(swiftGmp.copy())
        }
    }

    public func similarTo(_ other: Double, precision: Double = 1e-3) -> Bool {
        abs(self.copy().toDouble() - other) <= precision
    }
    public func similarTo(_ other: Number, precision: Double = 1e-3) -> Bool {
        abs(self.copy().toDouble() - other.toDouble()) <= precision
    }


    //
    // inplace
    //
    public func inplace_zero() { swiftGmp.zero() }
    public func inplace_π()    { swiftGmp.π() }
    public func inplace_e()    { swiftGmp.e() }
    public func inplace_rand() { swiftGmp.rand() }

    public func inplace_abs() { swiftGmp.abs() }
    public func inplace_sqrt() { swiftGmp.sqrt() }
    public func inplace_sqrt3() { swiftGmp.sqrt3() }
    public func inplace_Z() { swiftGmp.Z() }
    public func inplace_ln() { swiftGmp.ln() }
    public func inplace_log10() { swiftGmp.log10() }
    public func inplace_log2() { swiftGmp.log2() }
    public func inplace_sin() { swiftGmp.sin() }
    public func inplace_cos() { swiftGmp.cos() }
    public func inplace_tan() { swiftGmp.tan() }
    public func inplace_asin() { swiftGmp.asin() }
    public func inplace_acos() { swiftGmp.acos() }
    public func inplace_atan() { swiftGmp.atan() }
    public func inplace_sinh() { swiftGmp.sinh() }
    public func inplace_cosh() { swiftGmp.cosh() }
    public func inplace_tanh() { swiftGmp.tanh() }
    public func inplace_asinh() { swiftGmp.asinh() }
    public func inplace_acosh() { swiftGmp.acosh() }
    public func inplace_atanh() { swiftGmp.atanh() }
    public func inplace_pow_x_2() { swiftGmp.pow_x_2() }
    public func inplace_pow_e_x() { swiftGmp.pow_e_x() }
    public func inplace_pow_10_x() { swiftGmp.pow_10_x() }
    public func inplace_changeSign() { swiftGmp.changeSign() }
    public func inplace_pow_x_3() { swiftGmp.pow_x_3() }
    public func inplace_pow_2_x() { swiftGmp.pow_2_x() }
    public func inplace_rez() { swiftGmp.rez() }
    public func inplace_fac() { swiftGmp.fac() }
    public func inplace_sinD() { swiftGmp.sinD() }
    public func inplace_cosD() { swiftGmp.cosD() }
    public func inplace_tanD() { swiftGmp.tanD() }
    public func inplace_asinD() { swiftGmp.asinD() }
    public func inplace_acosD() { swiftGmp.acosD() }
    public func inplace_atanD() { swiftGmp.atanD() }
    
    //
    // twoOperant
    //
    public func pow_x_y(exponent: Number) { swiftGmp.pow_x_y(exponent: exponent.swiftGmp) }
    public func pow_y_x(base: Number)     { swiftGmp.pow_y_x(base: base.swiftGmp) }
    public func sqrty(exponent: Number)   { swiftGmp.sqrty(exponent: exponent.swiftGmp) }
    public func logy(base: Number)        { swiftGmp.logy(base: base.swiftGmp) }
    public func EE(other: Number)         { swiftGmp.EE(other: other.swiftGmp) }
    
    public func setValue(other number: Number) {
        if number.isStr {
            _str = number.str
            _swiftGmp = nil
        } else {
            swiftGmp.setValue(other: number.swiftGmp)
        }
    }
    
    public func append(_ digit: String) {
        if !isStr {
            _str = digit
            _swiftGmp = nil
        } else if _str == "0" {
            _str = digit
        } else {
            _str!.append(digit)
        }
    }
    
    public func appendDot() {
        if _str == nil {
            _str = "0."
            _swiftGmp = nil
        } else {
            if !_str!.contains(".") { _str!.append(".") }
        }
    }
    public var isNegative: Bool {
        get {
            if let _str {
                return _str.starts(with: "-")
            } else {
                return swiftGmp.isNegative()
            }
        }
    }
    public func changeSign() {
        if _str == nil {
            swiftGmp.changeSign()
        } else {
            if _str! == "0" { return }
            if _str!.starts(with: "-") {
                _str!.removeFirst()
            } else {
                _str! = "-" + _str!
            }
        }
    }
        
    static func internalPrecision(for precision: Int) -> Int {
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
    
    static func bits(for precision: Int) -> Int {
        Int(Double(internalPrecision(for: precision)) * 3.32192809489)
    }
}


public extension String {
    func position(of char: Character) -> Int? {
        return firstIndex(of: char)?.utf16Offset(in: self)
    }
}

public extension Double {
    func similarTo(_ other: Double, precision: Double = 1e-3) -> Bool {
        abs(self - other) <= precision
    }
}
