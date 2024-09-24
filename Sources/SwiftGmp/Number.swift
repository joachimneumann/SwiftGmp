//
//  Number.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 23.09.24.
//


import Foundation

public func rez(_ n: Number) async -> Number { let ret = await n.copy(); await ret.inplace_rez(); return ret }

public actor Number: @preconcurrency CustomDebugStringConvertible  {
    public var debugDescription: String {
        if let _str {
            return "\(_str) precision \(precision) string"
        }
        return "\(_swiftGmp!.toDouble())  precision \(precision) gmp"
    }

    
    public private(set) var precision: Int = 0
    
    init(_ str: String, precision: Int) {
        _str = str
        _swiftGmp = nil
        self.precision = precision
    }

    private init(precision: Int) {
        _str = "0"
        _swiftGmp = nil
        self.precision = precision
    }

    private init(_ gmp: SwiftGmp) {
        //print("Number init()")
        _str = nil
        _swiftGmp = gmp.copy()
        self.precision = gmp.precision
    }

    private init(_ d: Double, precision: Int) {
        _str = nil
        _swiftGmp = SwiftGmp(withString: String(d), precision: precision)
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

    
    public static func ==(lhs: Number, rhs: Number) async -> Bool {
        if await lhs.precision != rhs.precision { return false }

        let selfIsStr = await lhs.isStr
        let otherIsStr = await rhs.isStr
        if selfIsStr && otherIsStr {
            return await lhs.str == rhs.str
        }

        let l = lhs
        let r = rhs
        return await l.swiftGmp == r.swiftGmp
    }
    public static func !=(lhs: Number, rhs: Number) async -> Bool {
        return await !(lhs == rhs)
    }
    public static func +(lhs: Number, rhs: Number) async -> Number {
        return await Number(lhs.swiftGmp + rhs.swiftGmp)
    }
    public static func +(lhs: Double, rhs: Number) async -> Number {
        let l = await Number(lhs, precision: rhs.precision)
        return await Number(l.swiftGmp + rhs.swiftGmp)
    }
    public static func +(lhs: Number, rhs: Double) async -> Number {
        let r = await Number(rhs, precision: lhs.precision)
        return await Number(lhs.swiftGmp + r.swiftGmp)
    }

    public static func -(lhs: Number, rhs: Number) async -> Number {
        return await Number(lhs.swiftGmp - rhs.swiftGmp)
    }
    public static func -(lhs: Double, rhs: Number) async -> Number {
        let l = await Number(lhs, precision: rhs.precision)
        return await Number(l.swiftGmp - rhs.swiftGmp)
    }
    public static func -(lhs: Number, rhs: Double) async -> Number {
        let r = await Number(rhs, precision: lhs.precision)
        return await Number(lhs.swiftGmp - r.swiftGmp)
    }

    public static func *(lhs: Number, rhs: Number) async -> Number {
        return await Number(lhs.swiftGmp * rhs.swiftGmp)
    }
    public static func *(lhs: Double, rhs: Number) async -> Number {
        let l = await Number(lhs, precision: rhs.precision)
        return await Number(l.swiftGmp * rhs.swiftGmp)
    }
    public static func *(lhs: Number, rhs: Double) async -> Number {
        let r = await Number(rhs, precision: lhs.precision)
        return await Number(lhs.swiftGmp * r.swiftGmp)
    }

    public static func /(lhs: Number, rhs: Number) async -> Number {
        return await Number(lhs.swiftGmp / rhs.swiftGmp)
    }
    public static func /(lhs: Double, rhs: Number) async -> Number {
        let l = await Number(lhs, precision: rhs.precision)
        return await Number(l.swiftGmp / rhs.swiftGmp)
    }
    public static func /(lhs: Number, rhs: Double) async -> Number {
        let r = await Number(rhs, precision: lhs.precision)
        return await Number(lhs.swiftGmp / r.swiftGmp)
    }

    public var isValid: Bool {
        get async {
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

    public func isApproximately(_ other: Double, precision: Double = 1e-3) -> Bool {
        return abs(self.swiftGmp.toDouble() - other) <= precision
    }

    //
    // constants
    // public implementation in numbers.swift
    //
    func π() async    { swiftGmp.π() }
    func e() async    { swiftGmp.e() }
    func rand() async { swiftGmp.rand() }

    //
    // inplace
    //
    public func inplace_abs() async { swiftGmp.abs() }
    public func inplace_sqrt() async { swiftGmp.sqrt() }
    public func inplace_sqrt3() async { swiftGmp.sqrt3() }
    public func inplace_Z() async { swiftGmp.Z() }
    public func inplace_ln() async { swiftGmp.ln() }
    public func inplace_log10() async { swiftGmp.log10() }
    public func inplace_log2() async { swiftGmp.log2() }
    public func inplace_sin() async { swiftGmp.sin() }
    public func inplace_cos() async { swiftGmp.cos() }
    public func inplace_tan() async { swiftGmp.tan() }
    public func inplace_asin() async { swiftGmp.asin() }
    public func inplace_acos() async { swiftGmp.acos() }
    public func inplace_atan() async { swiftGmp.atan() }
    public func inplace_sinh() async { swiftGmp.sinh() }
    public func inplace_cosh() async { swiftGmp.cosh() }
    public func inplace_tanh() async { swiftGmp.tanh() }
    public func inplace_asinh() async { swiftGmp.asinh() }
    public func inplace_acosh() async { swiftGmp.acosh() }
    public func inplace_atanh() async { swiftGmp.atanh() }
    public func inplace_pow_x_2() async { swiftGmp.pow_x_2() }
    public func inplace_pow_e_x() async { swiftGmp.pow_e_x() }
    public func inplace_pow_10_x() async { swiftGmp.pow_10_x() }
    public func inplace_changeSign() async { swiftGmp.changeSign() }
    public func inplace_pow_x_3() async { swiftGmp.pow_x_3() }
    public func inplace_pow_2_x() async { swiftGmp.pow_2_x() }
    public func inplace_rez() async { swiftGmp.rez() }
    public func inplace_fac() async { swiftGmp.fac() }
    public func inplace_sinD() async { swiftGmp.sinD() }
    public func inplace_cosD() async { swiftGmp.cosD() }
    public func inplace_tanD() async { swiftGmp.tanD() }
    public func inplace_asinD() async { swiftGmp.asinD() }
    public func inplace_acosD() async { swiftGmp.acosD() }
    public func inplace_atanD() async { swiftGmp.atanD() }
    
    //
    // twoOperant
    //
    public func pow_x_y(exponent: Number) async { await swiftGmp.pow_x_y(exponent: exponent.swiftGmp) }
    public func pow_y_x(base: Number)     async { await swiftGmp.pow_y_x(base: base.swiftGmp) }
    public func sqrty(exponent: Number)   async { await swiftGmp.sqrty(exponent: exponent.swiftGmp) }
    public func logy(base: Number)        async { await swiftGmp.logy(base: base.swiftGmp) }
    public func EE(other: Number)         async { await swiftGmp.EE(other: other.swiftGmp) }
    
    public func setValue(other number: Number) async {
        if await number.isStr {
            _str = await number.str
            _swiftGmp = nil
        } else {
            await swiftGmp.setValue(other: number.swiftGmp)
        }
    }
    
    public func append(_ digit: String) async {
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
        if var _str {
            if !_str.contains(".") { _str.append(".") }
        } else {
            _str = "0."
        }
    }
    public var isNegative: Bool {
        get async {
            if let _str {
                return _str.starts(with: "-")
            } else {
                return swiftGmp.isNegative()
            }
        }
    }
    public func changeSign() {
        if var _str {
            if _str == "0" { return }
            if _str.starts(with: "-") {
                _str.removeFirst()
            } else {
                _str = "-" + _str
            }
        } else {
            swiftGmp.changeSign()
        }
    }
        
    static func internalPrecision(for precision: Int) -> Int {
        // return precision
        if precision <= 500 {
            return 1000
        } else if precision <= 10000 {
            return 2 * precision
        } else if precision <= 100000 {
            return Int(round(1.5*Double(precision)))
        } else {
            return precision + 50000
        }
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

