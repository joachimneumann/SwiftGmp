//
//  Numbers.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 24.09.24.
//


public actor Numbers: @preconcurrency CustomDebugStringConvertible {
    enum Constants {
        case π
        case e
        case rand
        case zero
    }
    private var precision: Int
    public init(precision: Int) {
        self.precision = precision
        array.append(Number("0", precision: precision))
    }
    
    private var array: [Number] = []
    
    func setPrecision(to newPrecision: Int) async {
        precision = newPrecision
        for number in array {
            await number.setPrecision(precision)
        }
    }
    
    func replaceLast(with number: Number) {
        removeLast()
        push(number)
    }
    
    func pushZero() {
        array.append(zero)
    }
    func push(constant: Constants) async {
        switch constant {
            case .π:
            array.append(await π)
        case .e:
            array.append(await e)
        case .rand:
            array.append(await rand)
        case .zero:
            pushZero()
        }
    }
    public func push(_ number: String) {
        array.append(new(number))
    }
    private func push(_ number: Number) {
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

    
    private func new(_ value: String) -> Number {
        Number(value, precision: precision)
    }

    private var π: Number    { get async { let ret = new("0"); await ret.π();    return ret }}
    private var e: Number    { get async { let ret = new("0"); await ret.e();    return ret }}
    private var rand: Number { get async { let ret = new("0"); await ret.rand(); return ret }}
    private var zero: Number { new("0") }
}
