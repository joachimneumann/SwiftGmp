// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 100)
    calculator.display.displayWidth = 10
    calculator.evaluateString("-9.9999999999")
    var raw = calculator.raw
    #expect(raw.mantissa == "9999999999")

//    swiftGmp = SwiftGmp(withString: "-9.999999999", bits: 100)
//    raw = swiftGmp.raw(digits: L)
//    display.update(raw: raw)
//    #expect(raw.mantissa == "9999999999")
//    #expect(raw.exponent == 0)
//    #expect(raw.isNegative == true)
//    #expect(raw.canBeInteger == false)
//    
//    
//    calculator.evaluateString("10000")
//    x = calculator.raw
//    calculator.evaluateString("1234567890")
//    x = calculator.raw
//    calculator.evaluateString("12345678901")
//    x = calculator.raw
//    calculator.evaluateString("12345678901")
//
//    calculator.evaluateString("555555555.1234567890")
//    #expect(calculator.string == "5.555555e8")
//
//    calculator.evaluateString("5555555555.1234567890")
//    #expect(calculator.string == "5.555555e9")
//
//    calculator.evaluateString("55555555555.1234567890")
//    #expect(calculator.string == "5.55555e10")

    
}
