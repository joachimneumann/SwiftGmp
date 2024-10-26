// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 100)
//    var swiftGmp: SwiftGmp
//    var raw: Raw
//    var display: Display
//    let L = 10
    
//    calculator.evaluateString("1e10")
//    #expect(calculator.string == "1.0e10")
    

    calculator.evaluateString("55555555.1234567890")
    #expect(calculator.string == "55555555.1")




//    let calculator = Calculator(precision: 100)
//    calculator.maxOutputLength = 100
//    var R = Representation()
//    var RString: String
//    let font = AppleFont.monospacedSystemFont(ofSize: 40, weight: .regular)
//
//    calculator.evaluateString("1.1 * 1")
//    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
//    RString = R.debugDescription
//    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
//    #expect(Double(RString)!.similar(to: 1.1))
//
//    calculator.maxOutputLength = 10
//    calculator.press(ClearOperation.clear)
//    calculator.press(DigitOperation.one)
//    calculator.press(TwoOperantOperation.div)
//    calculator.press(DigitOperation.seven)
//    calculator.press(EqualOperation.equal)
//    let x = calculator.string
//    let xx = "s"
}
