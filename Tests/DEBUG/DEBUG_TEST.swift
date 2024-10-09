// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 20)
    
    calculator.press(DigitOperation.one)
    calculator.press(TwoOperantOperation.div)
    calculator.press(DigitOperation.zero)
    calculator.press(EqualOperation.equal)
    #expect(calculator.token.lastSwiftGmp!.isValid == false)
    #expect(calculator.lr.string == "inf")
    let invalid = calculator.invalidOperators
    #expect(invalid.count > 1)
    calculator.press(ClearOperation.clear)

    calculator.press(DigitOperation.one)
    calculator.press(InplaceOperation.sqr)
    calculator.press(TwoOperantOperation.add)
    let pending = calculator.pendingOperators
    #expect(pending.count == 1)
    calculator.press(ClearOperation.clear)

    calculator.press(TwoOperantOperation.mul)
    calculator.press(TwoOperantOperation.sub)
    calculator.press(TwoOperantOperation.add)
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "0")

    
    // var opResult: Bool
    let x = calculator.evaluateString("10 %")
    #expect(x.string == "0.1")
    #expect(calculator.evaluateString("10 %").string == "0.1")
    let temp = calculator.asDouble("200 + e %")
    #expect(temp ~= 205.43656365)

    
    let lr = calculator.evaluateString("1.1 x 1")
    #expect(lr.string == "1.1")
    
    #expect(calculator.evaluateString("1.1 x 1").string == "1.1")
    #expect(calculator.evaluateString("1 + 3 x 10").string == "31")
    #expect(calculator.evaluateString("1 + 2").string == "3")
    #expect(calculator.evaluateString("2 x 4").string == "8")
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
