//
//  Numbers.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 24.09.24.
//


public actor Numbers: @preconcurrency CustomDebugStringConvertible {
    private var precision: Int
    public init(precision: Int) {
        self.precision = precision
        array.append(Number("0", precision: precision))
    }
    
    private var array: [Number] = []
    
    public func new(_ value: String) -> Number {
        Number(value, precision: precision)
    }

    public var π: Number    { get async { let ret = new("0"); await ret.π();    return ret }}
    public var e: Number    { get async { let ret = new("0"); await ret.e();    return ret }}
    public var rand: Number { get async { let ret = new("0"); await ret.rand(); return ret }}
    public var zero: Number { new("0") }
    
    func setPrecision(to newPrecision: Int) async {
        precision = newPrecision
        for number in array {
            await number.setPrecision(precision)
        }
    }
    
    func replaceLast(with number: Number) {
        removeLast()
        append(number)
    }
    func append(_ number: Number) {
        array.append(number)
    }
    func popLast() -> Number {
        assert(array.count > 0)
        return array.popLast()!
    }
    func removeLast() {
        assert(array.count > 0)
        array.removeLast()
    }
    func removeAll() {
        array.removeAll()
    }
    var secondLast: Number? {
        if count >= 2 {
            return array[array.count - 2]
        } else {
            return nil
        }
    }
    
    public var debugDescription: String {
        var ret = "numberStack \(array.count): "
        for number in array {
            ret += "\(number) "
        }
        return ret
    }
    
    public var count: Int {
        ///print("array.count \(array.count)")
        assert(array.count > 0)
        return array.count
    }
    public var last: Number {
        assert(array.count > 0)
        return array.last!
    }

}
