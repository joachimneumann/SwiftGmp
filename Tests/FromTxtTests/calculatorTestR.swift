// Note: This file is automatically generated.
//       It will be overwritten sooner or later.

import Testing
import SwiftGmp

@Test func calculatorTestR() {
    let calculator = Calculator(precision: 20)
    var R = Representation()
    var RString: String
    let font = AppleFont.monospacedSystemFont(ofSize: 40, weight: .regular)

    calculator.evaluateString("1 + 2 * 3")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
    #expect(Double(RString)!.similar(to: 7))

    calculator.evaluateString("sin(sin(1))")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
    #expect(Double(RString)!.similar(to: 0.745624141665))

    calculator.evaluateString("4.5")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
    #expect(Double(RString)!.similar(to: 4.5))

// clearing memory, no change to the display
    calculator.evaluateString("sqr(2)")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
    #expect(Double(RString)!.similar(to: 4))

    calculator.evaluateString("sqr(2) 5")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
    #expect(Double(RString)!.similar(to: 5))

    calculator.evaluateString("10 %")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
    #expect(Double(RString)!.similar(to: 0.1))

}
