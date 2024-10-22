//
//  representationTest.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 20.10.24.
//

import Testing
import SwiftGmp
import AppKit

@Test func representationTest() {
    let R = Representation()
    #expect(R.roundString("57")    == ("6", false))
    #expect(R.roundString("53")    == ("5", false))
    #expect(R.roundString("9999")  == ("1", true))
    #expect(R.roundString("9993")  == ("999", false))
    #expect(R.roundString("1000")  == ("1", false))
    #expect(R.roundString("43210") == ("4321", false))
}

struct S {
    let decimalSeparator: DecimalSeparator
    let separateGroups: Bool
}

@Test(arguments: [
//    S(decimalSeparator: .comma, separateGroups: true),
//    S(decimalSeparator: .comma, separateGroups: false),
//    S(decimalSeparator: .dot, separateGroups: true),
    S(decimalSeparator: .dot, separateGroups: false)])
func separatorTest(s: S) {
    let calculator = Calculator(precision: 20)
    var R = Representation()
    var RString: String
    let font = AppleFont.monospacedSystemFont(ofSize: 40, weight: .regular)

    //test 888 / 9 = "98.6666 66667"
    
    
    calculator.evaluateString("9995.9999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
    #expect(Double(RString)!.similar(to: 9996))


    calculator.evaluateString("0.999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
    #expect(Double(RString)!.similar(to: 1.0))
    
    calculator.evaluateString("9999.3999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
    #expect(Double(RString)!.similar(to: 9999.4))

    calculator.evaluateString("9999.3999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    //print("X: \(s.decimalSeparator) \(s.decimalSeparator.groupString) \(RString)")
    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
    #expect(Double(RString)!.similar(to: 9999.4))

    calculator.evaluateString("99.999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
    #expect(Double(RString)!.similar(to: 100.0))

    calculator.evaluateString("0.000999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: DecimalSeparator.dot.string)
    #expect(Double(RString)!.similar(to: 0.001))

    calculator.evaluateString("-0.999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
    #expect(Double(RString)!.similar(to: -1.0))

    calculator.evaluateString("-99.999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
    #expect(Double(RString)!.similar(to: -100.0))

    calculator.evaluateString("-0.000999999999999999999999999999999")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
    #expect(Double(RString)!.similar(to: -0.001))
    
    calculator.evaluateString("1.0823232337111381")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
    #expect(Double(RString)!.similar(to: 1.0823232337111381))
        
    calculator.evaluateString("1.0 * 1.0823232337111381")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
    #expect(Double(RString)!.similar(to: 1.0823232337111381))
    
    calculator.press(DigitOperation.one)
    calculator.press(DigitOperation.dot)
    calculator.press(DigitOperation.three)
    
    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0, width: 300)
    #expect(R.debugDescription == "1\(s.decimalSeparator.character)3")
    
    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0, width: 300)

    calculator.press(EqualOperation.equal)
    #expect(R.debugDescription == "1\(s.decimalSeparator.character)3")


}
