//
//  Operator.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 23.09.24.
//


import Foundation

public struct OperatorQueue {
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
    }
}

