// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 20)
    // var opResult: Bool
    let x = calculator.evaluateString("10 %")
    #expect(calculator.evaluateString("10 %").string == "0.1")

    
    let lr = calculator.evaluateString("1.1 * 1")
    #expect(lr.string == "1.1")
    
    #expect(calculator.evaluateString("1.1 * 1").string == "1.1")
    #expect(calculator.evaluateString("1 + 3 * 10").string == "31")
    #expect(calculator.evaluateString("1 + 2").string == "3")
    #expect(calculator.evaluateString("2 * 4").string == "8")
    #expect(calculator.evaluateString("3 / 0").string == "inf")
    #expect(calculator.evaluateString("10/2").string == "5")
    #expect(calculator.evaluateString("-5.0 abs").string == "5")
    #expect(calculator.evaluateString("3.14 abs").string == "3.14")
    #expect(calculator.evaluateString("0.0 abs").string == "0")
    #expect(calculator.evaluateString("500 + 500").string == "1000")
    #expect(calculator.evaluateString("-100.25 abs").string == "100.25")
    #expect(calculator.evaluateString("12.5 abs").string == "12.5")
    #expect(calculator.evaluateString("153.4 - 153").string == "0.4")
    #expect(calculator.evaluateString("153.4 - 152").string == "1.4")
    #expect(calculator.evaluateString("153.4 - 142").string == "11.4")
    #expect(calculator.evaluateString("153.4 - 154").string == "-0.6")
    #expect(calculator.evaluateString("153.4 - 155").string == "-1.6")
    #expect(calculator.evaluateString("153.4 - 165").string == "-11.6")
}
