//
//  Calculator.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 27.09.24.
//

public class Calculator {
    public enum Digit: String {
        case null  = "0"
        case one   = "1"
        case two   = "2"
        case three = "3"
        case four  = "4"
        case five  = "5"
        case six   = "6"
        case seven = "7"
        case eight = "8"
        case nine  = "9"
        case dot  = "."
    }
    
    private var token: Token
    var display: Number
    private var precision: Int
    private var memory: Number?
    public var maxOutputLength: Int? = nil
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

    public func press(_ digit: Digit) {
        if display.isStr {
            display.appendDigit(digit)
        }
    }
    public func press(_ constant: SwiftGmpConstantOperation) {
        token.newToken(constant)
        token.numberExpected = false
        display.swiftGmp.execute(constant)
    }
    
    public func press(_ inPlace: SwiftGmpInplaceOperation) {
        token.tokens.append(.inPlace(inPlace))
        token.numberExpected = false
//        token.shuntingYard()
//        display = token.evaluatePostfix()
    }
    
    public func press(_ twoOperant: SwiftGmpTwoOperantOperation) {
        token.tokens.append(.twoOperant(twoOperant))
        token.numberExpected = true
//        evaluate()
    }
    
    public func evaluate() {
        token.shuntingYard()
        display = token.evaluatePostfix()
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
        var result = R.leftRight(maxOutputLength: maxOutputLength ?? Int.max).string
        if result == "-0.0" { result = "0.0"}
        return result
    }
    
    public func asDouble(_ expression: String) -> Double {
        let R = evaluate(expression)
        if R.error != nil { return Double.nan }
        return R.double
    }
    
    public func asLR(_ expression: String, maxOutputLength: Int) -> LR {
        let R = evaluate(expression)
        if let error = R.error { return LR(error, nil) }
        return (R.leftRight(maxOutputLength: maxOutputLength))
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
