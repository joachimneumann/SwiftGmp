//
//  Operator.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 23.09.24.
//


import Foundation

public class Operator: Equatable, Identifiable {
//    public static let openParenthesesPriority = -2
//    public static let closedParenthesesPriority = -1
//    public static let equalPriority = -3

    public let id = UUID()
    public let priority: Int
    public let description: String
    public init(_ priority: Int, description: String) {
        self.priority = priority
        self.description = description
    }
    public static func == (lhs: Operator, rhs: Operator) -> Bool {
        return lhs.id == rhs.id
    }
}

public typealias inplaceType = (Number) -> () -> ()
public typealias twoOperantsType = (Number) -> (Number) -> ()

public class InplaceOperator: Operator {
    public let operation: inplaceType
    public init(_ operation: @escaping inplaceType, _ priority: Int, description: String = "") {
        self.operation = operation
        super.init(priority, description: description)
    }
}

public class TwoOperandOperator: Operator {
    public let operation: twoOperantsType
    public init(_ op: @escaping twoOperantsType, _ priority: Int, description: String = "") {
        operation = op
        super.init(priority, description: description)
    }
}

public struct AvailableOperators: CustomDebugStringConvertible {
    private var inplaceOperators: [String: InplaceOperator] = [:]
    private var twoOperandOperators: [String: TwoOperandOperator] = [:]
    
    mutating func addInplaceOperator(_ key: String, op: InplaceOperator) {
        inplaceOperators[key] = op
    }
    mutating func addTwoOperandOperators(_ key: String, op: TwoOperandOperator) {
        twoOperandOperators[key] = op
    }
    
    func op(_ key: String) -> Operator? {
        if inplaceOperators[key] != nil {
            return inplaceOperators[key]
        }
        return nil
    }

    public var debugDescription: String {
        var ret = "inplace operators: "
        for (key, op) in inplaceOperators {
            ret += ("op: \(key) priority: \(op.priority) \(op.description)\n")
        }
        ret += "two operand operators: "
        for (key, op) in twoOperandOperators {
            ret += ("op: \(key) priority: \(op.priority) \(op.description)\n")
        }
        return ret
    }
}

public struct OperatorStack {
    private var availableOperators = AvailableOperators()
    private var queue: [Operator] = []
    
    public mutating func push(_ key: String) {
        if let op = availableOperators.op(key) {
            queue.append(op)
        }
    }
    public mutating func pop() -> Operator? {
        return queue.popLast()
    }
    
    public mutating func removeLast() {
        queue.removeLast()
    }
//    var hasOpenParentheses: Bool {
//        for op in array {
//             if op.priority == Operator.openParenthesesPriority { return true }
//         }
//         return false
//    }
    public var last: Operator? {
        queue.last
    }
    public var count: Int {
        queue.count
    }
    public var isEmpty: Bool { queue.count == 0 }
    public mutating func removeAll() {
        queue.removeAll()
    }
    public init() {
        self.queue = []
        availableOperators.addInplaceOperator("zero",       op: InplaceOperator(Number.inplace_zero, 1))
        availableOperators.addInplaceOperator("pi",         op: InplaceOperator(Number.inplace_π, 1))
        availableOperators.addInplaceOperator("e",          op: InplaceOperator(Number.inplace_e, 1))
        availableOperators.addInplaceOperator("rand",       op: InplaceOperator(Number.inplace_rand, 1))
        availableOperators.addInplaceOperator("abs",        op: InplaceOperator(Number.inplace_abs, 1))
        availableOperators.addInplaceOperator("sqrt",       op: InplaceOperator(Number.inplace_sqrt, 1))
        availableOperators.addInplaceOperator("sqrt3",      op: InplaceOperator(Number.inplace_sqrt3, 1))
        availableOperators.addInplaceOperator("zeta",       op: InplaceOperator(Number.inplace_Z, 1))
        availableOperators.addInplaceOperator("ln",         op: InplaceOperator(Number.inplace_ln, 1))
        availableOperators.addInplaceOperator("log10",      op: InplaceOperator(Number.inplace_log10, 1))
        availableOperators.addInplaceOperator("log2",       op: InplaceOperator(Number.inplace_log2, 1))
        availableOperators.addInplaceOperator("sin",        op: InplaceOperator(Number.inplace_sin, 1))
        availableOperators.addInplaceOperator("cos",        op: InplaceOperator(Number.inplace_cos, 1))
        availableOperators.addInplaceOperator("tan",        op: InplaceOperator(Number.inplace_tan, 1))
        availableOperators.addInplaceOperator("asin",       op: InplaceOperator(Number.inplace_asin, 1))
        availableOperators.addInplaceOperator("acos",       op: InplaceOperator(Number.inplace_acos, 1))
        availableOperators.addInplaceOperator("atan",       op: InplaceOperator(Number.inplace_atan, 1))
        availableOperators.addInplaceOperator("sinh",       op: InplaceOperator(Number.inplace_sinh, 1))
        availableOperators.addInplaceOperator("cosh",       op: InplaceOperator(Number.inplace_cosh, 1))
        availableOperators.addInplaceOperator("tanh",       op: InplaceOperator(Number.inplace_tanh, 1))
        availableOperators.addInplaceOperator("asinh",      op: InplaceOperator(Number.inplace_asinh, 1))
        availableOperators.addInplaceOperator("acosh",      op: InplaceOperator(Number.inplace_acosh, 1))
        availableOperators.addInplaceOperator("atanh",      op: InplaceOperator(Number.inplace_atanh, 1))
        availableOperators.addInplaceOperator("pow_x_2",    op: InplaceOperator(Number.inplace_pow_x_2, 1))
        availableOperators.addInplaceOperator("pow_e_x",    op: InplaceOperator(Number.inplace_pow_e_x, 1))
        availableOperators.addInplaceOperator("pow_10_x",   op: InplaceOperator(Number.inplace_pow_10_x, 1))
        availableOperators.addInplaceOperator("changeSign", op: InplaceOperator(Number.inplace_changeSign, 1))
        availableOperators.addInplaceOperator("pow_x_3",    op: InplaceOperator(Number.inplace_pow_x_3, 1))
        availableOperators.addInplaceOperator("pow_2_x",    op: InplaceOperator(Number.inplace_pow_2_x, 1))
        availableOperators.addInplaceOperator("rez",        op: InplaceOperator(Number.inplace_rez, 1))
        availableOperators.addInplaceOperator("fac",        op: InplaceOperator(Number.inplace_fac, 1))
        availableOperators.addInplaceOperator("sinD",       op: InplaceOperator(Number.inplace_sinD, 1))
        availableOperators.addInplaceOperator("cosD",       op: InplaceOperator(Number.inplace_cosD, 1))
        availableOperators.addInplaceOperator("tanD",       op: InplaceOperator(Number.inplace_tanD, 1))
        availableOperators.addInplaceOperator("asinD",      op: InplaceOperator(Number.inplace_asinD, 1))
        availableOperators.addInplaceOperator("acosD",      op: InplaceOperator(Number.inplace_acosD, 1))
        availableOperators.addInplaceOperator("atand",      op: InplaceOperator(Number.inplace_atanD, 1))
    }
}

