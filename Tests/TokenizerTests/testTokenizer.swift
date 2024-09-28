//
//  testCommandParser.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 26.09.24.
//


import Testing
import SwiftGmp

@Test func testTokenizer() {
    var tokenizer = Tokenizer(precision: 20)
    
    do {
        let _ = try tokenizer.parse("1 sin =")
        #expect(Bool(true))
        let (operators, numbers) = try tokenizer.parse("-3e-4-5e-6")
        #expect(operators.count == 1)
        #expect(operators.count == 1)
        #expect(numbers.count == 2)
        #expect(numbers[0].swiftGmp.toDouble() == -3e-4)
        #expect(numbers[1].swiftGmp.toDouble() == 5e-6)
    } catch {
        switch error {
            case TokenizerError.unknownOperator(let op):
                print("unknown operator \(op)")
            default: break
        }
        #expect(Bool(false))
    }
}
