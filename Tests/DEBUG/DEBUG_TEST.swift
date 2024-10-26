// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    var swiftGmp: SwiftGmp
    var raw: Raw
    var display: Display
    let L = 10
    
    swiftGmp = SwiftGmp(withString: "1.1", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "11")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)
    #expect(display.type == .floatLargerThanOne)
    #expect(display.left == "1.1")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "12", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 1)
    #expect(raw.isNegative == false)
    #expect(display.type == .integer)
    #expect(display.left == "12")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "120", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 2)
    #expect(raw.isNegative == false)
    #expect(display.type == .integer)
    #expect(display.left == "120")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "1_200", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 3)
    #expect(raw.isNegative == false)
    #expect(display.type == .integer)
    #expect(display.left == "1200")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "12_000", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 4)
    #expect(raw.isNegative == false)
    #expect(display.type == .integer)
    #expect(display.left == "12000")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "120_000", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 5)
    #expect(raw.isNegative == false)
    #expect(display.type == .integer)
    #expect(display.left == "120000")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "1_200_000", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 6)
    #expect(raw.isNegative == false)
    #expect(display.type == .integer)
    #expect(display.left == "1200000")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "12_000_000", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 7)
    #expect(raw.isNegative == false)
    #expect(display.type == .integer)
    #expect(display.left == "12000000")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "120_000_000", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 8)
    #expect(raw.isNegative == false)
    #expect(display.type == .integer)
    #expect(display.left == "120000000")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "1_200_000_000", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 9)
    #expect(raw.isNegative == false)
    #expect(display.type == .integer)
    #expect(display.left == "1200000000")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "12_000_000_000", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 10)
    #expect(raw.isNegative == false)
    #expect(display.type == .unknown)
    #expect(display.left == "0")
    #expect(display.right == nil)
        
    swiftGmp = SwiftGmp(withString: "120000000000000000000000", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 23)
    #expect(raw.isNegative == false)
    #expect(display.type == .unknown)
    #expect(display.left == "0")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "-12", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 1)
    #expect(raw.isNegative == true)
    #expect(display.type == .integer)
    #expect(display.left == "-12")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "-120_000_000", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 8)
    #expect(raw.isNegative == true)
    #expect(display.type == .integer)
    #expect(display.left == "-120000000")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "-1_200_000_000", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 9)
    #expect(raw.isNegative == true)
    #expect(display.type == .unknown)
    #expect(display.left == "0")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "-12_000_000_000", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 10)
    #expect(raw.isNegative == true)
    #expect(display.type == .unknown)
    #expect(display.left == "0")
    #expect(display.right == nil)
        
    swiftGmp = SwiftGmp(withString: "1.1999", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "11999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)
    #expect(display.type == .floatLargerThanOne)
    #expect(display.left == "1.1999")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "1.199999999999999999", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "12")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)
    #expect(display.type == .floatLargerThanOne)
    #expect(display.left == "1.2")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "9.9999", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "99999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)
    #expect(display.type == .floatLargerThanOne)
    #expect(display.left == "9.9999")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "9.99999", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "999999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)
    #expect(display.type == .floatLargerThanOne)
    #expect(display.left == "9.99999")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "9.999999", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "9999999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)
    #expect(display.type == .floatLargerThanOne)
    #expect(display.left == "9.999999")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "9.9999999", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "99999999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)
    #expect(display.type == .floatLargerThanOne)
    #expect(display.left == "9.9999999")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "9.99999999", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "999999999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)
    #expect(display.type == .floatLargerThanOne)
    #expect(display.left == "9.99999999")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "9.99999999", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "999999999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)
    #expect(display.type == .floatLargerThanOne)
    #expect(display.left == "9.99999999")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "9.999999999", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "9999999999")
    #expect(raw.exponent == 0)
    #expect(raw.isNegative == false)
    #expect(display.type == .floatLargerThanOne)
    #expect(display.left == "10.0")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "9.9999999999", bits: 100)
    raw = swiftGmp.raw(digits: L)
    display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
    #expect(raw.mantissa == "1")
    #expect(raw.exponent == 1)
    #expect(raw.isNegative == false)
    #expect(display.type == .floatLargerThanOne)
    #expect(display.left == "10.0")
    #expect(display.right == nil)

    swiftGmp = SwiftGmp(withString: "9.9999999999999999", bits: 100)
    raw = swiftGmp.raw(digits: L)
    #expect(raw.mantissa == "1")
    #expect(raw.exponent == 1)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "1112223334.999", bits: 100)
    raw = swiftGmp.raw(digits: L)
    #expect(raw.mantissa == "1112223335")
    #expect(raw.exponent == 9)
    #expect(raw.isNegative == false)

    swiftGmp = SwiftGmp(withString: "11122233344.999", bits: 100)
    raw = swiftGmp.raw(digits: L)
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
