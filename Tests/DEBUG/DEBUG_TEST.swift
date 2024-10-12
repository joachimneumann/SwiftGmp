// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 20)
    
    #expect(calculator.evaluateString("2 ^ 3").string == "8")
    #expect(calculator.evaluateString("3 ^ 2").string == "9")
    #expect(calculator.evaluateString("(4 + (3 x 5) - (2 + (6 / 2)))").string == "14")
    #expect(calculator.evaluateString("5 x (2 + 3 x (4 + 5))").string == "145")
    #expect(calculator.evaluateString("2 ^ (3 + 1)").string == "16")
    #expect(calculator.evaluateString("(5 ^ 2) + (6 x 3) - (7 / 7)").string == "42")
    #expect(calculator.evaluateString("(3 + 2) x (4 - 1) sqrt").string == "8.6602540378")
    #expect(calculator.evaluateString("10 x (5 + 5) log10").string == "10")
    #expect(calculator.evaluateString("100 x (2 + 3) log10").string == "69.897000433")
}
