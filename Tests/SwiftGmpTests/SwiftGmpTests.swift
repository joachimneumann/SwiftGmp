import Testing
@testable import SwiftGmp

@Test func example() async throws {
    let x = SwiftGmp(withString: "1", precision: 20)
    #expect(x.toDouble() == 1)
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
    let x1 = SwiftGmp(withString: "2", precision: 20)
    let x2 = SwiftGmp(withString: "3", precision: 20)
    
    #expect((x1+x2).toDouble() == 5)
    #expect((x2+x1).toDouble() == 5)
    
    #expect((x1-x2).toDouble() == -1)
    #expect((x2-x1).toDouble() == 1)
    
    #expect((x1*x2).toDouble() == 6)
    #expect((x2*x1).toDouble() == 6)
    
    #expect((x1/x2).isApproximately(0.666))
    #expect((x2/x1).toDouble() == 1.5)
}

