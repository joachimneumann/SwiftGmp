// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 100)
//    var swiftGmp: SwiftGmp
//    var raw: Raw
//    var display: Display
//    let L = 10
    
    calculator.evaluateString("sind(180)")
    #expect(calculator.string == "0")

//    calculator.evaluateString("1 + 3 * 10")
//    let xraw = calculator.string
//    #expect(calculator.string == "31")
    
}
