//
//  separatorsTest.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 26.10.2024.
//

import Testing
@testable import SwiftGmp

class separatorsTest {
    var calculator = Calculator(precision: 20)
    var raw: Raw = Raw(mantissa: "0", exponent: 0, length: 10)
    var display: Display = Display(raw: Raw(mantissa: "0", exponent: 0, length: 10))

    struct S {
        let decimalSeparator: DecimalSeparator
        let separateGroups: Bool
    }
    
    @Test func x() {
        
        calculator.evaluateString("10000.3")
        display = Display(raw: calculator.raw, displayLength: raw.length, decimalSeparator: DecimalSeparator.dot, separateGroups: true)
        #expect(display.string == "10,000.3")

//        calculator.evaluateString("10000")
//        display = Display(raw: calculator.raw, displayLength: raw.length, decimalSeparator: DecimalSeparator.dot, separateGroups: true)
//        #expect(display.string == "10,000")
//
//        calculator.evaluateString("10000000")
//        display = Display(raw: calculator.raw, displayLength: raw.length, decimalSeparator: DecimalSeparator.dot, separateGroups: true)
//        #expect(display.string == "10,000,000")
//
//        calculator.evaluateString("100000000")
//        display = Display(raw: calculator.raw, displayLength: raw.length, decimalSeparator: DecimalSeparator.dot, separateGroups: true)
//        #expect(display.string == "1.0e8")
    }
    
    
    @Test(arguments: [
        S(decimalSeparator: .comma, separateGroups: true),
        S(decimalSeparator: .comma, separateGroups: false),
        S(decimalSeparator: .dot, separateGroups: true),
        S(decimalSeparator: .dot, separateGroups: false)])
    func multipleSeparatorsTest(s: S) {
        var string: String
        var gr: String
        var de: String
        var expectation: String
        
        calculator.evaluateString("10000")
        display = Display(raw: calculator.raw, displayLength: raw.length, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups)
        string = display.string
        
        de = s.decimalSeparator.string
        if s.separateGroups {
            gr = s.decimalSeparator.groupString
        } else {
            gr = ""
        }
        print(string)
        expectation = "10" + gr + "000"
        #expect(string == expectation)
        string = string.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
        string = string.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
        #expect(string == "10000")
        
        calculator.evaluateString("9999.3999999999999999999999999999999")
        display = Display(raw: calculator.raw, displayLength: raw.length, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups)
        string = display.string
        
        de = s.decimalSeparator.string
        if s.separateGroups {
            gr = s.decimalSeparator.groupString
        } else {
            gr = ""
        }
        print(string)
        expectation = "9" + gr + "999" + de + "4"
        #expect(string == expectation)
        string = string.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
        string = string.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
        #expect(string == "9999.4")
    }
        ////    let calculator = Calculator(precision: 20)
        ////    var RString: String
        ////
        ////    calculator.evaluateString("9995.9999999999999999999999999999999")
        ////    calculator.R.setRaw(calculator.raw!, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        //////    R = Representation(raw: calculator.raw!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
        ////    RString = calculator.display.string
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

