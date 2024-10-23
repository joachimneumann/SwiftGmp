//
//  representationTest.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 20.10.24.
//

import Testing
@testable import SwiftGmp

class RepresentationTests {
    
    var calculator: Calculator = Calculator(precision: 20)
    var RString: String = ""
    
    @Test func smallFloatTest() {
        calculator.evaluateString("0.0000000001")//00000000000000000000000000000000000000000000000000000000000000000000001")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1.0e-10")
    }
    
    @Test func incrementAbsStringTest() {
        #expect(calculator.R.incrementAbsString("33") == "34")
        #expect(calculator.R.incrementAbsString("39") == "40")
        #expect(calculator.R.incrementAbsString("0") == "1")
        #expect(calculator.R.incrementAbsString("") == "1")
        #expect(calculator.R.incrementAbsString("9") == "10")
        #expect(calculator.R.incrementAbsString("99") == "100")
        #expect(calculator.R.incrementAbsString("994") == "995")
        #expect(calculator.R.incrementAbsString("-44") == "-45")
    }
    
    @Test func IntegerTest() {
        calculator.evaluateString("1234")
        RString = calculator.R.debugDescription
        #expect(RString == "1234")

        calculator.evaluateString("12345")
        RString = calculator.R.debugDescription
        #expect(RString == "12345")

        calculator.evaluateString("123456")
        RString = calculator.R.debugDescription
        #expect(RString == "123456")

        calculator.evaluateString("1234567")
        RString = calculator.R.debugDescription
        #expect(RString == "1234567")

        calculator.evaluateString("12345678")
        RString = calculator.R.debugDescription
        #expect(RString == "12345678")

        calculator.evaluateString("123456789")
        RString = calculator.R.debugDescription
        #expect(RString == "123456789")

        calculator.evaluateString("1234567890")
        RString = calculator.R.debugDescription
        #expect(RString == "1234567890")

        calculator.evaluateString("3333378901")
        RString = calculator.R.debugDescription
        #expect(RString == "3333378901")

        calculator.evaluateString("33333789012")
        RString = calculator.R.debugDescription
        #expect(RString == "3.33337e10")

        calculator.evaluateString("6789")
        RString = calculator.R.debugDescription
        #expect(RString == "6789")

        calculator.evaluateString("67890")
        RString = calculator.R.debugDescription
        #expect(RString == "67890")

        calculator.evaluateString("678901")
        RString = calculator.R.debugDescription
        #expect(RString == "678901")

        calculator.evaluateString("6789012")
        RString = calculator.R.debugDescription
        #expect(RString == "6789012")

        calculator.evaluateString("67890123")
        RString = calculator.R.debugDescription
        #expect(RString == "67890123")

        calculator.evaluateString("678901234")
        RString = calculator.R.debugDescription
        #expect(RString == "678901234")

        calculator.evaluateString("6789012345")
        RString = calculator.R.debugDescription
        #expect(RString == "6789012345")

        calculator.evaluateString("67890123456")
        RString = calculator.R.debugDescription
        #expect(RString == "6.78901e10")

        calculator.evaluateString("678901234567")
        RString = calculator.R.debugDescription
        #expect(RString == "6.78901e11")

        calculator.evaluateString("6789012345678")
        RString = calculator.R.debugDescription
        #expect(RString == "6.78901e12")

        calculator.evaluateString("100")
        RString = calculator.R.debugDescription
        #expect(RString == "100")
        
        
        calculator.evaluateString("99.9999999999999")
        RString = calculator.R.debugDescription
        #expect(RString == "100")
        
        calculator.evaluateString("100")
        RString = calculator.R.debugDescription
        #expect(RString == "100")
        
        calculator.evaluateString("-100")
        RString = calculator.R.debugDescription
        #expect(RString == "-100")
        
        calculator.evaluateString("-99.9999999999999")
        RString = calculator.R.debugDescription
        #expect(RString == "-100")
        
        calculator.evaluateString("99.9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
        RString = calculator.R.debugDescription
        #expect(RString == "100")
        
        calculator.evaluateString("99.4999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "9.95e1")
        
        calculator.evaluateString("-99.4999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "-9.95e1")
        
        calculator.evaluateString("99.9919999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "9.9992e1")
        
        calculator.evaluateString("1234567.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1234567")
        
        calculator.evaluateString("12345678.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "12345678")
        
        calculator.evaluateString("123456789.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "123456789")
        calculator.evaluateString("1234567890.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1234567890")
        
        calculator.evaluateString("12345678901.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1.23456e10")
        
        calculator.evaluateString("123456789012.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1.23456e11")
        
        calculator.evaluateString("1234567890123.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1.23456e12")
        
        calculator.evaluateString("12345678901234.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1.23456e13")
        
        calculator.evaluateString("123456789012345.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1.23456e14")
        
        calculator.evaluateString("1234567890123456.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1.23456e15")
        
        calculator.evaluateString("1234.5678901234567890123456789012345678901234567890123456789012345678901234567890")
        
        
        calculator.evaluateString("1234567.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1234568")
        
        calculator.evaluateString("12345678.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "12345679")
        
        calculator.evaluateString("123456789.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "123456790")
        calculator.evaluateString("1234567890.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1234567891")
        
        calculator.evaluateString("12345678901.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1.23456e10")
        
        calculator.evaluateString("123456789012.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1.23456e11")
        
        calculator.evaluateString("1234567890123.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1.23456e12")
        
        calculator.evaluateString("12345678901234.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1.23456e13")
        
        calculator.evaluateString("123456789012345.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1.23456e14")
        
        calculator.evaluateString("1234567890123456.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "1.23456e15")
        
        calculator.evaluateString("-1234567.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "-1234568")
        
        calculator.evaluateString("-12345678.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "-12345679")
        
        calculator.evaluateString("-123456789.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "-123456790")
        
        calculator.evaluateString("-1234567890.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "-1.23456e9")
        
        calculator.evaluateString("-12345678901.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "-1.2345e10")
        
        calculator.evaluateString("-123456789012.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "-1.2345e11")
        
        calculator.evaluateString("-1234567890123.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "-1.2345e12")
        
        calculator.evaluateString("-12345678901234.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "-1.2345e13")
        
        calculator.evaluateString("-123456789012345.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "-1.2345e14")
        
        calculator.evaluateString("-1234567890123456.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        calculator.R.setMantissaExponent(calculator.mantissaExponent!)
        RString = calculator.R.debugDescription
        #expect(RString == "-1.2345e15")
    }
}

//struct S {
//    let decimalSeparator: DecimalSeparator
//    let separateGroups: Bool
//}

//@Test(arguments: [
////    S(decimalSeparator: .comma, separateGroups: true),
////    S(decimalSeparator: .comma, separateGroups: false),
////    S(decimalSeparator: .dot, separateGroups: true),
//    S(decimalSeparator: .dot, separateGroups: false)])
//func separatorTest(s: S) {
//    let calculator = Calculator(precision: 20)
//    var RString: String
//
//    calculator.evaluateString("9995.9999999999999999999999999999999")
//    calculator.R.setMantissaExponent(calculator.mantissaExponent!, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
////    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
//    RString = calculator.R.debugDescription
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
//    #expect(RString == "9996")
//    #expect(Double(RString)!.similar(to: 9996))


//    calculator.evaluateString("0.999999999999999999999999999999")
//    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
//    RString = R.debugDescription
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
//    #expect(Double(RString)!.similar(to: 1.0))
//    
//    calculator.evaluateString("9999.3999999999999999999999999999999")
//    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
//    RString = R.debugDescription
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
//    #expect(Double(RString)!.similar(to: 9999.4))
//
//    calculator.evaluateString("9999.3999999999999999999999999999999")
//    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
//    RString = R.debugDescription
//    //print("X: \(s.decimalSeparator) \(s.decimalSeparator.groupString) \(RString)")
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
//    #expect(Double(RString)!.similar(to: 9999.4))
//
//    calculator.evaluateString("99.999999999999999999999999999999")
//    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
//    RString = R.debugDescription
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
//    #expect(Double(RString)!.similar(to: 100.0))
//
//    calculator.evaluateString("0.000999999999999999999999999999999")
//    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
//    RString = R.debugDescription
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: DecimalSeparator.dot.string)
//    #expect(Double(RString)!.similar(to: 0.001))
//
//    calculator.evaluateString("-0.999999999999999999999999999999")
//    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
//    RString = R.debugDescription
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
//    #expect(Double(RString)!.similar(to: -1.0))
//
//    calculator.evaluateString("-99.999999999999999999999999999999")
//    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
//    RString = R.debugDescription
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
//    #expect(Double(RString)!.similar(to: -100.0))
//
//    calculator.evaluateString("-0.000999999999999999999999999999999")
//    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
//    RString = R.debugDescription
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
//    #expect(Double(RString)!.similar(to: -0.001))
//    
//    calculator.evaluateString("1.0823232337111381")
//    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
//    RString = R.debugDescription
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
//    #expect(Double(RString)!.similar(to: 1.0823232337111381))
//        
//    calculator.evaluateString("1.0 * 1.0823232337111381")
//    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
//    RString = R.debugDescription
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
//    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
//    #expect(Double(RString)!.similar(to: 1.0823232337111381))
//    
//    calculator.press(DigitOperation.one)
//    calculator.press(DigitOperation.dot)
//    calculator.press(DigitOperation.three)
//    
//    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
//    #expect(R.debugDescription == "1\(s.decimalSeparator.character)3")
//    
//    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
//
//    calculator.press(EqualOperation.equal)
//    #expect(R.debugDescription == "1\(s.decimalSeparator.character)3")


//}
