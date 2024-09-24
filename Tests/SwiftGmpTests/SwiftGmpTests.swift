import Testing
@testable import SwiftGmp

@Test func example() async throws {
    let x = SwiftGmp(withString: "1", precision: 20)
    #expect(x.toDouble() == 1)
    let n = Number("2", precision: 20)
    #expect(n.isApproximately(2))
    n.execute(SwiftGmp.rez)
    #expect(n.isApproximately(0.5))
    let e = Number("2", precision: 20)
    e.execute(SwiftGmp.e)
    #expect(e.isApproximately(2.718))
}

