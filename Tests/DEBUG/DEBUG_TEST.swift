// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 20)
    
//    let x = calculator.evaluateString("abs (-3)")
//    let x1 = calculator.evaluateString("sin((3 + 2) x (5 - 3))")
//    let x = calculator.evaluateString("1+abs(-3)+1")
    #expect(calculator.evaluateString("1+abs(-3)+1").string == "5")
    #expect(calculator.evaluateString("1+abs(3)+1").string == "5")
//    print(x)
    #expect(calculator.evaluateString("abs   (3)").string == "3")
    #expect(calculator.evaluateString("abs(3)").string == "3")
    #expect(calculator.evaluateString("abs(-3)").string == "3")
    #expect(calculator.evaluateString("abs (-3)").string == "3")
    #expect(calculator.evaluateString("3").string == "3")
    #expect(calculator.evaluateString("-3").string == "-3")
    #expect(calculator.evaluateString("3-4").string == "-1")
    #expect(calculator.evaluateString("3 - -4").string == "7")
    #expect(calculator.evaluateString("3- -4").string == "7")
    #expect(calculator.evaluateString("3 - 4").string == "-1")
    #expect(calculator.evaluateString("abs(-1x(3 + 2) x (5 - 3))").string == "10")
}
