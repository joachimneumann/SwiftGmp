//
//  PressTest.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 05.10.24.
//

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 20)
    var opResult: Bool
    calculator .maxOutputLength = 10
    
    calculator.press(SwiftGmpConstantOperation.pi)
    calculator.press(SwiftGmpConstantOperation.pi)
    calculator.press(SwiftGmpConstantOperation.pi)
    calculator.press(SwiftGmpConstantOperation.pi)
    // buffer: empty
    // tokens: pi
    // numberExpected = false
    #expect(calculator.lr.string == "3.14159265")
    #expect(calculator.token.tokens.count == 1)
    #expect(calculator.lr.string == "3.14159265")
    
    calculator.press(Calculator.Digit.two)
    // buffer: 2
    // tokens: empty
    // numberExpected = false
    #expect(calculator.lr.string == "2")
    #expect(calculator.token.tokens.count == 0)
    
    opResult = calculator.operate(SwiftGmpInplaceOperation.sqr)
    // buffer: empty
    // tokens: 2
    // ->
    // buffer: empty
    // tokens: 4
    #expect(calculator.lr.string == "4")
    #expect(calculator.token.tokens.count == 1)
    
    opResult = calculator.operate(SwiftGmpTwoOperantOperation.add)
    // buffer: empty
    // tokens: 2, add
    #expect(calculator.lr.string == "4")
    #expect(calculator.token.tokens[0].debugDescription == "4.0")
    #expect(calculator.token.tokens[1].debugDescription == "twoOperant add")
    #expect(calculator.token.tokens.count == 2)
    
    calculator.evaluate()
    // display: 4
    // tokens: 4
    #expect(calculator.lr.string == "4")
    #expect(calculator.token.tokens.count == 1)
    
    calculator.clear()
    // buffer: empty
    // tokens: 0
    #expect(calculator.lr.string == "0")
    #expect(calculator.token.tokens.count == 0)
    
    calculator.press(Calculator.Digit.two)
    // buffer: 2
    // tokens: empty
    #expect(calculator.lr.string == "2")
    #expect(calculator.token.tokens.count == 0)
    
    calculator.press(Calculator.Digit.zero)
    // buffer: 20
    // tokens: empty
    #expect(calculator.lr.string == "20")
    #expect(calculator.token.tokens.count == 0)
    
    opResult = calculator.operate(SwiftGmpInplaceOperation.sqr)
    // buffer: empty
    // tokens: 400
    #expect(calculator.lr.string == "400")
    #expect(calculator.token.tokens.count == 1)
    
    opResult = calculator.operate(SwiftGmpTwoOperantOperation.add)
    // buffer: empty
    // tokens: 400, add
    #expect(calculator.lr.string == "400")
    #expect(calculator.token.tokens.count == 2)
    
    calculator.press(Calculator.Digit.six)
    // buffer: 6
    // tokens: 400, add
    #expect(calculator.lr.string == "6")
    #expect(calculator.token.tokens.count == 2)
    
    calculator.evaluate()
    // buffer: empty
    // tokens: 406
    #expect(calculator.lr.string == "406")
    #expect(calculator.token.tokens.count == 1)
    
    calculator.press(SwiftGmpConstantOperation.pi)
    #expect(calculator.lr.string == "3.14159265")
    #expect(calculator.token.tokens.count == 1)
    
    calculator.press(SwiftGmpConstantOperation.e)
    #expect(calculator.lr.string == "2.71828182")
    #expect(calculator.token.tokens.count == 1)
    
    opResult = calculator.operate(SwiftGmpTwoOperantOperation.add)
    // buffer: empty
    // tokens: 400, add
    #expect(calculator.lr.string == "2.71828182")
    #expect(calculator.token.tokens.count == 2)
    
    calculator.press(Calculator.Digit.six)
    #expect(calculator.lr.string == "6")
    #expect(calculator.token.tokens.count == 2)
    
    calculator.evaluate()
    #expect(calculator.lr.string == "8.71828182")
    #expect(calculator.token.tokens.count == 1)
    
    
    //    calculator.clear()
    ////    #expect(calculator.asString("e pi + e") == "5.85987448")
    ////    #expect(calculator.asString("10 + pi 1") == "11")
    ////    #expect(calculator.asString("10 + pi") == "13.1415926")
    //
    calculator.press(Calculator.Digit.two)
    #expect(calculator.lr.string == "2")
    opResult = calculator.operate(SwiftGmpInplaceOperation.sqr)
    #expect(calculator.lr.string == "4")
    calculator.press(Calculator.Digit.five)
    #expect(calculator.lr.string == "5")
    calculator.evaluate()
    #expect(calculator.lr.string == "5")
    calculator.clear()
    ////    #expect(calculator.asString("2 sqr 5") == "5")
    //
    calculator.press(Calculator.Digit.three)
    #expect(calculator.lr.string == "3")
    opResult = calculator.operate(SwiftGmpTwoOperantOperation.add)
    #expect(calculator.lr.string == "3")
    calculator.press(Calculator.Digit.five)
    #expect(calculator.lr.string == "5")
    opResult = calculator.operate(SwiftGmpInplaceOperation.sqr)
    #expect(calculator.lr.string == "25")
    calculator.press(SwiftGmpConstantOperation.pi)
    #expect(calculator.lr.string == "3.14159265")
    calculator.evaluate()
    #expect(calculator.lr.string == "6.14159265")
    
    calculator.press(SwiftGmpConstantOperation.e)
    calculator.press(SwiftGmpConstantOperation.pi)
    #expect(calculator.lr.string == "3.14159265")
    opResult = calculator.operate(SwiftGmpTwoOperantOperation.add)
    #expect(opResult)
    calculator.press(SwiftGmpConstantOperation.e)
    #expect(calculator.lr.string == "2.71828182")
    calculator.evaluate()
    #expect(calculator.lr.string == "5.85987448")
}
