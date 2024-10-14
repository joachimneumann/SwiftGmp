// Note: This file is automatically generated.
//       It will be overwritten sooner or later.

import Testing
import SwiftGmp

@Test func basics1Test() {
    let calculator = Calculator(precision: 20)

    #expect(calculator.evaluateString("1.1 * 1").string == "1.1")
    #expect(calculator.evaluateString("1 + 3 * 10").string == "31")
    #expect(calculator.evaluateString("1 + 2").string == "3")
    #expect(calculator.evaluateString("2 * 4").string == "8")
    #expect(calculator.evaluateString("3 / 0").string == "inf")
    #expect(calculator.evaluateString("10/2").string == "5")
    #expect(calculator.evaluateString("abs(-5.0)").string == "5")
    #expect(calculator.evaluateString("abs(3.14)").string == "3.14")
    #expect(calculator.evaluateString("abs(0.0)").string == "0")
    #expect(calculator.evaluateString("500 + 500").string == "1000")
    #expect(calculator.evaluateString("abs(-100.25)").string == "100.25")
    #expect(calculator.evaluateString("abs(12.5)").string == "12.5")
    #expect(calculator.evaluateString("153.4 - 153").string == "0.4")
    #expect(calculator.evaluateString("153.4 - 152").string == "1.4")
    #expect(calculator.evaluateString("153.4 - 142").string == "11.4")
    #expect(calculator.evaluateString("153.4 - 154").string == "-0.6")
    #expect(calculator.evaluateString("153.4 - 155").string == "-1.6")
    #expect(calculator.evaluateString("153.4 - 165").string == "-11.6")
    var temp: Double
    temp = calculator.asDouble("1 / 7")
    #expect(temp.similar(to: 0.1428571))
    #expect(calculator.evaluateString("10 %").string == "0.1")
    #expect(calculator.evaluateString("200 + 20 %").string == "240")
    temp = calculator.asDouble("100 + e %")
    #expect(temp.similar(to: 102.7183))
    #expect(calculator.evaluateString("0.1 %").string == "0.001")
    temp = calculator.asDouble("pi")
    #expect(temp.similar(to: 3.14159))
    temp = calculator.asDouble("sqrt(4.0)")
    #expect(temp.similar(to: 2))
    temp = calculator.asDouble("sqrt(9.0)")
    #expect(temp.similar(to: 3))
    temp = calculator.asDouble("sqrt(0.0)")
    #expect(temp.similar(to: 0))
    temp = calculator.asDouble("sqrt(16.0)")
    #expect(temp.similar(to: 4))
    temp = calculator.asDouble("sqrt(25.0)")
    #expect(temp.similar(to: 5))
    #expect(calculator.evaluateString("sqrt(-1)").string == "not a number")
    temp = calculator.asDouble("sqrt3(8.0)")
    #expect(temp.similar(to: 2))
    temp = calculator.asDouble("sqrt3(27.0)")
    #expect(temp.similar(to: 3))
    temp = calculator.asDouble("sqrt3(0.0)")
    #expect(temp.similar(to: 0))
    temp = calculator.asDouble("sqrt3(64.0)")
    #expect(temp.similar(to: 4))
    temp = calculator.asDouble("sqrt3(125.0)")
    #expect(temp.similar(to: 5))
    #expect(calculator.evaluateString("zeta(1)").string == "inf")
    temp = calculator.asDouble("zeta(2)")
    #expect(temp.similar(to: 1.6449340668482264))
    temp = calculator.asDouble("zeta(3)")
    #expect(temp.similar(to: 1.2020569031595942))
    temp = calculator.asDouble("zeta(4)")
    #expect(temp.similar(to: 1.0823232337111381))
    temp = calculator.asDouble("zeta(5)")
    #expect(temp.similar(to: 1.0369277551433699))
    temp = calculator.asDouble("zeta(6)")
    #expect(temp.similar(to: 1.0173430619844490))
    temp = calculator.asDouble("zeta(7)")
    #expect(temp.similar(to: 1.0083492773819228))
    temp = calculator.asDouble("zeta(8)")
    #expect(temp.similar(to: 1.0040773561979440))
    temp = calculator.asDouble("zeta(9)")
    #expect(temp.similar(to: 1.0020083928260822))
    temp = calculator.asDouble("ln(1.0)")
    #expect(temp.similar(to: 0))
    temp = calculator.asDouble("ln(2.7183)")
    #expect(temp.similar(to: 1.0))
    temp = calculator.asDouble("ln(7.3891)")
    #expect(temp.similar(to: 2.0))
    temp = calculator.asDouble("ln(20.0855)")
    #expect(temp.similar(to: 3.0))
    temp = calculator.asDouble("ln(54.5982)")
    #expect(temp.similar(to: 4.0))
    temp = calculator.asDouble("log10(1.0)")
    #expect(temp.similar(to: 0))
    temp = calculator.asDouble("log10(10.0)")
    #expect(temp.similar(to: 1))
    temp = calculator.asDouble("log10(100.0)")
    #expect(temp.similar(to: 2))
    temp = calculator.asDouble("log10(1000.0)")
    #expect(temp.similar(to: 3))
    temp = calculator.asDouble("log10(10000.0)")
    #expect(temp.similar(to: 4))
    temp = calculator.asDouble("log2(1.0)")
    #expect(temp.similar(to: 0))
    temp = calculator.asDouble("log2(2.0)")
    #expect(temp.similar(to: 1))
    temp = calculator.asDouble("log2(4.0)")
    #expect(temp.similar(to: 2))
    temp = calculator.asDouble("log2(8.0)")
    #expect(temp.similar(to: 3))
    temp = calculator.asDouble("log2(16.0)")
    #expect(temp.similar(to: 4))
    temp = calculator.asDouble("sqr(2.0)")
    #expect(temp.similar(to: 4))
    temp = calculator.asDouble("sqr(3.0)")
    #expect(temp.similar(to: 9))
    temp = calculator.asDouble("sqr(5.0)")
    #expect(temp.similar(to: 25))
    temp = calculator.asDouble("sqr(-4.0)")
    #expect(temp.similar(to: 16))
    temp = calculator.asDouble("sqr(10.0)")
    #expect(temp.similar(to: 100))
    temp = calculator.asDouble("exp(1.0)")
    #expect(temp.similar(to: 2.7183))
    temp = calculator.asDouble("exp(2.0)")
    #expect(temp.similar(to: 7.3891))
    temp = calculator.asDouble("exp(3.0)")
    #expect(temp.similar(to: 20.0855))
    #expect(calculator.evaluateString("exp(0.0)").string == "1")
    temp = calculator.asDouble("exp(-1.0)")
    #expect(temp.similar(to: 0.3679))
    temp = calculator.asDouble("exp10(0.0)")
    #expect(temp.similar(to: 1))
    temp = calculator.asDouble("exp10(1.0)")
    #expect(temp.similar(to: 10))
    temp = calculator.asDouble("exp10(2.0)")
    #expect(temp.similar(to: 100))
    temp = calculator.asDouble("exp10(3.0)")
    #expect(temp.similar(to: 1000))
    temp = calculator.asDouble("exp10(-1.0)")
    #expect(temp.similar(to: 0.1))
    temp = calculator.asDouble("0.0 ±")
    #expect(temp.similar(to: 0))
    #expect(calculator.evaluateString("0.0 ±").string == "0")
    temp = calculator.asDouble("5.0 ±")
    #expect(temp.similar(to: -5))
    temp = calculator.asDouble("-3.14 ±")
    #expect(temp.similar(to: 3.14))
    temp = calculator.asDouble("0.0 ±")
    #expect(temp.similar(to: 0))
    temp = calculator.asDouble("100.0 ±")
    #expect(temp.similar(to: -100))
    temp = calculator.asDouble("-50.0 ±")
    #expect(temp.similar(to: 50))
    temp = calculator.asDouble("cubed(2.0)")
    #expect(temp.similar(to: 8))
    temp = calculator.asDouble("cubed(3.0)")
    #expect(temp.similar(to: 27))
    temp = calculator.asDouble("cubed(-4.0)")
    #expect(temp.similar(to: -64))
    temp = calculator.asDouble("cubed(5.0)")
    #expect(temp.similar(to: 125))
    temp = calculator.asDouble("cubed(-2.0)")
    #expect(temp.similar(to: -8))
    temp = calculator.asDouble("rez(2.0)")
    #expect(temp.similar(to: 0.5))
    temp = calculator.asDouble("rez(4.0)")
    #expect(temp.similar(to: 0.25))
    temp = calculator.asDouble("rez(0.5)")
    #expect(temp.similar(to: 2))
    temp = calculator.asDouble("rez(10.0)")
    #expect(temp.similar(to: 0.1))
    temp = calculator.asDouble("rez(0.2)")
    #expect(temp.similar(to: 5))
    temp = calculator.asDouble("fac(0.0)")
    #expect(temp.similar(to: 1))
    temp = calculator.asDouble("fac(1.0)")
    #expect(temp.similar(to: 1))
    temp = calculator.asDouble("fac(2.0)")
    #expect(temp.similar(to: 2))
    temp = calculator.asDouble("sind(30)")
    #expect(temp.similar(to: 0.5))
    temp = calculator.asDouble("sind(45)")
    #expect(temp.similar(to: 0.7071))
    temp = calculator.asDouble("sind(60)")
    #expect(temp.similar(to: 0.8660))
    #expect(calculator.evaluateString("sind(90)").string == "1")
    #expect(calculator.evaluateString("sind(0)").string == "0")
    temp = calculator.asDouble("sind(180)")
    #expect(temp.similar(to: 0))
    #expect(calculator.evaluateString("sind(270)").string == "-1")
    temp = calculator.asDouble("cosd(30)")
    #expect(temp.similar(to: 0.8660))
    temp = calculator.asDouble("cosd(45)")
    #expect(temp.similar(to: 0.7071))
    temp = calculator.asDouble("cosd(60)")
    #expect(temp.similar(to: 0.5))
    temp = calculator.asDouble("cosd(90)")
    #expect(temp.similar(to: 0))
    #expect(calculator.evaluateString("tand(45)").string == "1")
    temp = calculator.asDouble("tand(60)")
    #expect(temp.similar(to: 1.7321))
    temp = calculator.asDouble("tand(30)")
    #expect(temp.similar(to: 0.5774))
    #expect(calculator.evaluateString("tand(0)").string == "0")
    #expect(calculator.evaluateString("asind(0)").string == "0")
    #expect(calculator.evaluateString("acosd(0)").string == "90")
    #expect(calculator.evaluateString("asind(0.5)").string == "30")
    #expect(calculator.evaluateString("acosd(0.5)").string == "60")
    #expect(calculator.evaluateString("atand(1)").string == "45")
    #expect(calculator.evaluateString("atand(0)").string == "0")
    temp = calculator.asDouble("sin(1.5708)")
    #expect(temp.similar(to: 1))
    temp = calculator.asDouble("cos(0.5236)")
    #expect(temp.similar(to: 0.8660))
    temp = calculator.asDouble("sin(1.0472)")
    #expect(temp.similar(to: 0.8660))
    temp = calculator.asDouble("tan(0.7854)")
    #expect(temp.similar(to: 1))
    temp = calculator.asDouble("sin(2.3562)")
    #expect(temp.similar(to: 0.7071))
    temp = calculator.asDouble("cos(2.6180)")
    #expect(temp.similar(to: -0.8660))
    temp = calculator.asDouble("sin(3.1416)")
    #expect(temp.similar(to: 0))
    temp = calculator.asDouble("cos(3.1416)")
    #expect(temp.similar(to: -1))
    temp = calculator.asDouble("sin(3.6652)")
    #expect(temp.similar(to: -0.5))
    temp = calculator.asDouble("cos(3.92699)")
    #expect(temp.similar(to: -0.7071))
    temp = calculator.asDouble("sin(5.7596)")
    #expect(temp.similar(to: -0.5))
    temp = calculator.asDouble("sin(6.2832)")
    #expect(temp.similar(to: 0))
    temp = calculator.asDouble("cos(4.7124)")
    #expect(temp.similar(to: 0))
    temp = calculator.asDouble("atan(0.0)")
    #expect(temp.similar(to: 0))
    temp = calculator.asDouble("atan(1.0)")
    #expect(temp.similar(to: 0.7854))
    temp = calculator.asDouble("acos(0.8660)")
    #expect(temp.similar(to: 0.5236))
    temp = calculator.asDouble("asin(0.5)")
    #expect(temp.similar(to: 0.5236))
    temp = calculator.asDouble("atan(-1.0)")
    #expect(temp.similar(to: -0.7854))
    temp = calculator.asDouble("asin(0.8660)")
    #expect(temp.similar(to: 1.0472))
    #expect(calculator.evaluateString("acos(1.0)").string == "0")
    #expect(calculator.evaluateString("sin(0.0)").string == "0")
    temp = calculator.asDouble("sin(0.7854)")
    #expect(temp.similar(to: 0.7071))
    temp = calculator.asDouble("cos(1.5708)")
    #expect(temp.similar(to: 0.0))
    temp = calculator.asDouble("tan(1.0472)")
    #expect(temp.similar(to: 1.7321))
    temp = calculator.asDouble("sin(0.5236)")
    #expect(temp.similar(to: 0.5))
    temp = calculator.asDouble("tan(0.5236)")
    #expect(temp.similar(to: 0.5774))
    temp = calculator.asDouble("cos(1.0472)")
    #expect(temp.similar(to: 0.5))
    temp = calculator.asDouble("sin(2.0944)")
    #expect(temp.similar(to: 0.8660))
    temp = calculator.asDouble("tan(3.1416)")
    #expect(temp.similar(to: 0.0))
    temp = calculator.asDouble("sin(2.6180)")
    #expect(temp.similar(to: 0.5))
    temp = calculator.asDouble("cos(5.23599)")
    #expect(temp.similar(to: 0.5))
    temp = calculator.asDouble("cos(2.0944)")
    #expect(temp.similar(to: -0.5))
    temp = calculator.asDouble("cos(5.7596)")
    #expect(temp.similar(to: 0.8660))
    temp = calculator.asDouble("asin(1.0)")
    #expect(temp.similar(to: 1.5708))
    temp = calculator.asDouble("acos(0.0)")
    #expect(temp.similar(to: 1.5708))
    temp = calculator.asDouble("acos(0.7071)")
    #expect(temp.similar(to: 0.7854))
    temp = calculator.asDouble("atan(0.5774)")
    #expect(temp.similar(to: 0.5236))
}
