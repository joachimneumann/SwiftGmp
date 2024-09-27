//
//  NumberStack.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 24.09.24.
//

public class NumberStack: CustomDebugStringConvertible {
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
    
    func setPrecision(to newPrecision: Int) {
        precision = newPrecision
        for number in array {
            number.setPrecision(precision)
        }
    }
    
    func replaceLast(with number: Number) {
        removeLast()
        push(number)
    }
    
//    func pushZero() {
//        array.append(zero)
//    }
//    func push(constant: Constants) async {
//        switch constant {
//            case .π:
//            array.append(π)
//        case .e:
//            array.append(e)
//        case .rand:
//            array.append(rand)
//        case .zero:
//            pushZero()
//        }
//    }
    public func push(_ number: String) {
        array.append(new(number))
    }
//    public func push(_ o: InplaceOperator) {
//        operatorStack.push(o)
//    }
    private func push(_ number: Number) {
        array.append(number)
    }
    func popLast() -> Number? {
        return array.popLast()
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
        var ret = "numberStack \(array.count): \n"
        for number in array {
            ret += "    \(number) \n"
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

    
    func new(_ value: String) -> Number {
        Number(value, precision: precision)
    }

    func mul() {
        if let last = popLast() {
            if let secondLast = popLast() {
                push(last * secondLast)
            }
        }
    }
    func add() {
        if let last = popLast() {
            if let secondLast = popLast() {
                push(last + secondLast)
            }
        }
    }
    func sub() {
        if let last = popLast() {
            if let secondLast = popLast() {
                push(last - secondLast)
            }
        }
    }
    func div() {
        if let last = popLast() {
            if let secondLast = popLast() {
                push(last / secondLast)
            }
        }
    }
}
