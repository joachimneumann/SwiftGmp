// Note: This file is automatically generated.
//       It will be overwritten sooner or later.

import Testing
@testable import SwiftGmp

@Test func calculatorTestRaw() {
    let calculator = Calculator(precision: 20)

    calculator.evaluateString("1 + 2 * 3")
    #expect(calculator.string == "7")

    calculator.evaluateString("sin(sin(1))")
    #expect(calculator.string == "0.74562414")

    calculator.evaluateString("4.5")
    #expect(calculator.string == "4.5")

// clearing memory, no change to the display
    calculator.evaluateString("sqr(2)")
    #expect(calculator.string == "4")

    calculator.evaluateString("sqr(2) 5")
    #expect(calculator.string == "5")

    calculator.evaluateString("10 %")
    #expect(calculator.string == "0.1")

}
