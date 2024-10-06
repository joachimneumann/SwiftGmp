import Testing
@testable import SwiftGmp

@Test func separatorTest() {
    let calculator = Calculator(precision: 20)

    var x = calculator.evaluateString("10000.1")
    #expect(x.string == "10000.1")

//    x
    calculator.decimalSeparator = .comma
    x = calculator.evaluateString("10000.1")
    #expect(x.string == "10000,1")

    calculator.decimalSeparator = .dot
    calculator.groupingSeparator = .comma
    x = calculator.evaluateString("10000.1")
    #expect(x.string == "10,000.1")

    calculator.decimalSeparator = .comma
    calculator.groupingSeparator = .dot
    x = calculator.evaluateString("10000.1")
    #expect(x.string == "10.000,1")
}
