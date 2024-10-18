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
    temp = calculator.evaluateString("1 / 7").double
    #expect(temp.similar(to: 0.1428571))
    #expect(calculator.evaluateString("10 %").string == "0.1")
    #expect(calculator.evaluateString("200 + 20 %").string == "240")
    temp = calculator.evaluateString("100 + e %").double
    #expect(temp.similar(to: 102.7183))
    #expect(calculator.evaluateString("0.1 %").string == "0.001")
    temp = calculator.evaluateString("pi").double
    #expect(temp.similar(to: 3.14159))
    temp = calculator.evaluateString("sqrt(4.0)").double
    #expect(temp.similar(to: 2))
    temp = calculator.evaluateString("sqrt(9.0)").double
    #expect(temp.similar(to: 3))
    temp = calculator.evaluateString("sqrt(0.0)").double
    #expect(temp.similar(to: 0))
    temp = calculator.evaluateString("sqrt(16.0)").double
    #expect(temp.similar(to: 4))
    temp = calculator.evaluateString("sqrt(25.0)").double
    #expect(temp.similar(to: 5))
    #expect(calculator.evaluateString("sqrt(-1)").string == "not a number")
    temp = calculator.evaluateString("sqrt3(8.0)").double
    #expect(temp.similar(to: 2))
    temp = calculator.evaluateString("sqrt3(27.0)").double
    #expect(temp.similar(to: 3))
    temp = calculator.evaluateString("sqrt3(0.0)").double
    #expect(temp.similar(to: 0))
    temp = calculator.evaluateString("sqrt3(64.0)").double
    #expect(temp.similar(to: 4))
    temp = calculator.evaluateString("sqrt3(125.0)").double
    #expect(temp.similar(to: 5))
    #expect(calculator.evaluateString("zeta(1)").string == "inf")
    temp = calculator.evaluateString("zeta(2)").double
    #expect(temp.similar(to: 1.6449340668482264))
    temp = calculator.evaluateString("zeta(3)").double
    #expect(temp.similar(to: 1.2020569031595942))
    temp = calculator.evaluateString("zeta(4)").double
    #expect(temp.similar(to: 1.0823232337111381))
    temp = calculator.evaluateString("zeta(5)").double
    #expect(temp.similar(to: 1.0369277551433699))
    temp = calculator.evaluateString("zeta(6)").double
    #expect(temp.similar(to: 1.0173430619844490))
    temp = calculator.evaluateString("zeta(7)").double
    #expect(temp.similar(to: 1.0083492773819228))
    temp = calculator.evaluateString("zeta(8)").double
    #expect(temp.similar(to: 1.0040773561979440))
    temp = calculator.evaluateString("zeta(9)").double
    #expect(temp.similar(to: 1.0020083928260822))
    temp = calculator.evaluateString("ln(1.0)").double
    #expect(temp.similar(to: 0))
    temp = calculator.evaluateString("ln(2.7183)").double
    #expect(temp.similar(to: 1.0))
    temp = calculator.evaluateString("ln(7.3891)").double
    #expect(temp.similar(to: 2.0))
    temp = calculator.evaluateString("ln(20.0855)").double
    #expect(temp.similar(to: 3.0))
    temp = calculator.evaluateString("ln(54.5982)").double
    #expect(temp.similar(to: 4.0))
    temp = calculator.evaluateString("log10(1.0)").double
    #expect(temp.similar(to: 0))
    temp = calculator.evaluateString("log10(10.0)").double
    #expect(temp.similar(to: 1))
    temp = calculator.evaluateString("log10(100.0)").double
    #expect(temp.similar(to: 2))
    temp = calculator.evaluateString("log10(1000.0)").double
    #expect(temp.similar(to: 3))
    temp = calculator.evaluateString("log10(10000.0)").double
    #expect(temp.similar(to: 4))
    temp = calculator.evaluateString("log2(1.0)").double
    #expect(temp.similar(to: 0))
    temp = calculator.evaluateString("log2(2.0)").double
    #expect(temp.similar(to: 1))
    temp = calculator.evaluateString("log2(4.0)").double
    #expect(temp.similar(to: 2))
    temp = calculator.evaluateString("log2(8.0)").double
    #expect(temp.similar(to: 3))
    temp = calculator.evaluateString("log2(16.0)").double
    #expect(temp.similar(to: 4))
    temp = calculator.evaluateString("sqr(2.0)").double
    #expect(temp.similar(to: 4))
    temp = calculator.evaluateString("sqr(3.0)").double
    #expect(temp.similar(to: 9))
    temp = calculator.evaluateString("sqr(5.0)").double
    #expect(temp.similar(to: 25))
    temp = calculator.evaluateString("sqr(-4.0)").double
    #expect(temp.similar(to: 16))
    temp = calculator.evaluateString("sqr(10.0)").double
    #expect(temp.similar(to: 100))
    temp = calculator.evaluateString("exp(1.0)").double
    #expect(temp.similar(to: 2.7183))
    temp = calculator.evaluateString("exp(2.0)").double
    #expect(temp.similar(to: 7.3891))
    temp = calculator.evaluateString("exp(3.0)").double
    #expect(temp.similar(to: 20.0855))
    #expect(calculator.evaluateString("exp(0.0)").string == "1")
    temp = calculator.evaluateString("exp(-1.0)").double
    #expect(temp.similar(to: 0.3679))
    temp = calculator.evaluateString("exp10(0.0)").double
    #expect(temp.similar(to: 1))
    temp = calculator.evaluateString("exp10(1.0)").double
    #expect(temp.similar(to: 10))
    temp = calculator.evaluateString("exp10(2.0)").double
    #expect(temp.similar(to: 100))
    temp = calculator.evaluateString("exp10(3.0)").double
    #expect(temp.similar(to: 1000))
    temp = calculator.evaluateString("exp10(-1.0)").double
    #expect(temp.similar(to: 0.1))
    temp = calculator.evaluateString("0.0 ±").double
    #expect(temp.similar(to: 0))
    #expect(calculator.evaluateString("0.0 ±").string == "0")
    temp = calculator.evaluateString("5.0 ±").double
    #expect(temp.similar(to: -5))
    temp = calculator.evaluateString("-3.14 ±").double
    #expect(temp.similar(to: 3.14))
    temp = calculator.evaluateString("0.0 ±").double
    #expect(temp.similar(to: 0))
    temp = calculator.evaluateString("100.0 ±").double
    #expect(temp.similar(to: -100))
    temp = calculator.evaluateString("-50.0 ±").double
    #expect(temp.similar(to: 50))
    temp = calculator.evaluateString("cubed(2.0)").double
    #expect(temp.similar(to: 8))
    temp = calculator.evaluateString("cubed(3.0)").double
    #expect(temp.similar(to: 27))
    temp = calculator.evaluateString("cubed(-4.0)").double
    #expect(temp.similar(to: -64))
    temp = calculator.evaluateString("cubed(5.0)").double
    #expect(temp.similar(to: 125))
    temp = calculator.evaluateString("cubed(-2.0)").double
    #expect(temp.similar(to: -8))
    temp = calculator.evaluateString("rez(2.0)").double
    #expect(temp.similar(to: 0.5))
    temp = calculator.evaluateString("rez(4.0)").double
    #expect(temp.similar(to: 0.25))
    temp = calculator.evaluateString("rez(0.5)").double
    #expect(temp.similar(to: 2))
    temp = calculator.evaluateString("rez(10.0)").double
    #expect(temp.similar(to: 0.1))
    temp = calculator.evaluateString("rez(0.2)").double
    #expect(temp.similar(to: 5))
    temp = calculator.evaluateString("fac(0.0)").double
    #expect(temp.similar(to: 1))
    temp = calculator.evaluateString("fac(1.0)").double
    #expect(temp.similar(to: 1))
    temp = calculator.evaluateString("fac(2.0)").double
    #expect(temp.similar(to: 2))
    temp = calculator.evaluateString("sind(30)").double
    #expect(temp.similar(to: 0.5))
    temp = calculator.evaluateString("sind(45)").double
    #expect(temp.similar(to: 0.7071))
    temp = calculator.evaluateString("sind(60)").double
    #expect(temp.similar(to: 0.8660))
    #expect(calculator.evaluateString("sind(90)").string == "1")
    #expect(calculator.evaluateString("sind(0)").string == "0")
    temp = calculator.evaluateString("sind(180)").double
    #expect(temp.similar(to: 0))
    #expect(calculator.evaluateString("sind(270)").string == "-1")
    temp = calculator.evaluateString("cosd(30)").double
    #expect(temp.similar(to: 0.8660))
    temp = calculator.evaluateString("cosd(45)").double
    #expect(temp.similar(to: 0.7071))
    temp = calculator.evaluateString("cosd(60)").double
    #expect(temp.similar(to: 0.5))
    temp = calculator.evaluateString("cosd(90)").double
    #expect(temp.similar(to: 0))
    #expect(calculator.evaluateString("tand(45)").string == "1")
    temp = calculator.evaluateString("tand(60)").double
    #expect(temp.similar(to: 1.7321))
    temp = calculator.evaluateString("tand(30)").double
    #expect(temp.similar(to: 0.5774))
    #expect(calculator.evaluateString("tand(0)").string == "0")
    #expect(calculator.evaluateString("asind(0)").string == "0")
    #expect(calculator.evaluateString("acosd(0)").string == "90")
    #expect(calculator.evaluateString("asind(0.5)").string == "30")
    #expect(calculator.evaluateString("acosd(0.5)").string == "60")
    #expect(calculator.evaluateString("atand(1)").string == "45")
    #expect(calculator.evaluateString("atand(0)").string == "0")
    temp = calculator.evaluateString("sin(1.5708)").double
    #expect(temp.similar(to: 1))
    temp = calculator.evaluateString("cos(0.5236)").double
    #expect(temp.similar(to: 0.8660))
    temp = calculator.evaluateString("sin(1.0472)").double
    #expect(temp.similar(to: 0.8660))
    temp = calculator.evaluateString("tan(0.7854)").double
    #expect(temp.similar(to: 1))
    temp = calculator.evaluateString("sin(2.3562)").double
    #expect(temp.similar(to: 0.7071))
    temp = calculator.evaluateString("cos(2.6180)").double
    #expect(temp.similar(to: -0.8660))
    temp = calculator.evaluateString("sin(3.1416)").double
    #expect(temp.similar(to: 0))
    temp = calculator.evaluateString("cos(3.1416)").double
    #expect(temp.similar(to: -1))
    temp = calculator.evaluateString("sin(3.6652)").double
    #expect(temp.similar(to: -0.5))
    temp = calculator.evaluateString("cos(3.92699)").double
    #expect(temp.similar(to: -0.7071))
    temp = calculator.evaluateString("sin(5.7596)").double
    #expect(temp.similar(to: -0.5))
    temp = calculator.evaluateString("sin(6.2832)").double
    #expect(temp.similar(to: 0))
    temp = calculator.evaluateString("cos(4.7124)").double
    #expect(temp.similar(to: 0))
    temp = calculator.evaluateString("atan(0.0)").double
    #expect(temp.similar(to: 0))
    temp = calculator.evaluateString("atan(1.0)").double
    #expect(temp.similar(to: 0.7854))
    temp = calculator.evaluateString("acos(0.8660)").double
    #expect(temp.similar(to: 0.5236))
    temp = calculator.evaluateString("asin(0.5)").double
    #expect(temp.similar(to: 0.5236))
    temp = calculator.evaluateString("atan(-1.0)").double
    #expect(temp.similar(to: -0.7854))
    temp = calculator.evaluateString("asin(0.8660)").double
    #expect(temp.similar(to: 1.0472))
    #expect(calculator.evaluateString("acos(1.0)").string == "0")
    #expect(calculator.evaluateString("sin(0.0)").string == "0")
    temp = calculator.evaluateString("sin(0.7854)").double
    #expect(temp.similar(to: 0.7071))
    temp = calculator.evaluateString("cos(1.5708)").double
    #expect(temp.similar(to: 0.0))
    temp = calculator.evaluateString("tan(1.0472)").double
    #expect(temp.similar(to: 1.7321))
    temp = calculator.evaluateString("sin(0.5236)").double
    #expect(temp.similar(to: 0.5))
    temp = calculator.evaluateString("tan(0.5236)").double
    #expect(temp.similar(to: 0.5774))
    temp = calculator.evaluateString("cos(1.0472)").double
    #expect(temp.similar(to: 0.5))
    temp = calculator.evaluateString("sin(2.0944)").double
    #expect(temp.similar(to: 0.8660))
    temp = calculator.evaluateString("tan(3.1416)").double
    #expect(temp.similar(to: 0.0))
    temp = calculator.evaluateString("sin(2.6180)").double
    #expect(temp.similar(to: 0.5))
    temp = calculator.evaluateString("cos(5.23599)").double
    #expect(temp.similar(to: 0.5))
    temp = calculator.evaluateString("cos(2.0944)").double
    #expect(temp.similar(to: -0.5))
    temp = calculator.evaluateString("cos(5.7596)").double
    #expect(temp.similar(to: 0.8660))
    temp = calculator.evaluateString("asin(1.0)").double
    #expect(temp.similar(to: 1.5708))
    temp = calculator.evaluateString("acos(0.0)").double
    #expect(temp.similar(to: 1.5708))
    temp = calculator.evaluateString("acos(0.7071)").double
    #expect(temp.similar(to: 0.7854))
    temp = calculator.evaluateString("atan(0.5774)").double
    #expect(temp.similar(to: 0.5236))
}
