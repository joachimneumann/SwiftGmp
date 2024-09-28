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
        var operators: [OpProtocol]
        var numbers: [Number]
        
        var trimmedExpression = expression.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedExpression.hasSuffix("=") {
            trimmedExpression = String(trimmedExpression.dropLast())
        }
        do {
            (operators, numbers) = try tokenizer.parse(trimmedExpression)
        } catch {
            return error.localizedDescription
        }
        if numbers.count == 0 && operators.count == 0 {
            return ""
        }
        if operators.count == 0 {
            return "no operator found"
        }
        if numbers.count == 0 {
            return "no number found"
        }
        while operators.count > 0 {
            let op = operators.first
            operators.removeFirst()
            if let inPlace = op as? SwiftGmpInplaceOperation {
                if let n = numbers.first {
                    n.swiftGmp.execute(inPlace)
                }
            } else if let twoOperants = op as? SwiftGmpTwoOperantOperation {
                if let n1 = numbers.first {
                    numbers.removeFirst()
                    if numbers.first != nil {
                        numbers.first!.swiftGmp.execute(twoOperants, other: n1.swiftGmp)
                    }
                }
            }
            if operators.count == 0 {
                if let result = numbers.first {
                    return String(result.swiftGmp.toDouble())
                }
            }
        }
        return "something went wrong"
    }
}
