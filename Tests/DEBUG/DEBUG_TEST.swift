// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 100)
    calculator.maxOutputLength = 100
    
    calculator.maxOutputLength = 10
    calculator.press(ClearOperation.clear)
    calculator.press(DigitOperation.one)
    calculator.press(TwoOperantOperation.div)
    calculator.press(DigitOperation.seven)
    calculator.press(EqualOperation.equal)
    let x = calculator.string
    let xx = "s"
}
