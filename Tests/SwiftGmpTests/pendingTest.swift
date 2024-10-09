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
    calculator.press(DigitOperation.one)
    calculator.press(InplaceOperation.sqr)
    calculator.press(TwoOperantOperation.add)

    let pending = calculator.token.pendingOperators
    #expect(pending.count == 1)
    
    calculator.press(DigitOperation.one)
    calculator.press(TwoOperantOperation.div)
    calculator.press(DigitOperation.zero)
    calculator.press(EqualOperation.equal)
    #expect(calculator.token.lastSwiftGmp!.isValid == false)
    #expect(calculator.lr.string == "inf")
    let invalid = calculator.invalidOperators
    #expect(invalid.count > 1)
    calculator.press(ClearOperation.clear)

    calculator.press(DigitOperation.one)
    calculator.press(InplaceOperation.sqr)
    calculator.press(TwoOperantOperation.add)
    let pending = calculator.pendingOperators
    #expect(pending.count == 1)
    calculator.press(ClearOperation.clear)

    calculator.press(TwoOperantOperation.mul)
    calculator.press(TwoOperantOperation.sub)
    calculator.press(TwoOperantOperation.add)
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "0")
}
