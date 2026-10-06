import Testing
@testable import SwiftGmp

@Test func replacementPreservesPendingOperation() {
    let calculator = Calculator(precision: 1000, displayWidth: 1000)
    calculator.press(DigitOperation.two)
    calculator.press(TwoOperantOperation.add)
    #expect(calculator.replaceCurrentNumber("3"))
    #expect(calculator.double == 3)
    #expect(calculator.pendingOperators.contains { $0.isEqual(to: TwoOperantOperation.add) })
    calculator.press(EqualOperation.equal)
    #expect(calculator.double == 5)
}

@Test func replacementReplacesEnteredOperandAndResult() {
    let calculator = Calculator(precision: 1000)
    calculator.press(DigitOperation.two)
    calculator.press(TwoOperantOperation.add)
    calculator.press(DigitOperation.nine)
    #expect(calculator.replaceCurrentNumber("3"))
    calculator.press(EqualOperation.equal)
    #expect(calculator.double == 5)
    #expect(calculator.replaceCurrentNumber("-4.5"))
    #expect(calculator.double == -4.5)
    calculator.press(DigitOperation.seven)
    #expect(calculator.double == 7)
}

@Test func invalidReplacementLeavesCalculationUnchanged() {
    let calculator = Calculator(precision: 1000)
    calculator.press(DigitOperation.two)
    calculator.press(TwoOperantOperation.add)
    for invalid in ["", "hello", "2+3", "NaN", "inf", "1e", "1.2.3", "1,2", "0xFF", "3\n4"] {
        #expect(!calculator.replaceCurrentNumber(invalid))
        #expect(calculator.double == 2)
        #expect(calculator.pendingOperators.count == 1)
    }
    #expect(calculator.replaceCurrentNumber("3"))
    calculator.press(EqualOperation.equal)
    #expect(calculator.double == 5)
}

@Test func replacementAcceptsDecimalAndScientificNotation() {
    let calculator = Calculator(precision: 1000)
    for (number, expected) in [("+3", 3.0), ("-.5", -0.5), ("42.", 42), ("  -1.25E+3\n", -1250), ("1e-6", 0.000001), ("0", 0)] {
        #expect(calculator.replaceCurrentNumber(number))
        #expect(calculator.double == expected)
    }
}

@Test func replacementKeepsHighPrecisionAndMemory() {
    let calculator = Calculator(precision: 1000, displayWidth: 1000)
    calculator.press(DigitOperation.seven)
    calculator.press(MemoryOperation.addToM)
    #expect(calculator.replaceCurrentNumber("1e500"))
    calculator.press(TwoOperantOperation.add)
    calculator.press(DigitOperation.one)
    calculator.press(EqualOperation.equal)
    calculator.press(TwoOperantOperation.sub)
    #expect(calculator.replaceCurrentNumber("1e500"))
    calculator.press(EqualOperation.equal)
    #expect(calculator.double == 1)
    calculator.press(MemoryOperation.recallM)
    #expect(calculator.double == 7)
}

@Test func replacementInsideParentheses() {
    let calculator = Calculator(precision: 1000)
    calculator.press(DigitOperation.two)
    calculator.press(TwoOperantOperation.mul)
    calculator.press(ParenthesisOperation.left)
    #expect(calculator.replaceCurrentNumber("3"))
    calculator.press(TwoOperantOperation.add)
    #expect(calculator.replaceCurrentNumber("4"))
    calculator.press(ParenthesisOperation.right)
    calculator.press(EqualOperation.equal)
    #expect(calculator.double == 14)
}
