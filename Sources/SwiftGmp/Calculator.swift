//
//  Calculator.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 27.09.24.
//

public class Calculator {
    private var tokenizer: Tokenizer
    private var precision: Int
    public init(precision: Int) {
        self.precision = precision
        tokenizer = Tokenizer(precision: precision)
    }
    public func setPrecision(newPrecision: Int) {
        self.precision = newPrecision
        tokenizer.setPrecision(newPrecision: newPrecision)
    }

    public func calc(_ expression: String) -> String {
        do {
            let (operators, numbers) = try tokenizer.parse(expression)
            if numbers.count == 0 {
                return "missing number in expression"
            }
//            while operators.count > 0 {
//                let op = operators.first
//                operators.removeFirst()
//                if let inplace = op as? InplaceOperator {
//                    if let n = numbers.first {
//                        numbers.removeFirst()
//                        let xx = inplace.operation
//                        n.inplace_Z()
////                        xx(n)
//                    }
//                }
//            }
            return "result"
        } catch {
            return error.localizedDescription
        }
    }
}
