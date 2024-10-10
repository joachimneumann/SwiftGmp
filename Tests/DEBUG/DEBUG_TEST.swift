// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 20)
    
    calculator.press(DigitOperation.one)
    calculator.press(TwoOperantOperation.add)
    calculator.press(DigitOperation.three)
    calculator.press(TwoOperantOperation.mul)
    calculator.press(DigitOperation.two)
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "7")

//    let result = calculator.evaluateString("4.0 sqr")
//    #expect(result.string == "16")
}
