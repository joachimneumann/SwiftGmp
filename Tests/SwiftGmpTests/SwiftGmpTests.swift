import Testing
@testable import SwiftGmp

@Test func example() {
    let nan = SwiftGmp(precision: 20)
    #expect(!nan.isValid)
    #expect(nan.debugDescription == "nan")
    #expect(nan.toDouble().debugDescription == Double.nan.debugDescription) // nan
    
    let x = SwiftGmp(withString: "1", precision: 20)
    #expect(x.toDouble() == 1)
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
    
    x2.rez()
    #expect(x2.isApproximately(0.33333))
}

