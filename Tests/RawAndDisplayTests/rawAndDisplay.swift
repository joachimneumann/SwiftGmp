//
//  rawAndDisplay.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 20.10.24.
//

import Testing
@testable import SwiftGmp

class rawAndDisplay {
    var swiftGmp: SwiftGmp = SwiftGmp(withString: "0", bits: 100)
    var raw: Raw = Raw(mantissa: "0", exponent: 0)
    var display: Display = Display(raw: Raw(mantissa: "0", exponent: 0), displayLength: 10, decimalSeparator: ".")
    let L = 10

//    let debug = true
    let debug = false

    @Test func specialTests() {
        //        swiftGmp = SwiftGmp(withString: "100000000000000000000", bits: 100)
        //        raw = swiftGmp.raw(digits: L)
        //        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        //        #expect(raw.mantissa == "1")
        //        #expect(raw.exponent == 20)
        //        #expect(raw.isNegative == false)
        //        #expect(display.type == .scientifiNotation)
        //        #expect(display.left == "1.0e20")
        //        #expect(display.right == nil)
    }

    @Test func integer() {
        if debug { return }
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
        #expect(display.left == "9.99999999")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "9.9999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "99999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.99999999")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "9.99999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "999999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.99999999")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "9.999999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == 1)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "10")
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
        
        swiftGmp = SwiftGmp(withString: "9.9999999999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == 1)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "10")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "111222333.99999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "111222334")
        #expect(raw.exponent == 8)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "111222334")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "111222333.9999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "111222334")
        #expect(raw.exponent == 8)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "111222334")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "111222333.999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "111222333999")
        #expect(raw.exponent == 8)
        #expect(raw.isNegative == false)
        #expect(display.type == .unknown)
        #expect(display.left == "0")
        #expect(display.right == nil)
        
        
        swiftGmp = SwiftGmp(withString: "1112223334.99999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1112223335")
        #expect(raw.exponent == 9)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "1112223335")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "11122233344.99999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "11122233345")
        #expect(raw.exponent == 10)
        #expect(raw.isNegative == false)
        #expect(display.type == .unknown)
        #expect(display.left == "0")
        #expect(display.right == nil)
    }
    
    @Test func floatLargerThan_1() {
        if debug { return }
        swiftGmp = SwiftGmp(withString: "1.1", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "11")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "1.1")
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
        #expect(display.left == "9.99999999")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "9.9999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "99999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.99999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "11122233.999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "11122233999")
        #expect(raw.exponent == 7)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "11122233.9")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "111222333.999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "111222333999")
        #expect(raw.exponent == 8)
        #expect(raw.isNegative == false)
        #expect(display.type == .unknown)
        #expect(display.left == "0")
        #expect(display.right == nil)
    }
    
    @Test func negativeFloatLargerThan_1() {
        if debug { return }
        swiftGmp = SwiftGmp(withString: "-1.1", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "11")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-1.1")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-1.1999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "11999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-1.1999")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-1.199999999999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-1.2")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-9.9999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "99999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.9999")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-9.99999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.99999")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-9.999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "9999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.999999")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-9.9999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "99999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.9999999")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-9.99999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.9999999")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-9.99999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.9999999")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-9.999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "9999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.9999999")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-9.9999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "99999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.9999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-11122233.999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "11122233999")
        #expect(raw.exponent == 7)
        #expect(raw.isNegative == true)
        #expect(display.type == .unknown)
        #expect(display.left == "0")
        #expect(display.right == nil)
    }
    
    @Test func floatSmallerThan_1() {
        if debug { return }
        swiftGmp = SwiftGmp(withString: "0.1", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -1)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.1")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "0.01", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -2)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.01")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "0.001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -3)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.001")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "0.0001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -4)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.0001")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "0.00001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -5)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.00001")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "0.000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -6)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.000001")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "0.0000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -7)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.0000001")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "0.00000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -8)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.00000001")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "0.000000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -9)
        #expect(raw.isNegative == false)
        #expect(display.type == .unknown)
        #expect(display.left == "0")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "0.0000000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -10)
        #expect(raw.isNegative == false)
        #expect(display.type == .unknown)
        #expect(display.left == "0")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "0.9999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "9999")
        #expect(raw.exponent == -1)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.9999")
        #expect(display.right == nil)
    }
    
    @Test func negativeFloatSmallerThan_1() {
        if debug { return }
        swiftGmp = SwiftGmp(withString: "-0.1", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -1)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.1")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-0.01", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -2)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.01")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-0.001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -3)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.001")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-0.0001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -4)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.0001")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-0.00001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -5)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.00001")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-0.000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -6)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.000001")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-0.0000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -7)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.0000001")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-0.00000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -8)
        #expect(raw.isNegative == true)
        #expect(display.type == .unknown)
        #expect(display.left == "0")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-0.000000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -9)
        #expect(raw.isNegative == true)
        #expect(display.type == .unknown)
        #expect(display.left == "0")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-0.0000000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -10)
        #expect(raw.isNegative == true)
        #expect(display.type == .unknown)
        #expect(display.left == "0")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "-0.9999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display = Display(raw: raw, displayLength: L, decimalSeparator: ".")
        #expect(raw.mantissa == "9999")
        #expect(raw.exponent == -1)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.9999")
        #expect(display.right == nil)
    }
    
    
