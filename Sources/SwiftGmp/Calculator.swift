//
//  Calculator.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 27.09.24.
//

public actor Calculator {
    private var token: Token
    private var display: Number
    private var precision: Int
    private var memory: Number?
    public init(precision: Int) {
        self.precision = precision
        token = Token(precision: precision)
        display = Number("0", precision: precision)
    }
    public func setPrecision(newPrecision: Int) async {
        self.precision = newPrecision
        await token.setPrecision(newPrecision)
        display.setPrecision(precision)
    }

    private func add(_ expression: String) async throws {
        var trimmedExpression = expression.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedExpression.hasSuffix("=") {
            trimmedExpression = String(trimmedExpression.dropLast())
        }
        var needsEvaluation = false
        switch trimmedExpression {
        case "C":
            await token.clear()
            display = Number("0", precision: precision)
        case "MR":
            if memory != nil {
                display = memory!.copy()
            } else {
                throw TokenizerError.memoryEmpty
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
                try await token.tokenize(trimmedExpression)
                needsEvaluation = true
            } catch {
                throw error
            }
        }
        if needsEvaluation {
            await token.shuntingYard()
            display = await token.evaluatePostfix()
        }
    }

    public func asString(_ expression: String) async -> String {
        if display.precision == 0 {
            assert(false)
        }
        do { try await add(expression) } catch { return error.localizedDescription }
        var result = String(display.R.toString())
        if result == "-0.0" { result = "0.0"}
        return result
    }
    public func asDouble(_ expression: String) async -> Double {
        if display.precision == 0 {
            assert(false)
        }
        do { try await add(expression) } catch { return Double.nan }
        return display.R.toDouble()
    }
}
