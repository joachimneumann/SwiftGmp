//
//  Number.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 23.09.24.
//


import Foundation

class Number: CustomDebugStringConvertible {
    private(set) var precision: Int = 0
    private var str: String?
    private var _swiftGmp: SwiftGmp?

    private var isStr: Bool { str != nil }
    private var isSwiftGmp: Bool { _swiftGmp != nil }

    var swiftGmp: SwiftGmp {
        if isStr {
            _swiftGmp = SwiftGmp(withString: str!, bits: generousBits(for: precision))
            str = nil
        }
        return _swiftGmp!
    }

    func setPrecision(_ newPrecision: Int) {
        precision = newPrecision
        swiftGmp.setBits(generousBits(for: precision))
    }
    
    init(_ str: String, precision: Int) {
        self.str = str
        self._swiftGmp = nil
        self.precision = precision
    }

    init(precision: Int) {
        str = "0"
        _swiftGmp = nil
        self.precision = precision
    }

    init(_ d: Double, precision: Int) {
        str = nil
        _swiftGmp = SwiftGmp(withString: String(d), bits: generousBits(for: precision))
    }
    private init(_ swiftGmp: SwiftGmp, precision: Int) {
        str = nil
        _swiftGmp = swiftGmp.copy()
        self.precision = precision
    }

    func generousBits(for precision: Int) -> Int {
        Int(Double(generousPrecision(for: precision)) * 3.32192809489)
    }

    func generousPrecision(for precision: Int) -> Int {
        return precision + 20
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

    func exactPrecision(for precision: Int) -> Int {
        return precision
    }

    func copy() -> Number {
        if isStr {
            return Number(str!, precision: precision)
        } else {
            return Number(swiftGmp.copy(), precision: precision)
        }
    }

    var R: Representation {
        let asGmp: SwiftGmp
        // reduce precision for rounding
        // this transforms last bit errors like 0.500000...001  and 0.49999...999 into 0.5
        if let str = str {
            asGmp = SwiftGmp(withString: str, bits: generousBits(for: precision))
        } else {
            asGmp = SwiftGmp(withSwiftGmp: swiftGmp, bits: generousBits(for: precision))
        }

        if asGmp.isNan {
            return Representation(error: "not a number")
        }
        if asGmp.isInf {
            if asGmp.isNegative() {
                return Representation(error: "-inf")
            } else {
                return Representation(error: "inf")
            }
        }

        if asGmp.isZero {
            return Representation(mantissa: "0", exponent: 0)
        }

        let mantissaLength: Int = precision // approximation: accept integers with length = precision
        let (mantissa, exponent) = asGmp.mantissaExponent(len: mantissaLength)
        return Representation(mantissa: mantissa, exponent: exponent)
    }

    var isNaN: Bool {
        get {
            if isStr { return false }
            return swiftGmp.isNan
        }
    }
    var isValid: Bool {
        get {
            if isStr { return true }
            return swiftGmp.isValid
        }
    }

    var isInfinity: Bool {
        get {
            if isStr { return str == "inf" || str == "-inf"}
            return swiftGmp.isInf
        }
    }
    
    var debugDescription: String {
        if let str {
            return "\(str) precision \(precision) string"
        }
        return "\(_swiftGmp!.toDouble())  precision \(precision) gmp"
    }

}
//
//
//extension String {
//    func position(of char: Character) -> Int? {
//        return firstIndex(of: char)?.utf16Offset(in: self)
//    }
//}
//
extension Double {
    public func similarTo(_ other: Double, precision: Double = 1e-3) -> Bool {
        if abs(self) > 1000 {
            return abs(self - other) <= precision * abs(self)
        } else {
            return abs(self - other) <= precision
        }
    }
}
