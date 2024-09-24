//
//  Numbers.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 24.09.24.
//


public struct Numbers {
    private var precision: Int
    public init(precision: Int) {
        self.precision = precision
    }
    
    public func new(_ value: String) -> Number {
        return Number(value, precision: precision)
    }

    public var π: Number    { let ret = new("0"); ret.π();    return ret }
    public var e: Number    { let ret = new("0"); ret.e();    return ret }
    public var rand: Number { let ret = new("0"); ret.rand(); return ret }

}
