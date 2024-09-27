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
        #expect(Bool(true))
    } catch {
        switch error {
            case TokenizerError.unknownOperator(let op):
                print("unknown operator \(op)")
            default: break
        }
        #expect(Bool(false))
    }
}
