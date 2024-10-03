//// Note: This file is automatically generated.
////       It will be overwritten sooner or later.
//
//import Testing
//import SwiftGmp
//
//@Test func basics3Test() {
//    let calculator = Calculator(precision: 20)
//    var temp: Double = 0.0
//
//    #expect(calculator.asString("4.0 sqr") == "16.0")
//    #expect(calculator.asString("2.0 sqr") == "4.0")
//    #expect(calculator.asString("5.0 cubed") == "125.0")
//    #expect(calculator.asString("2.0 cubed") == "8.0")
//    temp = calculator.asDouble("1.0 exp")
//    #expect(temp.similarTo(2.7183))
//    temp = calculator.asDouble("2.0 exp")
//    #expect(temp.similarTo(7.3891))
//    #expect(calculator.asString("3.0 exp2") == "8.0")
//    #expect(calculator.asString("4.0 exp2") == "16.0")
//    #expect(calculator.asString("1.0 exp10") == "10.0")
//    #expect(calculator.asString("2.0 exp10") == "100.0")
//    #expect(calculator.asString("1.0 +/-") == "-1.0")
//    #expect(calculator.asString("-1.0 +/-") == "1.0")
//    #expect(calculator.asString("2.0 rez") == "0.5")
//    #expect(calculator.asString("4.0 rez") == "0.25")
//    #expect(calculator.asString("5.0 fac") == "120.0")
//    #expect(calculator.asString("3.0 fac") == "6.0")
//    #expect(calculator.asString("zero") == "0.0")
//    temp = calculator.asDouble("pi")
//    #expect(temp.similarTo(3.1416))
//    temp = calculator.asDouble("e")
//    #expect(temp.similarTo(2.7183))
//    #expect(calculator.asString("-3.0 abs") == "3.0")
//    #expect(calculator.asString("9.0 sqrt") == "3.0")
//    temp = calculator.asDouble("8.0 sqrt3")
//    #expect(temp.similarTo(2.0))
//    temp = calculator.asDouble("2.0 sqrt")
//    #expect(temp.similarTo(1.4142))
//    temp = calculator.asDouble("3.0 zeta")
//    #expect(temp.similarTo(1.2021))
//    #expect(calculator.asString("1.0 ln") == "0.0")
//    temp = calculator.asDouble("2.0 ln")
//    #expect(temp.similarTo(0.6931))
//    #expect(calculator.asString("10.0 log10") == "1.0")
//    #expect(calculator.asString("100.0 log10") == "2.0")
//    #expect(calculator.asString("8.0 log2") == "3.0")
//    #expect(calculator.asString("16.0 log2") == "4.0")
//}
