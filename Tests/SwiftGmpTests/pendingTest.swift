//
//  PendingTest.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 05.10.24.
//

import Testing
@testable import SwiftGmp

@Test func pendingTest() {
    var result: Bool
    let calculator = Calculator(precision: 40)
    calculator.press(.one)
    result = calculator.operate(.sqr)
    result = calculator.operate(.add)
    #expect(result)

    let pending = calculator.token.pendingOperators
    #expect(pending.count == 1)
}
