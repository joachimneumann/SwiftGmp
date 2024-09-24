//
//  NumberTests.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 24.09.24.
//

import Testing
import SwiftGmp

@Test func example() async throws {
    
    let numbers = Numbers(precision: 20)
    
    var x1 = numbers.π
    #expect(x1.isApproximately(3.1415926))
    let x2 = numbers.new("3")
    #expect(x2.isApproximately(3))
    let x3 = x1 + x2
    #expect(x1.isApproximately(3.1415926))
    #expect(x2.isApproximately(3))
    #expect(x3.isApproximately(6.1415926))
    let x4 = rez(x3)
    #expect(x1.isApproximately(3.1415926))
    #expect(x2.isApproximately(3))
    #expect(x3.isApproximately(6.1415926))
    #expect(x4.isApproximately(0.1628242))
    #expect(rez(x4).isApproximately(6.1415926))
    #expect(x4.isApproximately(0.1628242))
    x4.inplace_rez()
    #expect(x4.isApproximately(6.1415926))
    x4.inplace_rez()
    #expect(x4.isApproximately(0.1628242))

    x1 = x1 + x2
    #expect(x1.isApproximately(6.14159))
    #expect(x3 != x4)
    let x5 = 1.0 / x3
    #expect(x5 == x4)
}

