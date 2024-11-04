//
//  separatorsTest.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 26.10.2024.
//

import Testing
@testable import SwiftGmp

class separatorsTest {
    var calculator = Calculator(precision: 20, separator: Separator(separatorType: .comma, groups: true))
    var raw: Raw = Raw(mantissa: "0", exponent: 0, isNegative: false, canBeInteger: true, isError: false)
    var monoFontDisplay: MonoFontDisplay = MonoFontDisplay(displayWidth: 10)

    struct S {
        let decimalSeparator: Separator.SeparatorType
        let separateGroups: Bool
    }
    
    @Test func simple() {
        calculator.separator = Separator(separatorType: .comma, groups: false)
        calculator.evaluateString("8 powyx 3 / 16 sqrty 81 sqrty 9 + 5 ^ 3")
        #expect(calculator.string == "6661,09409")

        calculator.separator = Separator(separatorType: .comma, groups: true)
        #expect(calculator.string == "6.661,0940")

        calculator.separator = Separator(separatorType: .dot, groups: false)
        calculator.evaluateString("8 powyx 3 / 16 sqrty 81 sqrty 9 + 5 ^ 3")
        #expect(calculator.string == "6661.09409")

        calculator.separator = Separator(separatorType: .dot, groups: true)
        #expect(calculator.string == "6,661.0940")

        calculator.evaluateString("153.4 - 153")
        #expect(calculator.string == "0.4")

        calculator.evaluateString("11111.3")
        monoFontDisplay.update(raw: calculator.raw, separator: Separator(separatorType: .comma, groups: true))
        #expect(monoFontDisplay.string == "11.111,3")

        calculator.evaluateString("10000")
        #expect(calculator.string == "10,000")

        calculator.evaluateString("10000000")
        #expect(calculator.string == "10,000,000")

        calculator.separator = Separator(separatorType: .comma, groups: true)
        calculator.evaluateString("100000000")
        #expect(calculator.string == "1,0e8")
    }
    
    
    @Test(arguments: [
        S(decimalSeparator: .comma, separateGroups: true),
        S(decimalSeparator: .comma, separateGroups: false),
        S(decimalSeparator: .dot, separateGroups: true),
        S(decimalSeparator: .dot, separateGroups: false)])
    func multipleSeparatorsTest(s: S) {
        var string: String
        var expectation: String
        
        calculator.evaluateString("10000")
        let separator = Separator(separatorType: s.decimalSeparator, groups: s.separateGroups)
        monoFontDisplay.update(raw: calculator.raw, separator: separator)
        string = monoFontDisplay.string
        
        print(string)
        expectation = "10" + (separator.groupString ?? "") + "000"
        #expect(string == expectation)
        string = string.replacingOccurrences(of: (separator.groupString ?? ""), with: "")
        string = string.replacingOccurrences(of: separator.string, with: ".")
        #expect(string == "10000")
        
        calculator.evaluateString("9999.3999999999999999999999999999999")
        monoFontDisplay.update(raw: calculator.raw, separator: separator)
        string = monoFontDisplay.string
        
        print(string)
        expectation = "9" + (separator.groupString ?? "") + "999" + separator.string + "4"
        #expect(string == expectation)
        string = string.replacingOccurrences(of: (separator.groupString ?? ""), with: "")
        string = string.replacingOccurrences(of: separator.string, with: ".")
        #expect(string == "9999.4")
        
        calculator.press(ClearOperation.clear)
        calculator.press(DigitOperation.one)
        calculator.press(DigitOperation.one)
        calculator.press(DigitOperation.one)
        calculator.press(DigitOperation.one)
        calculator.press(DigitOperation.one)
        calculator.press(DigitOperation.dot)
        calculator.press(DigitOperation.three)
        monoFontDisplay.update(raw: calculator.raw, separator: separator)
        string = monoFontDisplay.string
        expectation = "11" + (separator.groupString ?? "") + "111" + separator.string + "3"
        print(string + " " + expectation)
        #expect(string == expectation)
    
        calculator.press(EqualOperation.equal)
        monoFontDisplay.update(raw: calculator.raw, separator: separator)
        string = monoFontDisplay.string
        print(string + " " + expectation)
        #expect(string == expectation)

        calculator.evaluateString("1e1234")
        monoFontDisplay.update(raw: calculator.raw, separator: separator)
        string = monoFontDisplay.string
        expectation = "1\(separator.string)0e1" + (separator.groupString ?? "") + "234"
        print(string + " " + expectation)
        #expect(string == expectation)
  }
    
