// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 20)
    
    // 1 + 3 * 2 = 7
    calculator.press(DigitOperation.one)
    calculator.press(TwoOperantOperation.add)
    calculator.press(DigitOperation.three)
    calculator.press(TwoOperantOperation.mul)
    calculator.press(DigitOperation.two)
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "7")

    // 4 * 3 + 2 = 6
    calculator.press(DigitOperation.four)
    calculator.press(TwoOperantOperation.mul)
    calculator.press(DigitOperation.three)
    calculator.press(TwoOperantOperation.add)
    calculator.press(DigitOperation.two)
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "14")

    // 4 * (3 + 2) = 20
    calculator.press(DigitOperation.four)
    calculator.press(TwoOperantOperation.mul)
    calculator.press(ParenthesisOperation.left)
    calculator.press(DigitOperation.three)
    calculator.press(TwoOperantOperation.add)
    calculator.press(DigitOperation.two)
    calculator.press(ParenthesisOperation.right)
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "14")

//    let result = calculator.evaluateString("4.0 sqr")
//    #expect(result.string == "16")
}
