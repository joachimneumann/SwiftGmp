import Testing
import SwiftGmp

@Test func precisionTest() {
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
    
    calculator.maxOutputLength = 10
    calculator.press(ClearOperation.clear)
    calculator.press(DigitOperation.one)
    calculator.press(TwoOperantOperation.div)
    calculator.press(DigitOperation.seven)
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "0.14285714")
}
