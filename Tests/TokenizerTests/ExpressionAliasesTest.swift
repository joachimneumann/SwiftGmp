import Testing
@testable import SwiftGmp

@Test(arguments: [
    ("pi", Double.pi),
    ("π", Double.pi),
    ("10+pi", 10 + Double.pi),
    ("10+π", 10 + Double.pi),
    ("sqrt(pi)", Double.pi.squareRoot()),
    ("sqrt(π)", Double.pi.squareRoot()),
    ("2^3", 8.0),
    ("2 powxy 3", 8.0),
    ("2^3*4", 32.0),
    ("2*3^4", 162.0),
    ("2^(3+1)", 16.0),
    ("sqrt(pi^2)", Double.pi),
    ("sqrt(π powxy 2)", Double.pi)
])
func expressionAliases(expression: String, expected: Double) {
    let calculator = Calculator(precision: 100)
    calculator.evaluateString(expression)
    #expect(calculator.double.similar(to: expected))
}

@Test func expressionAliasesPreserveOperationLabels() throws {
    let tokenizer = Token(precision: 100)
    let pi = try tokenizer.stringToPressCommands("pi")
    #expect(pi.count == 1)
    #expect(pi.first?.isEqual(to: ConstantOperation.pi) == true)

    let power = try tokenizer.stringToPressCommands("2^3")
    #expect(power.count == 3)
    #expect(power[1].isEqual(to: TwoOperantOperation.powxy))
    #expect(ConstantOperation.pi.getRawValue() == "π")
    #expect(TwoOperantOperation.powxy.getRawValue() == "powxy")
}
