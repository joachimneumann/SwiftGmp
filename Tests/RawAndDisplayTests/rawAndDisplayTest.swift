//
//  rawAndDisplayTest.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 20.10.24.
//

import Testing
@testable import SwiftGmp

class rawAndDisplayTest {
    var swiftGmp: SwiftGmp = SwiftGmp(withString: "0", bits: 100)
    var raw: Raw = Raw(mantissa: "0", exponent: 0, length: 10)
    var display: IntDisplay = IntDisplay(displayWidth: 10, separator: Separator(separatorType: .dot, groups: false))
    let L = 10
    
//    let debug = true
        let debug = false
    
    @Test func specialTests() {
        swiftGmp = SwiftGmp(withString: "100000000000000000000", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == 20)
        #expect(raw.isNegative == false)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "1.0")
        #expect(display.right == "e20")
    }
    
    @Test func integer() {
        if debug { return }
        swiftGmp = SwiftGmp(withString: "9.99999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.99999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "9.999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "9999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.99999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "9.9999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "9999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.99999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "9.99999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "9999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.99999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "9.999999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == 1)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "10")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "12", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 1)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "12")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "120", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 2)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "120")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "1_200", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 3)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "1200")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "12_000", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 4)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "12000")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "120_000", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 5)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "120000")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "1_200_000", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 6)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "1200000")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "12_000_000", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 7)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "12000000")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "120_000_000", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 8)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "120000000")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "1_200_000_000", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 9)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "1200000000")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "12_000_000_000", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 10)
        #expect(raw.isNegative == false)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "1.2")
        #expect(display.right == "e10")
        //5555555555.1234567890
        swiftGmp = SwiftGmp(withString: "5555555555.12345", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "5555555555")
        #expect(raw.exponent == 9)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "5555555555")
        // raw cuts to 10 digits, then this is an integer.
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "120000000000000000000000", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 23)
        #expect(raw.isNegative == false)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "1.2")
        #expect(display.right == "e23")
        
        swiftGmp = SwiftGmp(withString: "-12", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 1)
        #expect(raw.isNegative == true)
        #expect(display.type == .integer)
        #expect(display.left == "-12")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-120_000_000", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 8)
        #expect(raw.isNegative == true)
        #expect(display.type == .integer)
        #expect(display.left == "-120000000")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-1_200_000_000", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 9)
        #expect(raw.isNegative == true)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "-1.2")
        #expect(display.right == "e9")
        
        swiftGmp = SwiftGmp(withString: "-12_000_000_000", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 10)
        #expect(raw.isNegative == true)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "-1.2")
        #expect(display.right == "e10")
        
        swiftGmp = SwiftGmp(withString: "9.9999999999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == 1)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "10")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "111222333.99999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "111222334")
        #expect(raw.exponent == 8)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "111222334")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "111222333.9999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "111222334")
        #expect(raw.exponent == 8)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "111222334")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "111222333.999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1112223339")
        #expect(raw.exponent == 8)
        #expect(raw.isNegative == false)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "1.112223")
        #expect(display.right == "e8")
        
        
        swiftGmp = SwiftGmp(withString: "1112223334.99999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1112223335")
        #expect(raw.exponent == 9)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "1112223335")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "11122233344.99999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1112223334")
        #expect(raw.exponent == 10)
        #expect(raw.isNegative == false)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "1.11222")
        #expect(display.right == "e10")
    }
    
    @Test func floatLargerThan_1() {
        if debug { return }
        swiftGmp = SwiftGmp(withString: "1.1", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "11")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "1.1")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "1.1999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "11999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "1.1999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "1.199999999999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "1.2")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "9.9999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "99999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.9999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "9.99999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.99999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "9.999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "9999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "9.9999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "99999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.9999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "9.99999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.99999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "9.99999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.99999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "9.999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "9999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.99999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "9.9999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "9999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "9.99999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "11122233.999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1112223399")
        #expect(raw.exponent == 7)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "11122233.9")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "111222333.999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1112223339")
        #expect(raw.exponent == 8)
        #expect(raw.isNegative == false)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "1.112223")
        #expect(display.right == "e8")
        
        swiftGmp = SwiftGmp(withString: "11122233.3444555", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1112223334")
        #expect(raw.exponent == 7)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "11122233.3")
        #expect(display.right == nil)

        swiftGmp = SwiftGmp(withString: "111222333.444555", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1112223334")
        #expect(raw.exponent == 8)
        #expect(raw.isNegative == false)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "1.112223")
        #expect(display.right == "e8")

        
    }
    
    @Test func negativeFloatLargerThan_1() {
        if debug { return }
        swiftGmp = SwiftGmp(withString: "-1.1", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "11")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-1.1")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-1.1999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "11999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-1.1999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-1.199999999999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "12")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-1.2")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-9.9999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "99999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.9999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-9.99999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.99999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-9.999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "9999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-9.9999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "99999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.9999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-9.99999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.9999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-9.99999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.9999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-9.999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "9999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.9999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-9.9999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "9999999999")
        #expect(raw.exponent == 0)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatLargerThanOne)
        #expect(display.left == "-9.9999999")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-11122233.999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1112223399")
        #expect(raw.exponent == 7)
        #expect(raw.isNegative == true)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "-1.11222")
        #expect(display.right == "e7")
    }
    
    @Test func floatSmallerThan_1() {
        if debug { return }
        swiftGmp = SwiftGmp(withString: "0.1", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -1)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.1")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "0.01", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -2)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.01")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "0.001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -3)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.001")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "0.0001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -4)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.0001")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "0.00001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -5)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.00001")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "0.000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -6)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.000001")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "0.0000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -7)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.0000001")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "0.00000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -8)
        #expect(raw.isNegative == false)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "0.00000001")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "0.000000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -9)
        #expect(raw.isNegative == false)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "1.0")
        #expect(display.right == "e-9")
        
        swiftGmp = SwiftGmp(withString: "0.0000000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -10)
        #expect(raw.isNegative == false)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "1.0")
        #expect(display.right == "e-10")
        
        swiftGmp = SwiftGmp(withString: "0.9999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
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
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -1)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.1")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-0.01", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -2)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.01")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-0.001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -3)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.001")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-0.0001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -4)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.0001")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-0.00001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -5)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.00001")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-0.000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -6)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.000001")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-0.0000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -7)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.0000001")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "-0.00000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -8)
        #expect(raw.isNegative == true)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "-1.0")
        #expect(display.right == "e-8")
        
        swiftGmp = SwiftGmp(withString: "-0.000000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -9)
        #expect(raw.isNegative == true)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "-1.0")
        #expect(display.right == "e-9")
        
        swiftGmp = SwiftGmp(withString: "-0.0000000001", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == -10)
        #expect(raw.isNegative == true)
        #expect(display.type == .scientifiNotation)
        #expect(display.left == "-1.0")
        #expect(display.right == "e-10")
        
        swiftGmp = SwiftGmp(withString: "-0.9999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "9999")
        #expect(raw.exponent == -1)
        #expect(raw.isNegative == true)
        #expect(display.type == .floatSmallerThanOne)
        #expect(display.left == "-0.9999")
        #expect(display.right == nil)
    }
    
    @Test func oldTests() {
        let calculator = Calculator(precision: 20)
        
        calculator.evaluateString("0.0000099999999999999999")
        #expect(calculator.string == "0.00001")
        
        calculator.evaluateString("0.001")
        #expect(calculator.string == "0.001")
        calculator.evaluateString("0.0001")
        #expect(calculator.string == "0.0001")
        calculator.evaluateString("0.00001")
        #expect(calculator.string == "0.00001")
        calculator.evaluateString("0.000001")
        #expect(calculator.string == "0.000001")
        calculator.evaluateString("0.0000001")
        #expect(calculator.string == "0.0000001")
        calculator.evaluateString("0.00000001")
        #expect(calculator.string == "0.00000001")
        calculator.evaluateString("0.000000001")
        #expect(calculator.string == "1.0e-9")
        calculator.evaluateString("0.0000000001")
        #expect(calculator.string == "1.0e-10")
        calculator.evaluateString("0.00000000001")
        #expect(calculator.string == "1.0e-11")
        calculator.evaluateString("0.000000000001")
        #expect(calculator.string == "1.0e-12")
        
        calculator.evaluateString("0.000999999999999999999999999")
        #expect(calculator.string == "0.001")
        calculator.evaluateString("0.0000999999999999999999999999")
        #expect(calculator.string == "0.0001")
        calculator.evaluateString("0.00000999999999999999999999999")
        #expect(calculator.string == "0.00001")
        calculator.evaluateString("0.000000999999999999999999999999")
        #expect(calculator.string == "0.000001")
        calculator.evaluateString("0.0000000999999999999999999999999")
        #expect(calculator.string == "0.0000001")
        calculator.evaluateString("0.00000000999999999999999999999999")
        #expect(calculator.string == "0.00000001")
        calculator.evaluateString("0.000000000999999999999999999999999")
        #expect(calculator.string == "1.0e-9")
        calculator.evaluateString("0.0000000000999999999999999999999999")
        #expect(calculator.string == "1.0e-10")
        calculator.evaluateString("0.00000000000999999999999999999999999")
        #expect(calculator.string == "1.0e-11")
        calculator.evaluateString("0.000000000000999999999999999999999999")
        #expect(calculator.string == "1.0e-12")
        
        calculator.evaluateString("0.00000999999999999999")
        #expect(calculator.string == "0.00001")
        
        calculator.evaluateString("0.00000999999999999999 * 1")
        #expect(calculator.string == "0.00001")
        
        swiftGmp = SwiftGmp(withString: "99.999999999999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == 2)
        #expect(raw.isNegative == false)
        #expect(display.type == .integer)
        #expect(display.left == "100")
        #expect(display.right == nil)
        
        swiftGmp = SwiftGmp(withString: "49.9999999999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        display.update(raw: raw)
        #expect(raw.mantissa == "5")
        #expect(raw.exponent == 1)
        #expect(!raw.isNegative)
        #expect(display.string == "50")
        
        swiftGmp = SwiftGmp(withString: "1114.99999999999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        #expect(raw.mantissa == "1115")
        #expect(raw.exponent == 3)
        #expect(!raw.isNegative)
        
        swiftGmp = SwiftGmp(withString: "-99.999999999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        #expect(raw.mantissa == "1")
        #expect(raw.exponent == 2)
        #expect(raw.isNegative)
        
        swiftGmp = SwiftGmp(withString: "-49.9999999999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        #expect(raw.mantissa == "5")
        #expect(raw.exponent == 1)
        #expect(raw.isNegative)
        
        swiftGmp = SwiftGmp(withString: "-1114.99999999999999999", bits: 100)
        raw = swiftGmp.raw(digits: L)
        #expect(raw.mantissa == "1115")
        #expect(raw.exponent == 3)
        #expect(raw.isNegative)
        
        calculator.evaluateString("-99.9999999999999")
        #expect(calculator.string == "-100")
        
        calculator.evaluateString("100000000000000000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "1.0e80")
        
        calculator.evaluateString("0.00000001")
        #expect(calculator.string == "0.00000001")
        
        calculator.evaluateString("0.000000009999999999999")
        #expect(calculator.string == "0.00000001")
        
        calculator.evaluateString("0.000000001")
        #expect(calculator.string == "1.0e-9")
        calculator.evaluateString("0.0000000009999999999999")
        #expect(calculator.string == "1.0e-9")
        
        calculator.evaluateString("100000000000000000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "1.0e80")
        
        calculator.evaluateString("1234.5678901234567890123456789012345678901234567890123456789012345678901234567890")
        #expect(calculator.string == "1234.56789")
        
        calculator.evaluateString("1234567.9")
        #expect(calculator.string == "1234567.9")
        
        calculator.evaluateString("1234567.99")
        #expect(calculator.string == "1234567.99")
        
        calculator.evaluateString("1234567.9991")
        #expect(calculator.string == "1234567.99")
        
        calculator.evaluateString("1234567.9999")
        #expect(calculator.string == "1234567.99")
        
        calculator.evaluateString("1234567.999")
        #expect(calculator.string == "1234567.99")
        
        calculator.evaluateString("12345677.998")
        #expect(calculator.string == "12345677.9")
        
        calculator.evaluateString("12345677.9991")
        #expect(calculator.string == "12345677.9")
        
        calculator.evaluateString("12345677.9999")
        #expect(calculator.string == "12345677.9")
        
        calculator.evaluateString("12345677.999")
        #expect(calculator.string == "12345677.9")
        
        calculator.evaluateString("12345677.998")
        #expect(calculator.string == "12345677.9")
        
        calculator.evaluateString("123456777.998")
        #expect(calculator.string == "1.234567e8")
        
        calculator.evaluateString("123456777.9991")
        #expect(calculator.string == "1.234567e8")
        
        calculator.evaluateString("123456777.9999")
        #expect(calculator.string == "123456778")
        
        calculator.evaluateString("123456777.999")
        #expect(calculator.string == "1.234567e8")
        
        calculator.evaluateString("1234567777.998")
        #expect(calculator.string == "1234567777")
        
        calculator.evaluateString("1234567777.998")
        #expect(calculator.string == "1234567777")
        
        calculator.evaluateString("1234567777.9991")
        #expect(calculator.string == "1234567778")
        
        calculator.evaluateString("1234567777.9999")
        #expect(calculator.string == "1234567778")
        
        calculator.evaluateString("1234567777.999")
        #expect(calculator.string == "1234567778")
        
        calculator.evaluateString("1234567777.998")
        #expect(calculator.string == "1234567777")
        
        calculator.evaluateString("10.0")
        #expect(calculator.string == "10")
        
        calculator.evaluateString("1.0")
        #expect(calculator.string == "1")
        
        calculator.evaluateString("0.1")
        #expect(calculator.string == "0.1")
        
        calculator.evaluateString("0.01")
        #expect(calculator.string == "0.01")
        
        calculator.evaluateString("0.0001")
        #expect(calculator.string == "0.0001")
        
        calculator.evaluateString("0.00001")
        #expect(calculator.string == "0.00001")
        
        calculator.evaluateString("0.000001")
        #expect(calculator.string == "0.000001")
        
        calculator.evaluateString("0.0000001")
        #expect(calculator.string == "0.0000001")
        calculator.evaluateString("0.000000099999999999999")
        #expect(calculator.string == "0.0000001")
        
        calculator.evaluateString("0.00000001")
        #expect(calculator.string == "0.00000001")
        calculator.evaluateString("0.000000009999999999999")
        #expect(calculator.string == "0.00000001")
        
        calculator.evaluateString("0.000000001")
        #expect(calculator.string == "1.0e-9")
        calculator.evaluateString("0.0000000009999999999999999")
        #expect(calculator.string == "1.0e-9")
        
        calculator.evaluateString("0.0000000001")
        #expect(calculator.string == "1.0e-10")
        calculator.evaluateString("0.00000000009999999999999999")
        #expect(calculator.string == "1.0e-10")
        
        calculator.evaluateString("0.00000000001")
        #expect(calculator.string == "1.0e-11")
        
        calculator.evaluateString("0.000000000001")
        #expect(calculator.string == "1.0e-12")
        
        calculator.evaluateString("0.001")
        #expect(calculator.string == "0.001")
        
        calculator.evaluateString("0.001")
        #expect(calculator.string == "0.001")
        
        calculator.evaluateString("0.0999999999999999")
        #expect(calculator.string == "0.1")
        
        calculator.evaluateString("0.00000999999999999999")
        #expect(calculator.string == "0.00001")
        
        
        calculator.evaluateString("5.1")
        #expect(calculator.string == "5.1")
        
        calculator.evaluateString("1.0")
        #expect(calculator.string == "1")
        
        calculator.evaluateString("55.1")
        #expect(calculator.string == "55.1")
        
        calculator.evaluateString("1234.5678901234567890123456789012345678901234567890123456789012345678901234567890")
        #expect(calculator.string == "1234.56789")
        
        calculator.evaluateString("-1234.5678901234567890123456789012345678901234567890123456789012345678901234567890")
        #expect(calculator.string == "-1234.5678")
        
        calculator.evaluateString("-1234567.9")
        #expect(calculator.string == "-1234567.9")
        
        calculator.evaluateString("-1234567.99")
        #expect(calculator.string == "-1234567.9")
        
        calculator.evaluateString("-1234567.999")
        #expect(calculator.string == "-1234567.9")
        
        calculator.evaluateString("-1234567.9999")
        #expect(calculator.string == "-1234567.9")
        
        calculator.evaluateString("-1234567.9999")
        #expect(calculator.string == "-1234567.9")
        
        calculator.evaluateString("-1234567.998")
        #expect(calculator.string == "-1234567.9")
        
        calculator.evaluateString("3331234567.9")
        #expect(calculator.string == "3331234567")
        
        calculator.evaluateString("331234567.9")
        #expect(calculator.string == "3.312345e8")
        
        calculator.evaluateString("-31234567.9")
        #expect(calculator.string == "-3.12345e7")
        
        calculator.evaluateString("-31234567.99")
        #expect(calculator.string == "-3.12345e7")
        
        calculator.evaluateString("-31234567.999")
        #expect(calculator.string == "-3.12345e7")
        
        calculator.evaluateString("-31234567.9999")
        #expect(calculator.string == "-3.12345e7")
        
        calculator.evaluateString("-31234567.9999")
        #expect(calculator.string == "-3.12345e7")
        
        calculator.evaluateString("-31234567.998")
        #expect(calculator.string == "-3.12345e7")
        
        calculator.evaluateString("-10.0")
        #expect(calculator.string == "-10")
        
        calculator.evaluateString("-1.0")
        #expect(calculator.string == "-1")
        
        calculator.evaluateString("-0.1")
        #expect(calculator.string == "-0.1")
        
        calculator.evaluateString("-0.01")
        #expect(calculator.string == "-0.01")
        
        calculator.evaluateString("-0.0001")
        #expect(calculator.string == "-0.0001")
        
        calculator.evaluateString("-0.00001")
        #expect(calculator.string == "-0.00001")
        
        calculator.evaluateString("-0.000001")
        #expect(calculator.string == "-0.000001")
        
        calculator.evaluateString("-0.0000001")
        #expect(calculator.string == "-0.0000001")
        calculator.evaluateString("-0.0000000999999999999999")
        #expect(calculator.string == "-0.0000001")
        
        calculator.evaluateString("-0.00000001")
        #expect(calculator.string == "-1.0e-8")
        calculator.evaluateString("-0.000000009999999999999999")
        #expect(calculator.string == "-1.0e-8")
        
        calculator.evaluateString("-0.000000001")
        #expect(calculator.string == "-1.0e-9")
        calculator.evaluateString("-0.00000000099999999999999")
        #expect(calculator.string == "-1.0e-9")
        
        calculator.evaluateString("-0.0000000001")
        #expect(calculator.string == "-1.0e-10")
        calculator.evaluateString("-0.000000000099999999999999")
        #expect(calculator.string == "-1.0e-10")
        
        calculator.evaluateString("-0.00000000001")
        #expect(calculator.string == "-1.0e-11")
        
        calculator.evaluateString("-0.000000000001")
        #expect(calculator.string == "-1.0e-12")
        
        calculator.evaluateString("-0.001")
        #expect(calculator.string == "-0.001")
        
        calculator.evaluateString("-0.001")
        #expect(calculator.string == "-0.001")
        
        calculator.evaluateString("-0.0999999999999999999999")
        #expect(calculator.string == "-0.1")
        
        calculator.evaluateString("-0.00000999999999999999999999")
        #expect(calculator.string == "-0.00001")
        
        
        calculator.evaluateString("-5.1")
        #expect(calculator.string == "-5.1")
        
        calculator.evaluateString("-1.0")
        #expect(calculator.string == "-1")
        
        calculator.evaluateString("-55.1")
        #expect(calculator.string == "-55.1")
        
        calculator.evaluateString("1234")
        #expect(calculator.string == "1234")
        
        calculator.evaluateString("12345")
        #expect(calculator.string == "12345")
        
        calculator.evaluateString("123456")
        #expect(calculator.string == "123456")
        
        calculator.evaluateString("1234567")
        #expect(calculator.string == "1234567")
        
        calculator.evaluateString("12345678")
        #expect(calculator.string == "12345678")
        
        calculator.evaluateString("123456789")
        #expect(calculator.string == "123456789")
        
        calculator.evaluateString("1234567890")
        #expect(calculator.string == "1234567890")
        
        calculator.evaluateString("3333378901")
        #expect(calculator.string == "3333378901")
        
        calculator.evaluateString("33333789012")
        #expect(calculator.string == "3.33337e10")
        
        calculator.evaluateString("6789")
        #expect(calculator.string == "6789")
        
        calculator.evaluateString("67890")
        #expect(calculator.string == "67890")
        
        calculator.evaluateString("678901")
        #expect(calculator.string == "678901")
        
        calculator.evaluateString("6789012")
        #expect(calculator.string == "6789012")
        
        calculator.evaluateString("67890123")
        #expect(calculator.string == "67890123")
        
        calculator.evaluateString("678901234")
        #expect(calculator.string == "678901234")
        
        calculator.evaluateString("6789012345")
        #expect(calculator.string == "6789012345")
        
        calculator.evaluateString("6789012345.999999")
        #expect(calculator.string == "6789012346")
        
        calculator.evaluateString("6789012345.99999")
        #expect(calculator.string == "6789012346")
        
        calculator.evaluateString("6789012345.9999")
        #expect(calculator.string == "6789012346")
        
        calculator.evaluateString("6789012345.99901")
        #expect(calculator.string == "6789012346")
        
        calculator.evaluateString("6789012345.99")
        #expect(calculator.string == "6789012345")
        
        calculator.evaluateString("6789012345.9")
        #expect(calculator.string == "6789012345")
        
        calculator.evaluateString("6789012345.99999")
        #expect(calculator.string == "6789012346")
        
        calculator.evaluateString("67890123456")
        #expect(calculator.string == "6.78901e10")
        
        calculator.evaluateString("678901234567")
        #expect(calculator.string == "6.78901e11")
        
        calculator.evaluateString("6789012345678")
        #expect(calculator.string == "6.78901e12")
        
        calculator.evaluateString("100")
        #expect(calculator.string == "100")
        
        
        calculator.evaluateString("99.9999999999999")
        #expect(calculator.string == "100")
        
        calculator.evaluateString("100")
        #expect(calculator.string == "100")
        
        calculator.evaluateString("-100")
        #expect(calculator.string == "-100")
        
        calculator.evaluateString("-99.9999999999999")
        #expect(calculator.string == "-100")
        
        calculator.evaluateString("99.9999999999999999999999999999")
        #expect(calculator.string == "100")
        
        calculator.evaluateString("99.4999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
        #expect(calculator.string == "99.5")
        
        calculator.evaluateString("-99.4999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
        #expect(calculator.string == "-99.5")
        
        calculator.evaluateString("99.9919999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
        #expect(calculator.string == "99.992")
        
        calculator.evaluateString("999.9919999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
        #expect(calculator.string == "999.992")
        
        calculator.evaluateString("9999.9919999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
        #expect(calculator.string == "9999.992")
        
        calculator.evaluateString("99999.9919999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
        #expect(calculator.string == "99999.992")
        
        calculator.evaluateString("1234567.999999")
        #expect(calculator.string == "1234568")
        
        calculator.evaluateString("1234567.9999999")
        #expect(calculator.string == "1234568")
        
        calculator.evaluateString("1234567.9999999")
        #expect(calculator.string == "1234568")
        
        calculator.evaluateString("1234567.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        #expect(calculator.string == "1234567")
        
        calculator.evaluateString("12345678.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        #expect(calculator.string == "12345678")
        
        calculator.evaluateString("123456789.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        #expect(calculator.string == "123456789")
        calculator.evaluateString("1234567890.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        #expect(calculator.string == "1234567890")
        
        calculator.evaluateString("12345678901.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        #expect(calculator.string == "1.23456e10")
        
        calculator.evaluateString("123456789012.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        #expect(calculator.string == "1.23456e11")
        
        calculator.evaluateString("1234567890123.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        #expect(calculator.string == "1.23456e12")
        
        calculator.evaluateString("12345678901234.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        #expect(calculator.string == "1.23456e13")
        
        calculator.evaluateString("123456789012345.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        #expect(calculator.string == "1.23456e14")
        
        calculator.evaluateString("1234567890123456.000000000000000000000000000000000000000000000000000000000000000000000000000000001")
        #expect(calculator.string == "1.23456e15")
        
        calculator.evaluateString("1234567")
        #expect(calculator.string == "1234567")
        
        calculator.evaluateString("1234567.99999999999999999")
        #expect(calculator.string == "1234568")
        
        calculator.evaluateString("12345678.99999999999999999")
        #expect(calculator.string == "12345679")
        
        calculator.evaluateString("123456789.99999999999999999")
        #expect(calculator.string == "123456790")
        calculator.evaluateString("1234567890.99999999999999999")
        #expect(calculator.string == "1234567891")
        
        calculator.evaluateString("12345678901.99999999999999999")
        #expect(calculator.string == "1.23456e10")
        
        calculator.evaluateString("123456789012.99999999999999999")
        #expect(calculator.string == "1.23456e11")
        
        calculator.evaluateString("1234567890123.99999999999999999")
        #expect(calculator.string == "1.23456e12")
        
        calculator.evaluateString("12345678901234.99999999999999999")
        #expect(calculator.string == "1.23456e13")
        
        calculator.evaluateString("123456789012345.99999999999999999")
        #expect(calculator.string == "1.23456e14")
        
        calculator.evaluateString("1234567890123456.99999999999999999")
        #expect(calculator.string == "1.23456e15")
        
        calculator.evaluateString("-1234567.99999999999999999")
        #expect(calculator.string == "-1234568")
        
        calculator.evaluateString("-12345678.99999999999999999")
        #expect(calculator.string == "-12345679")
        
        calculator.evaluateString("-123456789.99999999999999999")
        #expect(calculator.string == "-123456790")
        
        calculator.evaluateString("-1234567890.99999999999999999")
        #expect(calculator.string == "-1.23456e9")
        
        calculator.evaluateString("-12345678901.99999999999999999")
        #expect(calculator.string == "-1.2345e10")
        
        calculator.evaluateString("-123456789012.99999999999999999")
        #expect(calculator.string == "-1.2345e11")
        
        calculator.evaluateString("-1234567890123.99999999999999999")
        #expect(calculator.string == "-1.2345e12")
        
        calculator.evaluateString("-12345678901234.99999999999999999")
        #expect(calculator.string == "-1.2345e13")
        
        calculator.evaluateString("-123456789012345.99999999999999999")
        #expect(calculator.string == "-1.2345e14")
        
        calculator.evaluateString("-1234567890123456.99999999999999999")
        #expect(calculator.string == "-1.2345e15")
        
        calculator.evaluateString("12345678900000007890123456.99999999999999999")
        #expect(calculator.string == "1.23456e25")
        
        calculator.evaluateString("12340000000000007890123456.99999999999999999")
        #expect(calculator.string == "1.234e25")
        
        calculator.evaluateString("123499999999999999999999999999999999999999999999999999999999999999999999999999999")
        #expect(calculator.string == "1.235e80")
        
        calculator.evaluateString("12349999999999999999999999.999999999999999999999999999999999999999999999999999999")
        #expect(calculator.string == "1.235e25")
        
        calculator.evaluateString("123400000000000000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "1.234e80")
        
        calculator.evaluateString("123490000000000000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "1.2349e80")
        
        calculator.evaluateString("123499000000000000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "1.23499e80")
        
        calculator.evaluateString("123499990000000000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "1.23499e80")
        
        calculator.evaluateString("331234999999999000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "3.31235e80")
        
        calculator.evaluateString("123499999999990000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "1.235e80")
        
        calculator.evaluateString("123499990000000000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "1.23499e80")
        
        calculator.evaluateString("100000000000000000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "1.0e80")
        
        calculator.evaluateString("99999999999999999999999999999999999999999999999999999999999999999999999999999999")
        #expect(calculator.string == "1.0e80")
        
        
        calculator.evaluateString("331234000000000000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "3.31234e80")
        
        calculator.evaluateString("331234900000000000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "3.31234e80")
        
        calculator.evaluateString("331234990000000000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "3.31234e80")
        
        calculator.evaluateString("331234999999900000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "3.31235e80")
        
        calculator.evaluateString("123499990000000000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "1.23499e80")
        
        calculator.evaluateString("123499999999900000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "1.235e80")
        
        calculator.evaluateString("123499999900000000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "1.23499e80")
        
        calculator.evaluateString("123499999990000000000000000000000000000000000000000000000000000000000000000000000")
        #expect(calculator.string == "1.23499e80")
        
        
        calculator.evaluateString("0.00000000000000000001")
        #expect(calculator.string == "1.0e-20")
        
        calculator.evaluateString("0.000000000000000000012")
        #expect(calculator.string == "1.2e-20")
        
        calculator.evaluateString("0.0000000000000000000123")
        #expect(calculator.string == "1.23e-20")
        
        calculator.evaluateString("0.00000000000000000001234")
        #expect(calculator.string == "1.234e-20")
        
        calculator.evaluateString("0.000000000000000000012341")
        #expect(calculator.string == "1.2341e-20")
        
        calculator.evaluateString("0.000000000000000000012345")
        #expect(calculator.string == "1.2345e-20")
        
        calculator.evaluateString("0.0000000000000000000123456")
        #expect(calculator.string == "1.2345e-20")
    }
}
