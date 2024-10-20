//
//  representationTest.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 20.10.24.
//

import Testing
import SwiftGmp

@Test func representationTest() {
    var output: String
    var R = Representation()
    output = R.roundString("0.9999")
    print(output)
    
    print(R.roundString("57"))    // Output: "6"
    print(R.roundString("53"))    // Output: "5"
    print(R.roundString("9999"))  // Output: "1"
    print(R.roundString("9993"))  // Output: "999"
    print(R.roundString("1000"))  // Output: "1"
    print(R.roundString("43210")) // Output: "4321"
    
    
    let calculator = Calculator(precision: 20)
    let font = AppleFont.systemFont(ofSize: 30, weight: .regular)
    calculator.press(DigitOperation.one)
    calculator.press(DigitOperation.dot)
    calculator.press(DigitOperation.three)
    
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 100)
    #expect(R.debugDescription == "1.3")
    
    calculator.press(EqualOperation.equal)
    #expect(R.debugDescription == "1.3")
}
