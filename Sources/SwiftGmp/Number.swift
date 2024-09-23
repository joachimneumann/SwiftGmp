//
//  Number.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 23.09.24.
//


import Foundation

@MainActor
public class Number: @preconcurrency CustomDebugStringConvertible, @preconcurrency Equatable {
    public private(set) var precision: Int = 0
    private var _str: String?
    private var _swiftGmp: SwiftGmp?
    
    public var isStr: Bool { _str != nil }
    public var isSwiftGmp: Bool { _swiftGmp != nil }
    public var str: String? { return _str }
    public var swiftGmp: SwiftGmp? { return _swiftGmp }
    
    public static func ==(lhs: Number, rhs: Number) -> Bool {
        if lhs.isStr && rhs.isStr { return lhs.str! == rhs.str! }
        if lhs.isSwiftGmp && rhs.isSwiftGmp { return lhs.swiftGmp! == rhs.swiftGmp! }
        /// mixed str and SwiftGmp

        if lhs.precision != rhs.precision { return false }

        let lSwiftGmp: SwiftGmp
        let rSwiftGmp: SwiftGmp
        if lhs.isSwiftGmp {
            lSwiftGmp = lhs.swiftGmp!
        } else {
            lSwiftGmp = SwiftGmp(withString: lhs.str!, precision: lhs.precision)
        }
        if rhs.isSwiftGmp {
            rSwiftGmp = rhs.swiftGmp!
        } else {
            rSwiftGmp = SwiftGmp(withString: rhs.str!, precision: lhs.precision)
        }
        return lSwiftGmp == rSwiftGmp
    }
    
    public static func !=(lhs: Number, rhs: Number) -> Bool {
        return !(lhs == rhs)
    }
    
    public var isValid: Bool {
        if isStr { return true }
        return _swiftGmp!.isValid
    }
    public func copy() -> Number {
        if isStr {
            return Number(str!, precision: precision)
        } else {
            return Number(swiftGmp!.copy())
        }
    }
    public func toSwiftGmp() {
        if isStr {
            _swiftGmp = SwiftGmp(withString: str!, precision: precision)
            _str = nil
        }
    }
    public func execute(_ op: twoOperantsType, with other: Number) {
        toSwiftGmp()
        other.toSwiftGmp()
        _swiftGmp!.execute(op, with: other._swiftGmp!)
    }
    public func execute(_ op: inplaceType) {
        toSwiftGmp()
        _swiftGmp!.inPlace(op: op)
    }
    
    public init(_ str: String, precision: Int) {
        _str = str
        _swiftGmp = nil
        self.precision = precision
    }
    public init(_ gmp: SwiftGmp) {
        //print("Number init()")
        _str = nil
        _swiftGmp = gmp.copy()
        self.precision = gmp.precision
    }
    fileprivate init() {
        //print("Number init()")
        _str = nil
        _swiftGmp = nil
        precision = 0
    }
    
    public func setValue(other number: Number) {
        if number.isStr {
            _str = number.str
            _swiftGmp = nil
        } else {
            toSwiftGmp()
            _swiftGmp!.setValue(other: number._swiftGmp!)
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
        if str == nil {
            _str = "0."
        } else {
            if !_str!.contains(".") { _str!.append(".") }
        }
    }
    public var isNegative: Bool {
        if isStr {
            return _str!.starts(with: "-")
        } else {
            return _swiftGmp!.isNegtive()
        }
    }
    public func changeSign() {
        if isStr {
            if _str == "0" { return }
            if _str!.starts(with: "-") {
                _str!.removeFirst()
            } else {
                _str! = "-" + _str!
            }
        } else {
            _swiftGmp!.changeSign()
        }
    }
    
    public var debugDescription: String {
        if isStr {
            return "\(_str!) precision \(precision) string"
        } else {
            return "\(_swiftGmp!.toDouble())  precision \(precision) gmp "
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

