// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    var swiftGmp: SwiftGmp
    var raw: Raw
    swiftGmp = SwiftGmp(withString: "1.1", bits: 100)
    raw = swiftGmp.raw(digits: 10)
    #expect(raw.mantissa == "11")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "1.1999", bits: 100)
    raw = swiftGmp.raw(digits: 10)
    #expect(raw.mantissa == "11999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "1.199999999999999999", bits: 100)
    raw = swiftGmp.raw(digits: 10)
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "9.9999", bits: 100)
    raw = swiftGmp.raw(digits: 10)
    #expect(raw.mantissa == "99999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "9.99999", bits: 100)
    raw = swiftGmp.raw(digits: 10)
    #expect(raw.mantissa == "999999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "9.999999", bits: 100)
    raw = swiftGmp.raw(digits: 10)
    #expect(raw.mantissa == "9999999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "9.9999999", bits: 100)
    raw = swiftGmp.raw(digits: 10)
    #expect(raw.mantissa == "99999999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "9.99999999", bits: 100)
    raw = swiftGmp.raw(digits: 10)
    #expect(raw.mantissa == "999999999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "9.99999999", bits: 100)
    raw = swiftGmp.raw(digits: 10)
    #expect(raw.mantissa == "999999999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "9.999999999", bits: 100)
    raw = swiftGmp.raw(digits: 10)
    #expect(raw.mantissa == "9999999999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "9.9999999999", bits: 100)
    raw = swiftGmp.raw(digits: 10)
    #expect(raw.mantissa == "1")
    #expect(raw.exponent == 1)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "9.9999999999999999", bits: 100)
    raw = swiftGmp.raw(digits: 10)
    #expect(raw.mantissa == "1")
    #expect(raw.exponent == 1)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "1112223334.999", bits: 100)
    raw = swiftGmp.raw(digits: 10)
    #expect(raw.mantissa == "1112223335")
    #expect(raw.exponent == 9)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "11122233344.999", bits: 100)
    raw = swiftGmp.raw(digits: 10)
    #expect(raw.mantissa == "1112223334")
    #expect(raw.exponent == 10)
    #expect(raw.isNegative == false)

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
