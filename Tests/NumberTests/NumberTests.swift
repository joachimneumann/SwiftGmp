//
//  NumberTests.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 24.09.24.
//

import Testing
import SwiftGmp

@Test func example() async throws {
    let n = Number("2", precision: 20)
    #expect(n.isApproximately(2))
    n.execute(SwiftGmp.rez)
    #expect(n.isApproximately(0.5))
    n.execute(SwiftGmp.pow_2_x)
    #expect(n.isApproximately(1.414))
    var e = Number("2", precision: 20)
    e.execute(SwiftGmp.e)
    #expect(e.isApproximately(2.718))
    e = Number("2", precision: 20)
    e.execute(SwiftGmp.pow_x_3)
    #expect(e.isApproximately(8))
    e.execute(SwiftGmp.changeSign)
    #expect(e.isApproximately(-8))
    let dd = e.isNegative
    #expect(dd)
    e.execute(SwiftGmp.abs)
    #expect(e.isApproximately(8))
}

