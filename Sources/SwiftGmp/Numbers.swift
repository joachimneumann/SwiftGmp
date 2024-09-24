//
//  Numbers.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 24.09.24.
//


public actor Numbers {
    private var precision: Int
    public init(precision: Int) {
        self.precision = precision
    }
    
    public func new(_ value: String) -> Number {
        return Number(value, precision: precision)
    }

    public var π: Number    { get async { let ret = new("0"); await ret.π();    return ret }}
    public var e: Number    { get async { let ret = new("0"); await ret.e();    return ret }}
    public var rand: Number { get async { let ret = new("0"); await ret.rand(); return ret }}

}
