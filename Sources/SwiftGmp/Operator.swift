//
//  Operator.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 23.09.24.
//


import Foundation

@MainActor
public class Operator: @preconcurrency Equatable, Identifiable {
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



public typealias inplaceType = (SwiftGmp) -> () -> ()
public typealias twoOperantsType = (SwiftGmp) -> (SwiftGmp) -> ()

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

