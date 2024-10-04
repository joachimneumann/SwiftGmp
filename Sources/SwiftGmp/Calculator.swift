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

    private func evaluate(_ expression: String) -> Representation {
        if display.precision == 0 {
            assert(false)
        }
        do { try add(expression) } catch { return Representation(error: error.localizedDescription) }
        return display.R
    }
    
    public func asString(_ expression: String) -> String {
        let R = evaluate(expression)
        var result = String(R.toString())
        if result == "-0.0" { result = "0.0"}
        return result
    }
    
    public func asDouble(_ expression: String) -> Double {
        let R = evaluate(expression)
        if R.error != nil { return Double.nan }
        return R.toDouble()
    }
    
    public func asLR(_ expression: String) -> (String, String?) {
        let R = evaluate(expression)
        if let error = R.error { return (error, nil) }
        return (R.LR())
    }
}

extension Double {
    public func similarTo(_ other: Double, precision: Double = 1e-3) -> Bool {
        if abs(self) > 1000 {
            return abs(self - other) <= precision * abs(self)
        } else {
            return abs(self - other) <= precision
        }
    }
}
