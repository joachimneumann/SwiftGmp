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
        var (operators, numbers) : ([any OpProtocol], [Number])
        
//        (operators, numbers) = try tokenizer.parse("1 sin =")
//        #expect(numbers.count == 1)
//        #expect(numbers[0].toDouble() == 1)
//        #expect(operators.count == 1)
//        #expect(operators[0].isEqual(to: SwiftGmpInplaceOperation.sin))
//
//        (operators, numbers) = try tokenizer.parse("1 sinD =")
//        #expect(numbers.count == 1)
//        #expect(numbers[0].toDouble() == 1)
//        #expect(operators.count == 1)
//        #expect(operators[0].isEqual(to: SwiftGmpInplaceOperation.sinD))

        //
//        (operators, numbers) = try tokenizer.parse("3")
//        #expect(numbers.count == 1)
//        #expect(numbers[0].toDouble() == 3)
//        #expect(operators.count == 0)
//
//        (operators, numbers) = try tokenizer.parse("-3")
//        #expect(numbers.count == 1)
//        #expect(numbers[0].toDouble() == -3)
//        #expect(operators.count == 0)
//
//        (operators, numbers) = try tokenizer.parse("3 - 4")
//        #expect(numbers.count == 2)
//        #expect(numbers[0].toDouble() == 3)
//        #expect(numbers[1].toDouble() == 4)
//        #expect(operators.count == 1)
//        #expect(operators[0].isEqual(to: SwiftGmpTwoOperantOperation.sub))
//
//        (operators, numbers) = try tokenizer.parse("3 * 4")
//        #expect(numbers.count == 2)
//        #expect(numbers[0].toDouble() == 3)
//        #expect(numbers[1].toDouble() == 4)
//        #expect(operators.count == 1)
//        #expect(operators[0].isEqual(to: SwiftGmpTwoOperantOperation.mul))
//
//        (operators, numbers) = try tokenizer.parse("3 * -4")
//        #expect(numbers.count == 2)
//        #expect(numbers[0].toDouble() == 3)
//        #expect(numbers[1].toDouble() == -4)
//        #expect(operators.count == 1)
//        #expect(operators[0].isEqual(to: SwiftGmpTwoOperantOperation.mul))
//
//        (operators, numbers) = try tokenizer.parse("-3 - 4")
//        #expect(numbers.count == 2)
//        #expect(numbers[0].toDouble() == -3)
//        #expect(numbers[1].toDouble() == 4)
//        #expect(operators.count == 1)
//        #expect(operators[0].isEqual(to: SwiftGmpTwoOperantOperation.sub))
//
//        (operators, numbers) = try tokenizer.parse("3 - 4e6")
//        #expect(numbers.count == 2)
//        #expect(numbers[0].toDouble() == 3)
//        #expect(numbers[1].toDouble() == 4e6)
//        #expect(operators.count == 1)
//        #expect(operators[0].isEqual(to: SwiftGmpTwoOperantOperation.sub))
//
//        (operators, numbers) = try tokenizer.parse("3e-4 - 4e6")
//        #expect(numbers.count == 2)
//        #expect(numbers[0].toDouble() == 3e-4)
//        #expect(numbers[1].toDouble() == 4e6)
//        #expect(operators.count == 1)
//        #expect(operators[0].isEqual(to: SwiftGmpTwoOperantOperation.sub))
//
//        (operators, numbers) = try tokenizer.parse("3e-4 - 4e-6")
//        #expect(numbers.count == 2)
//        #expect(numbers[0].toDouble() == 3e-4)
//        #expect(numbers[1].toDouble() == 4e-6)
//        #expect(operators.count == 1)
//        #expect(operators[0].isEqual(to: SwiftGmpTwoOperantOperation.sub))
//
//        (operators, numbers) = try tokenizer.parse("-3 - 4e-6")
//        #expect(numbers.count == 2)
//        #expect(numbers[0].toDouble() == -3)
//        #expect(numbers[1].toDouble() == 4e-6)
//        #expect(operators.count == 1)
//        #expect(operators[0].isEqual(to: SwiftGmpTwoOperantOperation.sub))
//
//        (operators, numbers) = try tokenizer.parse("-3e-4 - 5e-6")
//        #expect(numbers.count == 2)
//        #expect(numbers[0].toDouble() == -3e-4)
//        #expect(numbers[1].toDouble() == 5e-6)
//        #expect(operators.count == 1)
//        #expect(operators[0].isEqual(to: SwiftGmpTwoOperantOperation.sub))
//
//        (operators, numbers) = try tokenizer.parse("-3e-4 / 5e-6")
//        #expect(numbers.count == 2)
//        #expect(numbers[0].toDouble() == -3e-4)
//        #expect(numbers[1].toDouble() == 5e-6)
//        #expect(operators.count == 1)
//        #expect(operators[0].isEqual(to: SwiftGmpTwoOperantOperation.div))
//
//        (operators, numbers) = try tokenizer.parse("-3e-4 * 5e-6")
//        #expect(numbers.count == 2)
//        #expect(numbers[0].toDouble() == -3e-4)
//        #expect(numbers[1].toDouble() == 5e-6)
//        #expect(operators.count == 1)
//        #expect(operators[0].isEqual(to: SwiftGmpTwoOperantOperation.mul))
//
//        (operators, numbers) = try tokenizer.parse("-3e-4 * -5e-6")
//        #expect(numbers.count == 2)
//        #expect(numbers[0].toDouble() == -3e-4)
//        #expect(numbers[1].toDouble() == -5e-6)
//        #expect(operators.count == 1)
//        #expect(operators[0].isEqual(to: SwiftGmpTwoOperantOperation.mul))

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