        ////    let calculator = Calculator(precision: 20)
        ////    var RString: String
        ////
        ////    calculator.evaluateString("9995.9999999999999999999999999999999")
        ////    calculator.R.setRaw(calculator.raw!, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        //////    R = Representation(raw: calculator.raw!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        ////    RString = calculator.string
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
        ////    #expect(RString == "9996")
        ////    #expect(Double(RString)!.similar(to: 9996))
        //
        //
        ////    calculator.evaluateString("0.999999999999999999999999999999")
        ////    R = Representation(raw: calculator.raw!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        ////    RString = R.debugDescription
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
        ////    #expect(Double(RString)!.similar(to: 1.0))
        ////
        ////    calculator.evaluateString("9999.3999999999999999999999999999999")
        ////    R = Representation(raw: calculator.raw!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        ////    RString = R.debugDescription
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
        ////    #expect(Double(RString)!.similar(to: 9999.4))
        ////
        ////    calculator.evaluateString("9999.3999999999999999999999999999999")
        ////    R = Representation(raw: calculator.raw!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        ////    RString = R.debugDescription
        ////    //print("X: \(s.decimalSeparator) \(s.decimalSeparator.groupString) \(RString)")
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
        ////    #expect(Double(RString)!.similar(to: 9999.4))
        ////
        ////    calculator.evaluateString("99.999999999999999999999999999999")
        ////    R = Representation(raw: calculator.raw!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        ////    RString = R.debugDescription
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
        ////    #expect(Double(RString)!.similar(to: 100.0))
        ////
        ////    calculator.evaluateString("0.000999999999999999999999999999999")
        ////    R = Representation(raw: calculator.raw!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        ////    RString = R.debugDescription
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: DecimalSeparator.dot.string)
        ////    #expect(Double(RString)!.similar(to: 0.001))
        ////
        ////    calculator.evaluateString("-0.999999999999999999999999999999")
        ////    R = Representation(raw: calculator.raw!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        ////    RString = R.debugDescription
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
        ////    #expect(Double(RString)!.similar(to: -1.0))
        ////
        ////    calculator.evaluateString("-99.999999999999999999999999999999")
        ////    R = Representation(raw: calculator.raw!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        ////    RString = R.debugDescription
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
        ////    #expect(Double(RString)!.similar(to: -100.0))
        ////
        ////    calculator.evaluateString("-0.000999999999999999999999999999999")
        ////    R = Representation(raw: calculator.raw!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        ////    RString = R.debugDescription
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
        ////    #expect(Double(RString)!.similar(to: -0.001))
        ////
        ////    calculator.evaluateString("1.0823232337111381")
        ////    R = Representation(raw: calculator.raw!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        ////    RString = R.debugDescription
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
        ////    #expect(Double(RString)!.similar(to: 1.0823232337111381))
        ////
        ////    calculator.evaluateString("1.0 * 1.0823232337111381")
        ////    R = Representation(raw: calculator.raw!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        ////    RString = R.debugDescription
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
        ////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
        ////    #expect(Double(RString)!.similar(to: 1.0823232337111381))
        ////
        ////    calculator.press(DigitOperation.one)
        ////    calculator.press(DigitOperation.dot)
        ////    calculator.press(DigitOperation.three)
        ////
        ////    R = Representation(raw: calculator.raw!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        ////    #expect(R.debugDescription == "1\(s.decimalSeparator.character)3")
        ////
        ////    R = Representation(raw: calculator.raw!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        ////
        ////    calculator.press(EqualOperation.equal)
        ////    #expect(R.debugDescription == "1\(s.decimalSeparator.character)3")
        //
        //
//    }
    
}

