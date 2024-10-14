// DEBUG_TEST.swift

import Testing
@testable import SwiftGmp

@Test func DEBUG_TESTS() {
    let calculator = Calculator(precision: 100)
  
    var swiftGmp, bc: SwiftGmp
    
    swiftGmp = calculator.asSwiftGmp("1.1 * 1")
    bc = calculator.asSwiftGmp("1.1")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))

//    
//    var temp: Double
////    temp = calculator.asDouble("sin(1)")
////    #expect(temp.similarTo(0.841470984))
////    temp = calculator.asDouble("sin(0.841470984)")
////    #expect(temp.similarTo(0.745624141665))
//    temp = calculator.asDouble("sin(sin(1))")
//    #expect(temp.similarTo(0.745624141665))
//    
////    let x = calculator.evaluateString("abs (-3)")
////    let x1 = calculator.evaluateString("sin((3 + 2) x (5 - 3))")
////    let x = calculator.evaluateString("1+abs(-3)+1")
//    #expect(calculator.evaluateString("1+abs(-3)+1").string == "5")
//    #expect(calculator.evaluateString("1+abs(3)+1").string == "5")
////    print(x)
//    #expect(calculator.evaluateString("abs   (3)").string == "3")
//    #expect(calculator.evaluateString("abs(3)").string == "3")
//    #expect(calculator.evaluateString("abs(-3)").string == "3")
//    #expect(calculator.evaluateString("abs (-3)").string == "3")
//    #expect(calculator.evaluateString("3").string == "3")
//    #expect(calculator.evaluateString("-3").string == "-3")
//    #expect(calculator.evaluateString("3-4").string == "-1")
//    #expect(calculator.evaluateString("3 - -4").string == "7")
//    #expect(calculator.evaluateString("3- -4").string == "7")
//    #expect(calculator.evaluateString("3 - 4").string == "-1")
//    #expect(calculator.evaluateString("abs(-1x(3 + 2) x (5 - 3))").string == "10")
}
