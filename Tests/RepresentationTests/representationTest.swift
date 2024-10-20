//
//  representationTest.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 20.10.24.
//

import Testing
import SwiftGmp

@Test func representationTest() {
    let calculator = Calculator(precision: 20)
    let font = AppleFont.systemFont(ofSize: 30, weight: .regular)
    var R: Representation
    calculator.press(DigitOperation.zero)
    calculator.press(DigitOperation.dot)
    calculator.press(DigitOperation.three)
    R = Representation(mantissaExponent: calculator.mantissaExponent!, proportionalFont: font, monoSpacedFont: font, decimalSeparator: DecimalSeparator.dot, separateGroups: true, ePadding: 0.0, width: 100)
    #expect(R.debugDescription == "0.3")
    
    calculator.press(EqualOperation.equal)
    #expect(R.debugDescription == "0.3")
}