//        var mantissaExponent: MantissaExponent

//        calculator.evaluateString("0.0000099999999999999999")
//        #expect(calculator.R.debugDescription == "0.00001")
//
//        calculator.evaluateString("0.001")
//        #expect(calculator.R.debugDescription == "0.001")
//        calculator.evaluateString("0.0001")
//        #expect(calculator.R.debugDescription == "0.0001")
//        calculator.evaluateString("0.00001")
//        #expect(calculator.R.debugDescription == "0.00001")
//        calculator.evaluateString("0.000001")
//        #expect(calculator.R.debugDescription == "0.000001")
//        calculator.evaluateString("0.0000001")
//        #expect(calculator.R.debugDescription == "0.0000001")
//        calculator.evaluateString("0.00000001")
//        #expect(calculator.R.debugDescription == "0.00000001")
//        calculator.evaluateString("0.000000001")
//        #expect(calculator.R.debugDescription == "1.0e-9")
//        calculator.evaluateString("0.0000000001")
//        #expect(calculator.R.debugDescription == "1.0e-10")
//        calculator.evaluateString("0.00000000001")
//        #expect(calculator.R.debugDescription == "1.0e-11")
//        calculator.evaluateString("0.000000000001")
//        #expect(calculator.R.debugDescription == "1.0e-12")
////
//        calculator.evaluateString("0.000999999999999999999999999")
//        #expect(calculator.R.debugDescription == "0.001")
//        calculator.evaluateString("0.0000999999999999999999999999")
//        #expect(calculator.R.debugDescription == "0.0001")
//        calculator.evaluateString("0.00000999999999999999999999999")
//        #expect(calculator.R.debugDescription == "0.00001")
//        calculator.evaluateString("0.000000999999999999999999999999")
//        #expect(calculator.R.debugDescription == "0.000001")
//        calculator.evaluateString("0.0000000999999999999999999999999")
//        #expect(calculator.R.debugDescription == "0.0000001")
//        calculator.evaluateString("0.00000000999999999999999999999999")
//        #expect(calculator.R.debugDescription == "0.00000001")
//        calculator.evaluateString("0.000000000999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.0e-9")
//        calculator.evaluateString("0.0000000000999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.0e-10")
//        calculator.evaluateString("0.00000000000999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.0e-11")
//        calculator.evaluateString("0.000000000000999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.0e-12")
//
//        calculator.evaluateString("0.00000999999999999")
//        #expect(calculator.R.debugDescription == "0.00001")
//    }
    
