//
//  Calculator.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 27.09.24.
//

public class Calculator {
    private var token: Token
    private var display: Number
    private var precision: Int
    private var memory: Number?
    public init(precision: Int) {
        self.precision = precision
        token = Token(precision: precision)
        display = Number("0", precision: precision)
    }
    public func setPrecision(newPrecision: Int) {
        self.precision = newPrecision
        token.setPrecision(newPrecision)
        display.setPrecision(precision)
    }

    private func add(_ expression: String) throws {
        var trimmedExpression = expression.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedExpression.hasSuffix("=") {
            trimmedExpression = String(trimmedExpression.dropLast())
        }
        var needsEvaluation = false
        switch trimmedExpression {
        case "C":
            token.clear()
            display = Number("0", precision: precision)
        case "MR":
            if memory != nil {
                display = memory!.copy()
            }
            break
        case "MC":
            memory = nil
            break
        case "M+":
            if memory == nil {
                memory = display.copy()
            } else {
                memory!.swiftGmp.execute(.add, other: display.swiftGmp)
            }
            break
        case "M-":
            if memory == nil {
                memory = display.copy()
            } else {
                memory!.swiftGmp.execute(.sub, other: display.swiftGmp)
            }
            break
        default:
            do {
                try token.tokenize(trimmedExpression)
                needsEvaluation = true
            } catch {
                throw error
            }
        }
        if needsEvaluation {
            token.shuntingYard()
            display = token.evaluatePostfix()
        }
    }

    public func asString(_ expression: String) -> String {
        do { try add(expression) } catch { return error.localizedDescription }
        return String(display.toDouble())
    }
    public func asDouble(_ expression: String) -> Double {
        do { try add(expression) } catch { return Double.nan }
        return display.toDouble()
    }
}
