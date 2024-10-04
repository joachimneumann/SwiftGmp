import Testing
import SwiftGmp

@Test func testPrecisionTest() async {
    let calculator = Calculator(precision: 5)
    #expect((await calculator.asString("10000 + 3 - 10000")) == "3")
    #expect((await calculator.asString("1000000000000000 + 3 - 1000000000000000")) != "3")
    #expect((await calculator.asString("1000000000000000000000000000000000000 + 3 - 1000000000000000000000000000000000000")) != "3")
    await calculator.setPrecision(newPrecision: 20)
    #expect((await calculator.asString("10000 + 3 - 10000")) == "3")
    #expect((await calculator.asString("1000000000000000 + 3 - 1000000000000000")) == "3")
    #expect((await calculator.asString("1000000000000000000000000000000000000 + 3 - 1000000000000000000000000000000000000")) != "3")
    await calculator.setPrecision(newPrecision: 50)
    #expect((await calculator.asString("10000 + 3 - 10000")) == "3")
    #expect((await calculator.asString("1000000000000000 + 3 - 1000000000000000")) == "3")
    #expect((await calculator.asString("1000000000000000000000000000000000000 + 3 - 1000000000000000000000000000000000000")) == "3")
}
