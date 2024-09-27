//
//  Calculator.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 27.09.24.
//

public class Calculator {
    private var tokenizer = Tokenizer()
    
    public init() {
    }
    
    public func calc(_ expression: String) -> String {
        do {
            var (operators, numbers) = try tokenizer.parse(expression)
            if numbers.count == 0 {
                return "missing number in expression"
            }
            while operators.count > 0 {
                let op = operators.first
                operators.removeFirst()
                if let inplace = op as? InplaceOperator {
                    let n = numbers.first
                    numbers.removeFirst()
                    inplace(n)
                }
            }
            return "result"
        } catch {
            return error.localizedDescription
        }
    }
}
