//
//  testCommandParser.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 26.09.24.
//


import Testing
import SwiftGmp

@Test func testTokenizer() {
    var tokenizer = Tokenizer()
    
    do {
        let _ = try tokenizer.parse("1 sin =")
        #expect(Bool(false)) // Expected an error to be thrown, but nothing was thrown
    } catch {
        switch error {
            case Tokenizer.TokenizerError.unknownOperator(let op):
                print("unknown operator \(op)")
            default: break
        }
    }
}
