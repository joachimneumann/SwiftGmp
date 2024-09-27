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
    public let description: String?
    public init(_ priority: Int, description: String) {
        self.priority = priority
        self.description = description
    }
    public static func == (lhs: Operator, rhs: Operator) -> Bool {
        return lhs.id == rhs.id
    }
}

public class InplaceOperator: Operator {
    public let operation: SwiftGmp.swiftGmpInplaceType
    public init(_ operation: @escaping SwiftGmp.swiftGmpInplaceType, _ priority: Int, description: String = "") {
        self.operation = operation
        super.init(priority, description: description)
    }
}

public class TwoOperandOperator: Operator {
    public let operation: SwiftGmp.swiftGmpTwoOperantsType
    public init(_ op: @escaping SwiftGmp.swiftGmpTwoOperantsType, _ priority: Int, description: String = "") {
        operation = op
        super.init(priority, description: description)
    }
}

