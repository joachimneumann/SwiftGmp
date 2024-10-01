import Testing
import SwiftGmp

@Test func testPrecisionTest() {
    let calculator = Calculator(precision: 5)
    #expect(calculator.asString("10000 + 3 - 10000") == "3.0")
    #expect(calculator.asString("1000000000000000 + 3 - 1000000000000000") != "3.0")
    #expect(calculator.asString("1000000000000000000000000000000000000 + 3 - 1000000000000000000000000000000000000") != "3.0")
    calculator.setPrecision(newPrecision: 20)
    #expect(calculator.asString("10000 + 3 - 10000") == "3.0")
    #expect(calculator.asString("1000000000000000 + 3 - 1000000000000000") == "3.0")
    #expect(calculator.asString("1000000000000000000000000000000000000 + 3 - 1000000000000000000000000000000000000") != "3.0")
    calculator.setPrecision(newPrecision: 50)
    #expect(calculator.asString("10000 + 3 - 10000") == "3.0")
    #expect(calculator.asString("1000000000000000 + 3 - 1000000000000000") == "3.0")
    #expect(calculator.asString("1000000000000000000000000000000000000 + 3 - 1000000000000000000000000000000000000") == "3.0")
}
