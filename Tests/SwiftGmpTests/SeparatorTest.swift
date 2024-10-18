import Testing
@testable import SwiftGmp

@Test func separatorTest() {
    let calculator = Calculator(precision: 20)

    var x = calculator.evaluateString("10000.1")
    #expect(x.string == "10000.1")

    calculator.decimalSeparator = .comma
    x = calculator.evaluateString("10000.1")
    #expect(calculator.localizedString == "10000,1")
    #expect(calculator.string == "10000.1")
    #expect(calculator.localizedString == "10000,1")

    calculator.decimalSeparator = .dot
    calculator.separateGroups = true
    x = calculator.evaluateString("10000.1")
    #expect(calculator.localizedString == "10,000.1")
    #expect(calculator.string == "10000.1")
    #expect(calculator.localizedString == "10,000.1")

    calculator.decimalSeparator = .comma
    calculator.separateGroups = true
    x = calculator.evaluateString("10000.1")
    #expect(calculator.localizedString == "10.000,1")
    #expect(calculator.string == "10000.1")
    #expect(calculator.localizedString == "10.000,1")
}
