// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 20)
    
    // 3 + 2 --> 2
    calculator.press(DigitOperation.three)
    #expect(calculator.lr.string == "3")
    calculator.press(TwoOperantOperation.add)
    #expect(calculator.lr.string == "3")
    calculator.press(DigitOperation.two)
    #expect(calculator.lr.string == "2")
    calculator.clear()
    
    // 4 * (3 + 2) = 20
    calculator.press(DigitOperation.four)
    #expect(calculator.lr.string == "4")
    calculator.press(TwoOperantOperation.mul)
    #expect(calculator.lr.string == "4")
    calculator.press(ParenthesisOperation.left)
    #expect(calculator.lr.string == "4")
    calculator.press(DigitOperation.three)
    #expect(calculator.lr.string == "3")
    calculator.press(TwoOperantOperation.add)
    #expect(calculator.lr.string == "3")
    calculator.press(DigitOperation.two)
    #expect(calculator.lr.string == "2")
    calculator.press(ParenthesisOperation.right)
    #expect(calculator.lr.string == "5")
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "20")

//    let result = calculator.evaluateString("4.0 sqr")
//    #expect(result.string == "16")
}
