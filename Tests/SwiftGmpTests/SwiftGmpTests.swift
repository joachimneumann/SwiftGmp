import Testing
@testable import SwiftGmp

@Test func anotherTest() {
    let nan = SwiftGmp(bits: 20)
    #expect(!nan.isValid)
    #expect(nan.debugDescription == "nan")
    #expect(nan.toDouble().debugDescription == Double.nan.debugDescription) // nan
    
    let x = SwiftGmp(withString: "1", bits: 20)
    #expect(x.toDouble() == 1)
    let x1 = SwiftGmp(withString: "-2", bits: 20)
    let x2 = SwiftGmp(withString: "-3", bits: 20)
    
    #expect(x1.toDouble() == -2)
    x1.execute(.abs)
    #expect(x1.toDouble() == 2)

    x1.execute(.mul, other: x2)
    #expect(x1.toDouble() == -6)
    x1.execute(.mul, other: x2)
    #expect(x1.toDouble() == 18)

    x1.execute(.add, other: x2)
    #expect(x1.toDouble() == 15)
    
    x2.execute(.rez)
    #expect(x2.isApproximately(-0.33333))
    
    let calculator = Calculator(precision: 20)
    var R = Representation()
    var RString: String
    let font = AppleFont.monospacedSystemFont(ofSize: 40, weight: .regular)
    
    calculator.evaluateString("0.999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
    #expect(Double(RString)!.similar(to: 1.0))

    calculator.evaluateString("99.999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
    #expect(Double(RString)!.similar(to: 100.0))

    calculator.evaluateString("0.000999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
    #expect(Double(RString)!.similar(to: 0.001))

    calculator.evaluateString("-0.999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
    #expect(Double(RString)!.similar(to: -1.0))

    calculator.evaluateString("-99.999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
    #expect(Double(RString)!.similar(to: -100.0))

    calculator.evaluateString("-0.000999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
    #expect(Double(RString)!.similar(to: -0.001))
}

