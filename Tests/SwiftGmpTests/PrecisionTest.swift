import Testing
import SwiftGmp

@Test func testPrecisionTest() {
    let calculator = Calculator(precision: 5)
    #expect(calculator.evaluateString("10000 + 3 - 10000").string == "3")
    #expect(calculator.evaluateString("1000000000000000 + 3 - 1000000000000000").string != "3")
    #expect(calculator.evaluateString("1000000000000000000000000000000000000 + 3 - 1000000000000000000000000000000000000").string != "3")
    calculator.setPrecision(newPrecision: 20)
    #expect(calculator.evaluateString("10000 + 3 - 10000").string == "3")
    #expect(calculator.evaluateString("1000000000000000 + 3 - 1000000000000000").string == "3")
    #expect(calculator.evaluateString("1000000000000000000000000000000000000 + 3 - 1000000000000000000000000000000000000").string != "3")
    calculator.setPrecision(newPrecision: 50)
    #expect(calculator.evaluateString("10000 + 3 - 10000").string == "3")
    #expect(calculator.evaluateString("1000000000000000 + 3 - 1000000000000000").string == "3")
    #expect(calculator.evaluateString("1000000000000000000000000000000000000 + 3 - 1000000000000000000000000000000000000").string == "3")
}
