//
//  Operator.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 23.09.24.
//


import Foundation

public class Operator: Equatable, Identifiable {
    public let id = UUID()
    public let priority: Int
    public static let openParenthesesPriority = -2
    public static let closedParenthesesPriority = -1
    public static let equalPriority = -3
    public init(_ priority: Int) {
        //print("Operator init()")
        self.priority = priority
    }
    public static func == (lhs: Operator, rhs: Operator) -> Bool {
        return lhs.id == rhs.id
    }
}



public typealias inplaceType = (Number) -> () -> ()
public typealias twoOperantsType = (Number) -> (Number) -> ()

public class Inplace: Operator {
    public let operation: inplaceType
    public init(_ op: @escaping inplaceType, _ priority: Int) {
        operation = op
        super.init(priority)
    }
}

public class TwoOperand: Operator {
    public let operation: twoOperantsType
    public init(_ op: @escaping twoOperantsType, _ priority: Int) {
        operation = op
        super.init(priority)
    }
}

public struct OperatorStack: CustomDebugStringConvertible {
    private var array: [Operator] = []
    public mutating func push(_ element: Operator) {
        array.append(element)
    }
    public mutating func pop() -> Operator? {
        return array.popLast()
    }
    
    public mutating func removeLast() {
        array.removeLast()
    }
    var hasOpenParentheses: Bool {
        for op in array {
             if op.priority == Operator.openParenthesesPriority { return true }
         }
         return false
    }
    public var last: Operator? {
        array.last
    }
    public var count: Int {
        array.count
    }
    public var isEmpty: Bool { array.count == 0 }
    public mutating func removeAll() {
        array.removeAll()
    }
    public var debugDescription: String {
        let ret = "operatorStack: "
//        for toBePrinted in array {
//            for op in operators {
//                if op.value == toBePrinted {
//                    ret += ("op: \(op.key) priority: \(op.value.priority)\n")
//                }
//            }
//         }
        return ret
    }
    
    public init(array: [Operator]) {
        self.array = array
    }
    public init() {
        self.array = []
    }
}

//    enum InplaceOperator {
//        case abs
//        case sqrt
//        case sqrt3
//        case Z
//        case ln
//        case log10
//        case log2
//        case sin
//        case cos
//        case tan
//        case asin
//        case acos
//        case atan
//        case sinh
//        case cosh
//        case tanh
//        case asinh
//        case acosh
//        case atanh
//        case pow_x_2
//        case pow_e_x
//        case pow_10_x
//        case changeSign
//        case pow_x_3
//        case pow_2_x
//        case rez
//        case fac
//    }

//    func inplace(_ inplaceOperator: InplaceType) {
//        switch inplaceOperator {
//        case .abs:
//            last.inplace_abs()
//        case .sqrt:
//            last.inplace_sqrt()
//        case .sqrt3:
//            last.inplace_sqrt()
//        case .Z:
//            last.inplace_sqrt()
//        case .ln:
//            last.inplace_sqrt()
//        case .log10:
//            last.inplace_sqrt()
//        case .log2:
//            last.inplace_sqrt()
//        case .sin:
//            last.inplace_sqrt()
//        case .cos:
//            last.inplace_sqrt()
//        case .tan:
//            last.inplace_sqrt()
//        case .asin:
//            last.inplace_sqrt()
//        case .acos:
//            last.inplace_sqrt()
//        case .atan:
//            last.inplace_sqrt()
//        case .sinh:
//            last.inplace_sqrt()
//        case .cosh:
//            last.inplace_sqrt()
//        case .tanh:
//            last.inplace_sqrt()
//        case .asinh:
//            last.inplace_sqrt()
//        case .acosh:
//            last.inplace_sqrt()
//        case .atanh:
//            last.inplace_sqrt()
//        case .pow_x_2:
//            last.inplace_sqrt()
//        case .pow_e_x:
//            last.inplace_sqrt()
//        case .pow_10_x:
//            last.inplace_sqrt()
//        case .changeSign:
//            last.inplace_sqrt()
//        case .pow_x_3:
//            last.inplace_sqrt()
//        case .pow_2_x:
//            last.inplace_sqrt()
//        case .rez:
//            last.inplace_sqrt()
//        case .fac:
//            last.inplace_sqrt()
//        }
//    }

//private var π: Number    { let ret = new("0"); ret.inplace_π();    return ret }
//private var e: Number    { let ret = new("0"); ret.inplace_e();    return ret }
//private var rand: Number { let ret = new("0"); ret.inplace_rand(); return ret }
//private var zero: Number { new("0") }
