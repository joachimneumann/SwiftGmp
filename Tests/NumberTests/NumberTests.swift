//
//  NumberTests.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 24.09.24.
//

import Testing
import SwiftGmp

@Test func example() async {
    
    let numbers = Numbers(precision: 20)
    
    var x1 = await numbers.π
    #expect(await x1.isApproximately(3.1415926))
    let x2 = await numbers.new("3")
    #expect(await x2.isApproximately(3))
    let x3 = await x1 + x2
    #expect(await x1.isApproximately(3.1415926))
    #expect(await x2.isApproximately(3))
    #expect(await x3.isApproximately(6.1415926))
    let x4 = await rez(x3)
    #expect(await x1.isApproximately(3.1415926))
    #expect(await x2.isApproximately(3))
    #expect(await x3.isApproximately(6.1415926))
    #expect(await x4.isApproximately(0.1628242))
    #expect(await rez(x4).isApproximately(6.1415926))
    #expect(await x4.isApproximately(0.1628242))
    await x4.inplace_rez()
    #expect(await x4.isApproximately(6.1415926))
    await x4.inplace_rez()
    #expect(await x4.isApproximately(0.1628242))

    x1 = await x1 + x2
    #expect(await x1.isApproximately(6.14159))
    #expect(!(await x3 == x4))
    let x5 = await 1.0 / x3
    #expect(await x5 == x4)
}

