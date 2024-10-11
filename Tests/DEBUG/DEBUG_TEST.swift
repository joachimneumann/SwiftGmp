// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 20)
    
    var temp: Double
    
//    #expect(calculator.evaluateString("1.1 x 1").string == "1.1")

    #expect(calculator.evaluateString("1000 + - 10.99").string == "989.01")
    
    temp = calculator.asDouble("(1500 - 2000) / 3.12")
    #expect(temp.similarTo(-160.25641))
    
    temp = calculator.asDouble("(1500 - 2000) / 1234.56789")
    #expect(temp.similarTo(-0.4050000))
    
    #expect(calculator.evaluateString("0000").string == "0")

    #expect(calculator.evaluateString("0123456789").string == "123456789")

//    // 4 * (3 + 2) = 20
//    calculator.press(DigitOperation.four)
//    calculator.press(TwoOperantOperation.mul)
//    calculator.press(ParenthesisOperation.left)
//    calculator.press(DigitOperation.three)
//    calculator.press(TwoOperantOperation.add)
//    calculator.press(DigitOperation.two)
//    calculator.press(ParenthesisOperation.right)
//    calculator.press(EqualOperation.equal)
//    #expect(calculator.lr.string == "20")

//    let result = calculator.evaluateString("4.0 sqr")
//    #expect(result.string == "16")
}
