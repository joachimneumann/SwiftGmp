import Testing
@testable import SwiftGmp

@Test func example() {
    let nan = SwiftGmp(bits: 20)
    #expect(!nan.isValid)
    #expect(nan.debugDescription == "nan")
    #expect(nan.toDouble().debugDescription == Double.nan.debugDescription) // nan
    
    let x = SwiftGmp(withString: "1", bits: 20)
    #expect(x.toDouble() == 1)
    let x1 = SwiftGmp(withString: "-2", bits: 20)
    let x2 = SwiftGmp(withString: "-3", bits: 20)
    
    #expect(x1.toDouble() == -2)
    x1.execute(.abs)
    #expect(x1.toDouble() == 2)

    x1.execute(.mul, other: x2)
    #expect(x1.toDouble() == -6)
    x1.execute(.mul, other: x2)
    #expect(x1.toDouble() == 18)

    x1.execute(.add, other: x2)
    #expect(x1.toDouble() == 15)
    
    x2.execute(.rez)
    #expect(x2.isApproximately(-0.33333))
}

