import Testing
import SwiftGmp

@Test func precisionTest() {
    let calculator = Calculator(precision: 5)
    var result: String
    let XS = "10000"
    let M = "1000000000000000"
    let L = "1000000000000000000000000000000000000"
    let XL = "100000000000000000000000000000000000000000000000000000000000000000"
    
    result = calculator.evaluateString(XS + " + 3 - " + XS).string
    #expect(result == "3")
    result = calculator.evaluateString(M + " + 3 - " + M).string
    #expect(result == "3")
    result = calculator.evaluateString(L + " + 3 - " + L).string
    #expect(result != "3")
    result = calculator.evaluateString(XL + " + 3 - " + XL).string
    #expect(result != "3")

    calculator.setPrecision(newPrecision: 20)
    result = calculator.evaluateString(XS + " + 3 - " + XS).string
    #expect(result == "3")
    result = calculator.evaluateString(M + " + 3 - " + M).string
    #expect(result == "3")
    result = calculator.evaluateString(L + " + 3 - " + L).string
    #expect(result == "3")
    result = calculator.evaluateString(XL + " + 3 - " + XL).string
    #expect(result != "3")

    calculator.setPrecision(newPrecision: 50)
    result = calculator.evaluateString(XS + " + 3 - " + XS).string
    #expect(result == "3")
    result = calculator.evaluateString(M + " + 3 - " + M).string
    #expect(result == "3")
    result = calculator.evaluateString(L + " + 3 - " + L).string
    #expect(result == "3")
    result = calculator.evaluateString(XL + " + 3 - " + XL).string
    #expect(result == "3")

    calculator.maxOutputLength = 10
    calculator.press(ClearOperation.clear)
    calculator.press(DigitOperation.one)
    calculator.press(TwoOperantOperation.div)
    calculator.press(DigitOperation.seven)
    calculator.press(EqualOperation.equal)
    #expect(calculator.lr.string == "0.14285714")
}
