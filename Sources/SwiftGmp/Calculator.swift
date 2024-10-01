//
//  Calculator.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 27.09.24.
//

public class Calculator {
    private var token: Token
    private var precision: Int
    public init(precision: Int) {
        self.precision = precision
        token = Token(precision: precision)
    }
    public func setPrecision(newPrecision: Int) {
        self.precision = newPrecision
        token.setPrecision(newPrecision: newPrecision)
    }

    public func calc(_ expression: String) -> String {
        var trimmedExpression = expression.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedExpression.hasSuffix("=") {
            trimmedExpression = String(trimmedExpression.dropLast())
        }
        do {
            try token.tokenize(trimmedExpression)
            token.shuntingYard()
            let res = token.evaluatePostfix()
            return res.toDouble().description
        } catch {
            return error.localizedDescription
        }
    }
}
