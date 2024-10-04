// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 20)
    calculator .maxOutputLength = 10
    #expect(calculator.asString("e pi + e") == "5.85987448")
    #expect(calculator.asString("10 + pi 1") == "11")
    #expect(calculator.asString("10 + pi") == "13.1415926")

    calculator.press(SwiftGmpConstantOperation.e)
    calculator.press(SwiftGmpConstantOperation.pi)
    #expect(calculator.display.R.leftRight(maxOutputLength: 10).string == "3.14159265")
    calculator.press(SwiftGmpTwoOperantOperation.add)
    calculator.press(SwiftGmpConstantOperation.e)
    #expect(calculator.display.R.leftRight(maxOutputLength: 10).string == "2.71828182")
    calculator.evaluate()
    #expect(calculator.display.R.leftRight(maxOutputLength: 10).string == "5.85987448")
}
