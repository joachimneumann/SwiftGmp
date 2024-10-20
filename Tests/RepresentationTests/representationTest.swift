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
    let calculator = Calculator(precision: 20)

    var R = Representation()
    var RString: String
    let font = AppleFont.monospacedSystemFont(ofSize: 40, weight: .regular)

    calculator.evaluateString("1.0823232337111381")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
    #expect(Double(RString)!.similar(to: 1.0823232337111381))


    calculator.evaluateString("1.0 * 1.0823232337111381")
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 300)
    RString = R.debugDescription
    RString = RString.replacingOccurrences(of: DecimalSeparator.comma.rawValue, with: "")
    #expect(Double(RString)!.similar(to: 1.0823232337111381))

    
    
    
//    var output: String
//    var R = Representation()
//    output = R.roundString("0.9999")
//    print(output)
    
    print(R.roundString("57"))    // Output: "6"
    print(R.roundString("53"))    // Output: "5"
    print(R.roundString("9999"))  // Output: "1"
    print(R.roundString("9993"))  // Output: "999"
    print(R.roundString("1000"))  // Output: "1"
    print(R.roundString("43210")) // Output: "4321"
    
    
    calculator.press(DigitOperation.one)
    calculator.press(DigitOperation.dot)
    calculator.press(DigitOperation.three)
    
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 100)
    #expect(R.debugDescription == "1.3")

    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 100)

    calculator.press(EqualOperation.equal)
    #expect(R.debugDescription == "1.3")
}
