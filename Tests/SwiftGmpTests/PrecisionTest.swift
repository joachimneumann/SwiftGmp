import Testing
@testable import SwiftGmp

@Test func precisionTest() {
    let calculator = Calculator(precision: 5)
    let XS = "10000"
    let M = "1000000000000000"
    let L = "1000000000000000000000000000000000000"
    let XL = "100000000000000000000000000000000000000000000000000000000000000000"
    
    calculator.evaluateString(XS + " + 3 - " + XS)
    #expect(calculator.string == "3")
    calculator.evaluateString(M + " + 3 - " + M)
    #expect(calculator.string == "3")
    calculator.evaluateString(L + " + 3 - " + L)
    #expect(calculator.string != "3")
    calculator.evaluateString(XL + " + 3 - " + XL)
    #expect(calculator.string != "3")

    calculator.setPrecision(newPrecision: 20)
    calculator.evaluateString(XS + " + 3 - " + XS)
    #expect(calculator.string == "3")
    calculator.evaluateString(M + " + 3 - " + M)
    #expect(calculator.string == "3")
    calculator.evaluateString(L + " + 3 - " + L)
    #expect(calculator.string == "3")
    calculator.evaluateString(XL + " + 3 - " + XL)
    #expect(calculator.string != "3")

    calculator.setPrecision(newPrecision: 50)
    calculator.evaluateString(XS + " + 3 - " + XS)
    #expect(calculator.string == "3")
    calculator.evaluateString(M + " + 3 - " + M)
    #expect(calculator.string == "3")
    calculator.evaluateString(L + " + 3 - " + L)
    #expect(calculator.string == "3")
    calculator.evaluateString(XL + " + 3 - " + XL)
    #expect(calculator.string == "3")


    calculator.monoFontDisplay.displayWidth = 10
    calculator.press(ClearOperation.clear)
    calculator.press(DigitOperation.one)
    calculator.press(TwoOperantOperation.div)
    calculator.press(DigitOperation.seven)
    calculator.press(EqualOperation.equal)
    #expect(calculator.string == "0.14285714")
}
