//
//  PendingTest.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 05.10.24.
//

import Testing
@testable import SwiftGmp

@Test func pendingTest() {
    let calculator = Calculator(precision: 40)
    calculator.press(.one)
    calculator.press(.sqr)
    calculator.press(.add)

    let pending = calculator.token.pendingOperators
    #expect(pending.count == 1)
}
