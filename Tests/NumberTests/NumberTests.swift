//
//  NumberTests.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 24.09.24.
//

import Testing
import SwiftGmp

@Test func example() async {
    let p = 50
    let y1 = Number(7, precision: p)
    let y2 = Number(11, precision: p)
    let y3 = y1 * y2
    #expect(y3.similarTo(77.0))
    var x1 = Number(precision: p)
    x1.inplace_π()
    #expect(x1.similarTo(3.1415926))
    let x2 = Number("3", precision: p)
    #expect(x2.similarTo(3))
    let x3 = x1 + x2
    #expect(x1.similarTo(3.1415926))
    #expect(x2.similarTo(3))
    #expect(x3.similarTo(6.1415926))
    let x4 = rez(x3)
    #expect(x1.similarTo(3.1415926))
    #expect(x2.similarTo(3))
    #expect(x3.similarTo(6.1415926))
    #expect(x4.similarTo(0.1628242))
    #expect(rez(x4).similarTo(6.1415926))
    #expect(x4.similarTo(0.1628242))
    x4.inplace_rez()
    #expect(x4.similarTo(6.1415926))
    x4.inplace_rez()
    #expect(x4.similarTo(0.1628242))

    x1 = x1 + x2
    #expect(x1.similarTo(6.14159))
    #expect(!(x3 == x4))
    let x5 = 1.0 / x3
    print(x5)
    #expect(x5 == x4)
    print("x5.debugDescription")
}