//    @Test func correctNumericalErrorTest() {
//        if debug { return }
//        var mantissaExponent: MantissaExponent
//        mantissaExponent = MantissaExponent(mantissa: "99999999999999999", exponent: 1)
//        mantissaExponent.correctNumericalErrors(width: 10)
//        #expect(mantissaExponent.mantissa == "1")
//        #expect(mantissaExponent.exponent == 2)
//        #expect(!mantissaExponent.isNegative)
//
//        mantissaExponent = MantissaExponent(mantissa: "499999999999999999", exponent: 1)
//        mantissaExponent.correctNumericalErrors(width: 10)
//        #expect(mantissaExponent.mantissa == "5")
//        #expect(mantissaExponent.exponent == 1)
//        #expect(!mantissaExponent.isNegative)
//
//        mantissaExponent = MantissaExponent(mantissa: "111499999999999999999", exponent: 4)
//        mantissaExponent.correctNumericalErrors(width: 10)
//        #expect(mantissaExponent.mantissa == "1115")
//        #expect(mantissaExponent.exponent == 4)
//        #expect(!mantissaExponent.isNegative)
//        
//        mantissaExponent = MantissaExponent(mantissa: "-99999999999999999", exponent: 1)
//        mantissaExponent.correctNumericalErrors(width: 10)
//        #expect(mantissaExponent.mantissa == "1")
//        #expect(mantissaExponent.exponent == 2)
//        #expect(mantissaExponent.isNegative)
//
//        mantissaExponent = MantissaExponent(mantissa: "-499999999999999999", exponent: 1)
//        mantissaExponent.correctNumericalErrors(width: 10)
//        #expect(mantissaExponent.mantissa == "5")
//        #expect(mantissaExponent.exponent == 1)
//        #expect(mantissaExponent.isNegative)
//
//        mantissaExponent = MantissaExponent(mantissa: "-111499999999999999999", exponent: 4)
//        mantissaExponent.correctNumericalErrors(width: 10)
//        #expect(mantissaExponent.mantissa == "1115")
//        #expect(mantissaExponent.exponent == 4)
//        #expect(mantissaExponent.isNegative)
//
//        calculator.evaluateString("-99.9999999999999")
//        #expect(calculator.R.debugDescription == "-100")
//
//
//
////        calculator.evaluateString("100000000000000000000000000000000000000000000000000000000000000000000000000000000")
////        #expect(calculator.R.debugDescription == "1.0e80")
//        
////        calculator.evaluateString("0.00000001")
////        #expect(calculator.R.debugDescription == "0.00000001")
////        calculator.evaluateString("0.0000000099999999")
////        #expect(calculator.R.debugDescription == "0.00000001")
//
////        calculator.evaluateString("0.000000001")
////        #expect(calculator.R.debugDescription == "1.0e-9")
////        calculator.evaluateString("0.00000000099999999")
////        #expect(calculator.R.debugDescription == "1.0e-9")
//        
////        calculator.evaluateString("100000000000000000000000000000000000000000000000000000000000000000000000000000000")
////        #expect(calculator.R.debugDescription == "1.0e80")
//    }
//    
//
////    @Test func getBigFloatTest() {
////        if debug { return }
////        var s: String
////        var res: String?
////
////        s = "3339999999"
////        res = s.getBigFloat(exponent: 0)
////        #expect(res == "3.339999999")
////
////        res = s.getBigFloat(exponent: 1)
////        #expect(res == "33.39999999")
////
////        res = s.getBigFloat(exponent: 2)
////        #expect(res! == "334.0")
////
////        res = s.getBigFloat(exponent: 3)
////        #expect(res! == "3340.0")
////
////        res = s.getBigFloat(exponent: 5)
////        #expect(res! == "334000.0")
////
////        res = s.getBigFloat(exponent: 11)
////        #expect(res! == "333999999900.0")
////    }
////
////    @Test func getSmallFloatTest() {
////        if debug { return }
////        var s: String
////        var res: String?
////
////        s = "0.003339999999"
////        res = s.getSmallFloat(exponent: -1)
////        #expect(res == "3.339999999")
////
////        res = s.getSmallFloat(exponent: -1)
////        #expect(res == "33.39999999")
////
////        res = s.getSmallFloat(exponent: -2)
////        #expect(res! == "334.0")
////
////        res = s.getSmallFloat(exponent: -3)
////        #expect(res! == "3340.0")
////
////        res = s.getSmallFloat(exponent: -5)
////        #expect(res! == "334000.0")
////
////        res = s.getSmallFloat(exponent: -11)
////        #expect(res! == "333999999900.0")
////    }
//
//    
//    @Test func floatTest() {
//        if debug { return }
//        calculator.evaluateString("1234.5678901234567890123456789012345678901234567890123456789012345678901234567890")
//        #expect(calculator.R.debugDescription == "1234.56789")
//    
//        calculator.evaluateString("1234567.9")
//        #expect(calculator.R.debugDescription == "1234567.9")
//        
//        calculator.evaluateString("1234567.99")
//        #expect(calculator.R.debugDescription == "1234567.99")
//        
//        calculator.evaluateString("1234567.9991")
//        #expect(calculator.R.debugDescription == "1234568")
//        
//        calculator.evaluateString("1234567.9999")
//        #expect(calculator.R.debugDescription == "1234568")
//
//        calculator.evaluateString("1234567.999")
//        #expect(calculator.R.debugDescription == "1234568")
//
//        calculator.evaluateString("1234567.998")
//        #expect(calculator.R.debugDescription == "1234567.99")
//
//        calculator.evaluateString("10.0")
//        #expect(calculator.R.debugDescription == "10")
//
//        calculator.evaluateString("1.0")
//        #expect(calculator.R.debugDescription == "1")
//
//        calculator.evaluateString("0.1")
//        #expect(calculator.R.debugDescription == "0.1")
//
//        calculator.evaluateString("0.01")
//        #expect(calculator.R.debugDescription == "0.01")
//
//        calculator.evaluateString("0.0001")
//        #expect(calculator.R.debugDescription == "0.0001")
//
//        calculator.evaluateString("0.00001")
//        #expect(calculator.R.debugDescription == "0.00001")
//
//        calculator.evaluateString("0.000001")
//        #expect(calculator.R.debugDescription == "0.000001")
//
//        calculator.evaluateString("0.0000001")
//        #expect(calculator.R.debugDescription == "0.0000001")
//        calculator.evaluateString("0.000000099999")
//        #expect(calculator.R.debugDescription == "0.0000001")
//
//        calculator.evaluateString("0.00000001")
//        #expect(calculator.R.debugDescription == "0.00000001")
//        calculator.evaluateString("0.000000009999")
//        #expect(calculator.R.debugDescription == "0.00000001")
//
//        calculator.evaluateString("0.000000001")
//        #expect(calculator.R.debugDescription == "1.0e-9")
//        calculator.evaluateString("0.00000000099999999")
//        #expect(calculator.R.debugDescription == "1.0e-9")
//
//        calculator.evaluateString("0.0000000001")
//        #expect(calculator.R.debugDescription == "1.0e-10")
//        calculator.evaluateString("0.00000000009989999")
//        #expect(calculator.R.debugDescription == "1.0e-10")
//
//        calculator.evaluateString("0.00000000001")
//        #expect(calculator.R.debugDescription == "1.0e-11")
//
//        calculator.evaluateString("0.000000000001")
//        #expect(calculator.R.debugDescription == "1.0e-12")
//
//        calculator.evaluateString("0.001")
//        #expect(calculator.R.debugDescription == "0.001")
//
//        calculator.evaluateString("0.001")
//        #expect(calculator.R.debugDescription == "0.001")
//
//        calculator.evaluateString("0.0999999999999")
//        #expect(calculator.R.debugDescription == "0.1")
//
//        calculator.evaluateString("0.00000999999999999")
//        #expect(calculator.R.debugDescription == "0.00001")
//
//
//        calculator.evaluateString("5.1")
//        #expect(calculator.R.debugDescription == "5.1")
//
//        calculator.evaluateString("1.0")
//        #expect(calculator.R.debugDescription == "1")
//
//        calculator.evaluateString("55.1")
//        #expect(calculator.R.debugDescription == "55.1")
//
//        calculator.evaluateString("1234.5678901234567890123456789012345678901234567890123456789012345678901234567890")
//        #expect(calculator.R.debugDescription == "1234.56789")
//
//        calculator.evaluateString("-1234.5678901234567890123456789012345678901234567890123456789012345678901234567890")
//        #expect(calculator.R.debugDescription == "-1234.5678")
//
//        calculator.evaluateString("-1234567.9")
//        #expect(calculator.R.debugDescription == "-1234567.9")
//        
//        calculator.evaluateString("-1234567.99")
//        #expect(calculator.R.debugDescription == "-1234567.9")
//        
//        calculator.evaluateString("-1234567.999")
//        #expect(calculator.R.debugDescription == "-1234568")
//        
//        calculator.evaluateString("-1234567.9999")
//        #expect(calculator.R.debugDescription == "-1234568")
//
//        calculator.evaluateString("-1234567.9999")
//        #expect(calculator.R.debugDescription == "-1234568")
//
//        calculator.evaluateString("-1234567.998")
//        #expect(calculator.R.debugDescription == "-1234567.9")
//
//        calculator.evaluateString("-10.0")
//        #expect(calculator.R.debugDescription == "-10")
//
//        calculator.evaluateString("-1.0")
//        #expect(calculator.R.debugDescription == "-1")
//
//        calculator.evaluateString("-0.1")
//        #expect(calculator.R.debugDescription == "-0.1")
//
//        calculator.evaluateString("-0.01")
//        #expect(calculator.R.debugDescription == "-0.01")
//
//        calculator.evaluateString("-0.0001")
//        #expect(calculator.R.debugDescription == "-0.0001")
//
//        calculator.evaluateString("-0.00001")
//        #expect(calculator.R.debugDescription == "-0.00001")
//
//        calculator.evaluateString("-0.000001")
//        #expect(calculator.R.debugDescription == "-0.000001")
//
//        calculator.evaluateString("-0.0000001")
//        #expect(calculator.R.debugDescription == "-0.0000001")
//        calculator.evaluateString("-0.000000099999")
//        #expect(calculator.R.debugDescription == "-0.0000001")
//
//        calculator.evaluateString("-0.00000001")
//        #expect(calculator.R.debugDescription == "0.00000001")
//        #expect(calculator.R.debugDescription == "-1.0e-8")
//        calculator.evaluateString("-0.000000009999")
//        #expect(calculator.R.debugDescription == "-1.0e-8")
//
//        calculator.evaluateString("-0.000000001")
//        #expect(calculator.R.debugDescription == "-1.0e-9")
//        calculator.evaluateString("-0.00000000099999")
//        #expect(calculator.R.debugDescription == "-1.0e-9")
//
//        calculator.evaluateString("-0.0000000001")
//        #expect(calculator.R.debugDescription == "-1.0e-10")
//        calculator.evaluateString("-0.000000000099899")
//        #expect(calculator.R.debugDescription == "-1.0e-10")
//
//        calculator.evaluateString("-0.00000000001")
//        #expect(calculator.R.debugDescription == "-1.0e-11")
//
//        calculator.evaluateString("-0.000000000001")
//        #expect(calculator.R.debugDescription == "-1.0e-12")
//
//        calculator.evaluateString("-0.001")
//        #expect(calculator.R.debugDescription == "-0.001")
//
//        calculator.evaluateString("-0.001")
//        #expect(calculator.R.debugDescription == "-0.001")
//
//        calculator.evaluateString("-0.0999999999999")
//        #expect(calculator.R.debugDescription == "-0.1")
//
//        calculator.evaluateString("-0.00000999999999999")
//        #expect(calculator.R.debugDescription == "-0.00001")
//
//
//        calculator.evaluateString("-5.1")
//        #expect(calculator.R.debugDescription == "-5.1")
//
//        calculator.evaluateString("-1.0")
//        #expect(calculator.R.debugDescription == "-1")
//
//        calculator.evaluateString("-55.1")
//        #expect(calculator.R.debugDescription == "-55.1")
//    }
//    
////    @Test func smallFloatTest() {
////        if debug { return }
//////        calculator.evaluateString("0.0000000001")//00000000000000000000000000000000000000000000000000000000000000000000001")
//////        #expect(calculator.R.debugDescription == "1.0e-10")
////    }
//    
//    @Test func integerTest() {
//        if debug { return }
//        calculator.evaluateString("1234")
//        #expect(calculator.R.debugDescription == "1234")
//
//        calculator.evaluateString("12345")
//        #expect(calculator.R.debugDescription == "12345")
//
//        calculator.evaluateString("123456")
//        #expect(calculator.R.debugDescription == "123456")
//
//        calculator.evaluateString("1234567")
//        #expect(calculator.R.debugDescription == "1234567")
//
//        calculator.evaluateString("12345678")
//        #expect(calculator.R.debugDescription == "12345678")
//
//        calculator.evaluateString("123456789")
//        #expect(calculator.R.debugDescription == "123456789")
//
//        calculator.evaluateString("1234567890")
//        #expect(calculator.R.debugDescription == "1234567890")
//
//        calculator.evaluateString("3333378901")
//        #expect(calculator.R.debugDescription == "3333378901")
//
//        calculator.evaluateString("33333789012")
//        #expect(calculator.R.debugDescription == "3.33337e10")
//
//        calculator.evaluateString("6789")
//        #expect(calculator.R.debugDescription == "6789")
//
//        calculator.evaluateString("67890")
//        #expect(calculator.R.debugDescription == "67890")
//
//        calculator.evaluateString("678901")
//        #expect(calculator.R.debugDescription == "678901")
//
//        calculator.evaluateString("6789012")
//        #expect(calculator.R.debugDescription == "6789012")
//
//        calculator.evaluateString("67890123")
//        #expect(calculator.R.debugDescription == "67890123")
//
//        calculator.evaluateString("678901234")
//        #expect(calculator.R.debugDescription == "678901234")
//
//        calculator.evaluateString("6789012345")
//        #expect(calculator.R.debugDescription == "6789012345")
//
//        calculator.evaluateString("6789012345.999999")
//        #expect(calculator.R.debugDescription == "6789012346")
//
//        calculator.evaluateString("6789012345.99999")
//        #expect(calculator.R.debugDescription == "6789012346")
//
//        calculator.evaluateString("6789012345.9999")
//        #expect(calculator.R.debugDescription == "6789012346")
//
//        calculator.evaluateString("6789012345.99901")
//        #expect(calculator.R.debugDescription == "6789012346")
//
//        calculator.evaluateString("6789012345.99")
//        #expect(calculator.R.debugDescription == "6.789012e9")
//
//        calculator.evaluateString("6789012345.9")
//        #expect(calculator.R.debugDescription == "6.789012e9")
//
//        calculator.evaluateString("6789012345.989999")
//        #expect(calculator.R.debugDescription == "6.789012e9")
//
//        calculator.evaluateString("67890123456")
//        #expect(calculator.R.debugDescription == "6.78901e10")
//
//        calculator.evaluateString("678901234567")
//        #expect(calculator.R.debugDescription == "6.78901e11")
//
//        calculator.evaluateString("6789012345678")
//        #expect(calculator.R.debugDescription == "6.78901e12")
//
//        calculator.evaluateString("100")
//        #expect(calculator.R.debugDescription == "100")
//        
//        
//        calculator.evaluateString("99.9999999999999")
//        #expect(calculator.R.debugDescription == "100")
//        
//        calculator.evaluateString("100")
//        #expect(calculator.R.debugDescription == "100")
//        
//        calculator.evaluateString("-100")
//        #expect(calculator.R.debugDescription == "-100")
//        
//        calculator.evaluateString("-99.9999999999999")
//        #expect(calculator.R.debugDescription == "-100")
//        
//        calculator.evaluateString("99.9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "100")
//        
//        calculator.evaluateString("99.4999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "99.5")
//        
//        calculator.evaluateString("-99.4999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "-99.5")
//        
//        calculator.evaluateString("99.9919999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "99.992")
//        
//        calculator.evaluateString("999.9919999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "999.992")
//        
//        calculator.evaluateString("9999.9919999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "9999.992")
//        
//        calculator.evaluateString("99999.9919999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "99999.992")
//        
//        calculator.evaluateString("1234567.999")
//        #expect(calculator.R.debugDescription == "1234568")
//        
//        calculator.evaluateString("1234567.9999")
//        #expect(calculator.R.debugDescription == "1234568")
//        
//        calculator.evaluateString("1234567.99999")
//        #expect(calculator.R.debugDescription == "1234568")
//
//        calculator.evaluateString("1234567.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1234567")
//        
//        calculator.evaluateString("12345678.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "12345678")
//        
//        calculator.evaluateString("123456789.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "123456789")
//        calculator.evaluateString("1234567890.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1234567890")
//        
//        calculator.evaluateString("12345678901.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1.23456e10")
//        
//        calculator.evaluateString("123456789012.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1.23456e11")
//        
//        calculator.evaluateString("1234567890123.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1.23456e12")
//        
//        calculator.evaluateString("12345678901234.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1.23456e13")
//        
//        calculator.evaluateString("123456789012345.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1.23456e14")
//        
//        calculator.evaluateString("1234567890123456.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1.23456e15")
//        
//        calculator.evaluateString("1234567")
//        #expect(calculator.R.debugDescription == "1234567")
//        
//        calculator.evaluateString("1234567.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1234568")
//        
//        calculator.evaluateString("12345678.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "12345679")
//        
//        calculator.evaluateString("123456789.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "123456790")
//        calculator.evaluateString("1234567890.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1234567891")
//        
//        calculator.evaluateString("12345678901.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.23456e10")
//        
//        calculator.evaluateString("123456789012.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.23456e11")
//        
//        calculator.evaluateString("1234567890123.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.23456e12")
//        
//        calculator.evaluateString("12345678901234.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.23456e13")
//        
//        calculator.evaluateString("123456789012345.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.23456e14")
//        
//        calculator.evaluateString("1234567890123456.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.23456e15")
//        
//        calculator.evaluateString("-1234567.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "-1234568")
//        
//        calculator.evaluateString("-12345678.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "-12345679")
//        
//        calculator.evaluateString("-123456789.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "-123456790")
//        
//        calculator.evaluateString("-1234567890.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "-1.23456e9")
//        
//        calculator.evaluateString("-12345678901.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "-1.2345e10")
//        
//        calculator.evaluateString("-123456789012.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "-1.2345e11")
//        
//        calculator.evaluateString("-1234567890123.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "-1.2345e12")
//        
//        calculator.evaluateString("-12345678901234.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "-1.2345e13")
//        
//        calculator.evaluateString("-123456789012345.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "-1.2345e14")
//        
//        calculator.evaluateString("-1234567890123456.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "-1.2345e15")
//    }
//    
//    @Test func sciTest() {
//        if debug { return }
//        calculator.evaluateString("12345678900000007890123456")
//        #expect(calculator.R.debugDescription == "1.23456e25")
//
//        calculator.evaluateString("12345678900000007890123456.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.23456e25")
//
//        calculator.evaluateString("12340000000000007890123456.99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.234e25")
//
//        calculator.evaluateString("123499999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.235e80")
//
//        calculator.evaluateString("12349999999999999999999999.999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.235e25")
//        
//        calculator.evaluateString("123400000000000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "1.234e80")
//        
//        calculator.evaluateString("123490000000000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "1.2349e80")
//        
//        calculator.evaluateString("123499000000000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "1.23499e80")
//        
//        calculator.evaluateString("123499990000000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "1.23499e80")
//        
//        calculator.evaluateString("331234999900000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "3.31235e80")
//        
//        calculator.evaluateString("123499999000000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "1.235e80")
//        
//        calculator.evaluateString("123499990000000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "1.23499e80")
//        
//        calculator.evaluateString("100000000000000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "1.0e80")
//        
//        calculator.evaluateString("99999999999999999999999999999999999999999999999999999999999999999999999999999999")
//        #expect(calculator.R.debugDescription == "1.0e80")
//        
//
//        calculator.evaluateString("331234000000000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "3.31234e80")
//        
//        calculator.evaluateString("331234900000000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "3.31234e80")
//        
//        calculator.evaluateString("331234990000000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "3.31234e80")
//        
//        calculator.evaluateString("331234999900000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "3.31235e80")
//        
//        calculator.evaluateString("123499990000000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "1.23499e80")
//        
//        calculator.evaluateString("123499999000000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "1.235e80")
//        
//        calculator.evaluateString("123499999900000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "1.235e80")
//        
//        calculator.evaluateString("123499999990000000000000000000000000000000000000000000000000000000000000000000000")
//        #expect(calculator.R.debugDescription == "1.235e80")
//        
//
//        calculator.evaluateString("0.00000000000000000001")//00000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1.0e-20")
//
//        calculator.evaluateString("0.000000000000000000012")//00000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1.2e-20")
//
//        calculator.evaluateString("0.0000000000000000000123")//00000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1.23e-20")
//
//        calculator.evaluateString("0.00000000000000000001234")//00000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1.234e-20")
//
//        calculator.evaluateString("0.000000000000000000012341")//00000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1.2341e-20")
//
//        calculator.evaluateString("0.000000000000000000012345")//00000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1.2345e-20")
//
//        calculator.evaluateString("0.0000000000000000000123456")//00000000000000000000000000000000000000000000000000000000000000000000001")
//        #expect(calculator.R.debugDescription == "1.2345e-20")
//    }
//
//}
//
////struct S {
////    let decimalSeparator: DecimalSeparator
////    let separateGroups: Bool
////}
//
////@Test(arguments: [
//////    S(decimalSeparator: .comma, separateGroups: true),
//////    S(decimalSeparator: .comma, separateGroups: false),
//////    S(decimalSeparator: .dot, separateGroups: true),
////    S(decimalSeparator: .dot, separateGroups: false)])
////func separatorTest(s: S) {
////    let calculator = Calculator(precision: 20)
////    var RString: String
////
////    calculator.evaluateString("9995.9999999999999999999999999999999")
////    calculator.R.setMantissaExponent(calculator.mantissaExponent!, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
//////    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
////    RString = calculator.R.debugDescription
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
////    #expect(RString == "9996")
////    #expect(Double(RString)!.similar(to: 9996))
//
//
////    calculator.evaluateString("0.999999999999999999999999999999")
////    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
////    RString = R.debugDescription
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
////    #expect(Double(RString)!.similar(to: 1.0))
////    
////    calculator.evaluateString("9999.3999999999999999999999999999999")
////    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
////    RString = R.debugDescription
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
////    #expect(Double(RString)!.similar(to: 9999.4))
////
////    calculator.evaluateString("9999.3999999999999999999999999999999")
////    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
////    RString = R.debugDescription
////    //print("X: \(s.decimalSeparator) \(s.decimalSeparator.groupString) \(RString)")
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
////    #expect(Double(RString)!.similar(to: 9999.4))
////
////    calculator.evaluateString("99.999999999999999999999999999999")
////    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
////    RString = R.debugDescription
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
////    #expect(Double(RString)!.similar(to: 100.0))
////
////    calculator.evaluateString("0.000999999999999999999999999999999")
////    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
////    RString = R.debugDescription
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: DecimalSeparator.dot.string)
////    #expect(Double(RString)!.similar(to: 0.001))
////
////    calculator.evaluateString("-0.999999999999999999999999999999")
////    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
////    RString = R.debugDescription
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
////    #expect(Double(RString)!.similar(to: -1.0))
////
////    calculator.evaluateString("-99.999999999999999999999999999999")
////    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
////    RString = R.debugDescription
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
////    #expect(Double(RString)!.similar(to: -100.0))
////
////    calculator.evaluateString("-0.000999999999999999999999999999999")
////    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
////    RString = R.debugDescription
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
////    #expect(Double(RString)!.similar(to: -0.001))
////    
////    calculator.evaluateString("1.0823232337111381")
////    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
////    RString = R.debugDescription
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
////    #expect(Double(RString)!.similar(to: 1.0823232337111381))
////        
////    calculator.evaluateString("1.0 * 1.0823232337111381")
////    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
////    RString = R.debugDescription
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.groupString, with: "")
////    RString = RString.replacingOccurrences(of: s.decimalSeparator.string, with: ".")
////    #expect(Double(RString)!.similar(to: 1.0823232337111381))
////    
////    calculator.press(DigitOperation.one)
////    calculator.press(DigitOperation.dot)
////    calculator.press(DigitOperation.three)
////    
////    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
////    #expect(R.debugDescription == "1\(s.decimalSeparator.character)3")
////    
////    R = Representation(mantissaExponent: calculator.mantissaExponent!, font: font, displayBufferExponentFont: font, decimalSeparator: s.decimalSeparator, separateGroups: s.separateGroups, ePadding: 0.0)
////
////    calculator.press(EqualOperation.equal)
////    #expect(R.debugDescription == "1\(s.decimalSeparator.character)3")
//
//
}