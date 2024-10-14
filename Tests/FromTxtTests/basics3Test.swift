// Note: This file is automatically generated.
//       It will be overwritten sooner or later.

import Testing
import SwiftGmp

@Test func basics3Test() {
    let calculator = Calculator(precision: 20)

    #expect(calculator.evaluateString("sqr(4.0)").string == "16")
    #expect(calculator.evaluateString("sqr(2.0)").string == "4")
    #expect(calculator.evaluateString("cubed(5.0)").string == "125")
    #expect(calculator.evaluateString("cubed(2.0)").string == "8")
    var temp: Double
    temp = calculator.asDouble("exp(1.0)")
    #expect(temp.similarTo(2.7183))
    temp = calculator.asDouble("exp(2.0)")
    #expect(temp.similarTo(7.3891))
    #expect(calculator.evaluateString("exp10(1.0)").string == "10")
    #expect(calculator.evaluateString("exp10(2.0)").string == "100")
    #expect(calculator.evaluateString("1.0 ±").string == "-1")
    #expect(calculator.evaluateString("-1.0 ±").string == "1")
    #expect(calculator.evaluateString("rez(2.0)").string == "0.5")
    #expect(calculator.evaluateString("rez(4.0)").string == "0.25")
    #expect(calculator.evaluateString("fac(5.0)").string == "120")
    #expect(calculator.evaluateString("fac(3.0)").string == "6")
    #expect(calculator.evaluateString("0").string == "0")
    temp = calculator.asDouble("pi")
    #expect(temp.similarTo(3.1416))
    temp = calculator.asDouble("e")
    #expect(temp.similarTo(2.7183))
    #expect(calculator.evaluateString("abs(-3.0)").string == "3")
    #expect(calculator.evaluateString("sqrt(9.0)").string == "3")
    temp = calculator.asDouble("sqrt3(8.0)")
    #expect(temp.similarTo(2))
    temp = calculator.asDouble("sqrt(2.0)")
    #expect(temp.similarTo(1.4142))
    temp = calculator.asDouble("zeta(3.0)")
    #expect(temp.similarTo(1.2021))
    #expect(calculator.evaluateString("ln(1.0)").string == "0")
    temp = calculator.asDouble("ln(2.0)")
    #expect(temp.similarTo(0.6931))
    #expect(calculator.evaluateString("log10(10.0)").string == "1")
    #expect(calculator.evaluateString("log10(100.0)").string == "2")
    #expect(calculator.evaluateString("log2(8.0)").string == "3")
    #expect(calculator.evaluateString("log2(16.0)").string == "4")
}
