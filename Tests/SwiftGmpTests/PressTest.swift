//
//  PressTest.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 05.10.24.
//

import Testing
@testable import SwiftGmp

@Test func pressTest() {
    let calculator = Calculator(precision: 20)
    calculator .maxOutputLength = 10

    // 1 + 3 * 2 = 7
    calculator.press(DigitOperation.one)
    calculator.press(TwoOperantOperation.add)
    calculator.press(DigitOperation.three)
    calculator.press(TwoOperantOperation.mul)
    calculator.press(DigitOperation.two)
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "7")

    // 4 * 3 + 2 = 6
    calculator.press(DigitOperation.four)
    calculator.press(TwoOperantOperation.mul)
    calculator.press(DigitOperation.three)
    calculator.press(TwoOperantOperation.add)
    calculator.press(DigitOperation.two)
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "14")

    // 4 * (3 + 2) = 20
    calculator.press(DigitOperation.four)
    calculator.press(TwoOperantOperation.mul)
    calculator.press(ParenthesisOperation.left)
    calculator.press(DigitOperation.three)
    calculator.press(TwoOperantOperation.add)
    calculator.press(DigitOperation.two)
    calculator.press(ParenthesisOperation.right)
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "14")

    calculator.clear()
    #expect(calculator.lr.string == "0")
    calculator.press(DigitOperation.dot)
    let x1 = calculator.lr.string
    #expect(x1 == "0.")
    calculator.press(DigitOperation.dot)
    calculator.press(DigitOperation.dot)
    calculator.press(DigitOperation.dot)
    calculator.press(DigitOperation.dot)
    #expect(calculator.lr.string == "0.")
    calculator.press(DigitOperation.one)
    #expect(calculator.lr.string == "0.1")
    calculator.press(DigitOperation.dot)
    #expect(calculator.lr.string == "0.1")
    calculator.press(DigitOperation.one)
    #expect(calculator.lr.string == "0.11")
    calculator.press(DigitOperation.dot)
    #expect(calculator.lr.string == "0.11")

    calculator.press(ClearOperation.clear)
    calculator.press(DigitOperation.one)
    #expect(calculator.lr.string == "1")
    calculator.press(DigitOperation.dot)
    let l = calculator.lr.string
    #expect(l == "1.")
    calculator.press(DigitOperation.dot)
    calculator.press(DigitOperation.dot)
    calculator.press(DigitOperation.dot)
    #expect(calculator.lr.string == "1.")

    
    calculator.press(ConstantOperation.pi)
    calculator.press(ConstantOperation.pi)
    calculator.press(ConstantOperation.pi)
    calculator.press(ConstantOperation.pi)
    // buffer: empty
    // tokens: pi
    // numberExpected = false
    #expect(calculator.lr.string == "3.14159265")
    #expect(calculator.token.tokens.count == 1)
    #expect(calculator.lr.string == "3.14159265")
    
    calculator.press(DigitOperation.two)
    // buffer: 2
    // tokens: empty
    // numberExpected = false
    #expect(calculator.lr.string == "2")
    #expect(calculator.token.tokens.count == 0)
    
    calculator.press(InplaceOperation.sqr)
    // buffer: empty
    // tokens: 2
    // ->
    // buffer: empty
    // tokens: 4
    #expect(calculator.lr.string == "4")
    #expect(calculator.token.tokens.count == 1)
    
    calculator.press(TwoOperantOperation.add)
    // buffer: empty
    // tokens: 2, add
    #expect(calculator.lr.string == "4")
    #expect(calculator.token.tokens[0].debugDescription == "swiftGmp 4.0")
    #expect(calculator.token.tokens[1].debugDescription == "twoOperant +")
    #expect(calculator.token.tokens.count == 2)
    
    calculator.press(EqualOperation.equal)
    // display: 4
    // tokens: 4
    #expect(calculator.lr.string == "4")
    #expect(calculator.token.tokens.count == 1)
    
    calculator.press(ClearOperation.clear)
    // buffer: empty
    // tokens: 0
    #expect(calculator.lr.string == "0")
    #expect(calculator.token.tokens.count == 0)
    
    calculator.press(DigitOperation.two)
    // buffer: 2
    // tokens: empty
    #expect(calculator.lr.string == "2")
    #expect(calculator.token.tokens.count == 0)
    
    calculator.press(DigitOperation.zero)
    // buffer: 20
    // tokens: empty
    #expect(calculator.lr.string == "20")
    #expect(calculator.token.tokens.count == 0)
    
    calculator.press(InplaceOperation.sqr)
    // buffer: empty
    // tokens: 400
    #expect(calculator.lr.string == "400")
    #expect(calculator.token.tokens.count == 1)
    
    calculator.press(TwoOperantOperation.add)
    // buffer: empty
    // tokens: 400, add
    #expect(calculator.lr.string == "400")
    #expect(calculator.token.tokens.count == 2)
    
    calculator.press(DigitOperation.six)
    // buffer: 6
    // tokens: 400, add
    #expect(calculator.lr.string == "6")
    #expect(calculator.token.tokens.count == 2)
    
    calculator.press(EqualOperation.equal)
    // buffer: empty
    // tokens: 406
    #expect(calculator.lr.string == "406")
    #expect(calculator.token.tokens.count == 1)
    
    calculator.press(ConstantOperation.pi)
    #expect(calculator.lr.string == "3.14159265")
    #expect(calculator.token.tokens.count == 1)
    
    calculator.press(ConstantOperation.e)
    #expect(calculator.lr.string == "2.71828182")
    #expect(calculator.token.tokens.count == 1)
    
    calculator.press(TwoOperantOperation.add)
    // buffer: empty
    // tokens: 400, add
    #expect(calculator.lr.string == "2.71828182")
    #expect(calculator.token.tokens.count == 2)
    
    calculator.press(DigitOperation.six)
    #expect(calculator.lr.string == "6")
    #expect(calculator.token.tokens.count == 2)
    
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "8.71828182")
    #expect(calculator.token.tokens.count == 1)
    
    
    //    calculator.clear()
    ////    #expect(calculator.asString("e pi + e") == "5.85987448")
    ////    #expect(calculator.asString("10 + pi 1") == "11")
    ////    #expect(calculator.asString("10 + pi") == "13.1415926")
    //
    
    
    var pending: [any OpProtocol] = []
    calculator.clear()
    pending = calculator.pendingOperators
    #expect(pending.count == 0)
    #expect(calculator.lr.string == "0")
    
    calculator.press(DigitOperation.two)
    pending = calculator.pendingOperators
    #expect(pending.count == 0)
    #expect(calculator.lr.string == "2")
    //calculator.evaluate()

    calculator.press(TwoOperantOperation.add)
    pending = calculator.pendingOperators
    #expect(pending.count == 1)
    #expect(calculator.lr.string == "2")
    //calculator.evaluate()

    calculator.press(DigitOperation.four)
    pending = calculator.pendingOperators
    #expect(pending.count == 1)
    #expect(calculator.lr.string == "4")
    //calculator.evaluate()

    calculator.press(EqualOperation.equal)
    pending = calculator.pendingOperators
    #expect(pending.count == 0)
    #expect(calculator.lr.string == "6")
    //calculator.evaluate()

    calculator.press(TwoOperantOperation.mul)
    pending = calculator.pendingOperators
    #expect(pending.count == 1)
    #expect(calculator.lr.string == "6")
    
    calculator.press(DigitOperation.two)
    pending = calculator.pendingOperators
    #expect(pending.count == 1)
    #expect(calculator.lr.string == "2")
    
    calculator.press(EqualOperation.equal)
    pending = calculator.pendingOperators
    #expect(pending.count == 0)
    #expect(calculator.lr.string == "12")
    
    calculator.press(DigitOperation.two)
    #expect(calculator.lr.string == "2")
    calculator.press(InplaceOperation.sqr)
    #expect(calculator.lr.string == "4")
    calculator.press(DigitOperation.five)
    #expect(calculator.lr.string == "5")
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "5")
    calculator.press(ClearOperation.clear)
    ////    #expect(calculator.asString("2 sqr 5") == "5")
    //
    calculator.press(DigitOperation.three)
    #expect(calculator.lr.string == "3")
    calculator.press(TwoOperantOperation.add)
    #expect(calculator.lr.string == "3")
    calculator.press(DigitOperation.five)
    #expect(calculator.lr.string == "5")
    calculator.press(InplaceOperation.sqr)
    #expect(calculator.lr.string == "25")
    calculator.press(ConstantOperation.pi)
    #expect(calculator.lr.string == "3.14159265")
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "6.14159265")
    
    calculator.press(ConstantOperation.e)
    calculator.press(ConstantOperation.pi)
    #expect(calculator.lr.string == "3.14159265")
    calculator.press(TwoOperantOperation.add)
    calculator.press(ConstantOperation.e)
    #expect(calculator.lr.string == "2.71828182")
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "5.85987448")
    
    calculator.press(ClearOperation.clear)
    calculator.press(DigitOperation.one)
    calculator.press(TwoOperantOperation.add)
    calculator.press(DigitOperation.two)
    calculator.press(TwoOperantOperation.mul)
    pending = calculator.pendingOperators
    #expect(pending.count == 2)

}
