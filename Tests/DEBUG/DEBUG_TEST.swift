// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 20)
    
    // 4 * 3 + 2 = 6
    calculator.press(DigitOperation.four)
    #expect(calculator.lr.string == "4")
    calculator.press(TwoOperantOperation.mul)
    #expect(calculator.lr.string == "4")
    calculator.press(DigitOperation.three)
    #expect(calculator.lr.string == "3")
    calculator.press(TwoOperantOperation.add)
    #expect(calculator.lr.string == "12")
    calculator.press(DigitOperation.two)
    #expect(calculator.lr.string == "2")
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "14")

    // 1 + 3 * 2 = 7
    calculator.press(DigitOperation.one)
    #expect(calculator.lr.string == "1")
    calculator.press(TwoOperantOperation.add)
    #expect(calculator.lr.string == "1")
    calculator.press(DigitOperation.three)
    #expect(calculator.lr.string == "3")
    calculator.press(TwoOperantOperation.mul)
    #expect(calculator.lr.string == "3")
    calculator.press(DigitOperation.two)
    #expect(calculator.lr.string == "2")
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "7")

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
