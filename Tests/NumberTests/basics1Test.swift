// Note: This file is automatically generated.
//       It will be overwritten sooner or later.

import Testing
import SwiftGmp

@Test func basics1Test() {
    let calculator = Calculator(precision: 20)
    var temp: Double = 0.0

    #expect(calculator.asString("1 + 3 * 10") == "31.0")
    #expect(calculator.asString("1 + 2") == "3.0")
    #expect(calculator.asString("2 * 4") == "8.0")
    #expect(calculator.asString("3 / 0") == "inf")
    #expect(calculator.asString("10/2") == "5.0")
    temp = calculator.asDouble("-5.0 abs")
    #expect(temp.similarTo(5.0))
    temp = calculator.asDouble("3.14 abs")
    #expect(temp.similarTo(3.14))
    temp = calculator.asDouble("0.0 abs")
    #expect(temp.similarTo(0.0))
    temp = calculator.asDouble("-100.25 abs")
    #expect(temp.similarTo(100.25))
    temp = calculator.asDouble("12.5 abs")
    #expect(temp.similarTo(12.5))
    temp = calculator.asDouble("4.0 sqrt")
    #expect(temp.similarTo(2.0))
    temp = calculator.asDouble("9.0 sqrt")
    #expect(temp.similarTo(3.0))
    temp = calculator.asDouble("0.0 sqrt")
    #expect(temp.similarTo(0.0))
    temp = calculator.asDouble("16.0 sqrt")
    #expect(temp.similarTo(4.0))
    temp = calculator.asDouble("25.0 sqrt")
    #expect(temp.similarTo(5.0))
    temp = calculator.asDouble("8.0 sqrt3")
    #expect(temp.similarTo(2.0))
    temp = calculator.asDouble("27.0 sqrt3")
    #expect(temp.similarTo(3.0))
    temp = calculator.asDouble("0.0 sqrt3")
    #expect(temp.similarTo(0.0))
    temp = calculator.asDouble("64.0 sqrt3")
    #expect(temp.similarTo(4.0))
    temp = calculator.asDouble("125.0 sqrt3")
    #expect(temp.similarTo(5.0))
    #expect(calculator.asString("1 zeta") == "inf")
    temp = calculator.asDouble("2 zeta")
    #expect(temp.similarTo(1.6449340668482264))
    temp = calculator.asDouble("3 zeta")
    #expect(temp.similarTo(1.2020569031595942))
    temp = calculator.asDouble("4 zeta")
    #expect(temp.similarTo(1.0823232337111381))
    temp = calculator.asDouble("5 zeta")
    #expect(temp.similarTo(1.0369277551433699))
    temp = calculator.asDouble("6 zeta")
    #expect(temp.similarTo(1.0173430619844490))
    temp = calculator.asDouble("7 zeta")
    #expect(temp.similarTo(1.0083492773819228))
    temp = calculator.asDouble("8 zeta")
    #expect(temp.similarTo(1.0040773561979440))
    temp = calculator.asDouble("9 zeta")
    #expect(temp.similarTo(1.0020083928260822))
    temp = calculator.asDouble("1.0 ln")
    #expect(temp.similarTo(0.0))
    temp = calculator.asDouble("2.7183 ln")
    #expect(temp.similarTo(1.0))
    temp = calculator.asDouble("7.3891 ln")
    #expect(temp.similarTo(2.0))
    temp = calculator.asDouble("20.0855 ln")
    #expect(temp.similarTo(3.0))
    temp = calculator.asDouble("54.5982 ln")
    #expect(temp.similarTo(4.0))
    temp = calculator.asDouble("1.0 log10")
    #expect(temp.similarTo(0.0))
    temp = calculator.asDouble("10.0 log10")
    #expect(temp.similarTo(1.0))
    temp = calculator.asDouble("100.0 log10")
    #expect(temp.similarTo(2.0))
    temp = calculator.asDouble("1000.0 log10")
    #expect(temp.similarTo(3.0))
    temp = calculator.asDouble("10000.0 log10")
    #expect(temp.similarTo(4.0))
    temp = calculator.asDouble("1.0 log2")
    #expect(temp.similarTo(0.0))
    temp = calculator.asDouble("2.0 log2")
    #expect(temp.similarTo(1.0))
    temp = calculator.asDouble("4.0 log2")
    #expect(temp.similarTo(2.0))
    temp = calculator.asDouble("8.0 log2")
    #expect(temp.similarTo(3.0))
    temp = calculator.asDouble("16.0 log2")
    #expect(temp.similarTo(4.0))
    temp = calculator.asDouble("2.0 sqr")
    #expect(temp.similarTo(4.0))
    temp = calculator.asDouble("3.0 sqr")
    #expect(temp.similarTo(9.0))
    temp = calculator.asDouble("5.0 sqr")
    #expect(temp.similarTo(25.0))
    temp = calculator.asDouble("-4.0 sqr")
    #expect(temp.similarTo(16.0))
    temp = calculator.asDouble("10.0 sqr")
    #expect(temp.similarTo(100.0))
    temp = calculator.asDouble("1.0 exp")
    #expect(temp.similarTo(2.7183))
    temp = calculator.asDouble("2.0 exp")
    #expect(temp.similarTo(7.3891))
    temp = calculator.asDouble("3.0 exp")
    #expect(temp.similarTo(20.0855))
    temp = calculator.asDouble("0.0 exp")
    #expect(temp.similarTo(1.0))
    temp = calculator.asDouble("-1.0 exp")
    #expect(temp.similarTo(0.3679))
    temp = calculator.asDouble("0.0 exp10")
    #expect(temp.similarTo(1.0))
    temp = calculator.asDouble("1.0 exp10")
    #expect(temp.similarTo(10.0))
    temp = calculator.asDouble("2.0 exp10")
    #expect(temp.similarTo(100.0))
    temp = calculator.asDouble("3.0 exp10")
    #expect(temp.similarTo(1000.0))
    temp = calculator.asDouble("-1.0 exp10")
    #expect(temp.similarTo(0.1))
    temp = calculator.asDouble("0.0 +/-")
    #expect(temp.similarTo(0.0))
    #expect(calculator.asString("0.0 +/-") == "0.0")
    #expect(calculator.asString("0.0 +/-") == "0.0")
    #expect(calculator.asString("0.0 +/-") == "0.0")
    #expect(calculator.asString("0.0 +/-") == "0.0")
    #expect(calculator.asString("0.0 +/-") == "0.0")
    temp = calculator.asDouble("5.0 +/-")
    #expect(calculator.asString("0.0 +/-") == "0.0")
    #expect(calculator.asString("0.0 +/-") == "0.0")
    #expect(calculator.asString("0.0 +/-") == "0.0")
    #expect(calculator.asString("0.0 +/-") == "0.0")
    #expect(calculator.asString("0.0 +/-") == "0.0")
    #expect(temp.similarTo(-5.0))
    temp = calculator.asDouble("5.0 +/-")
    #expect(temp.similarTo(-5.0))
    temp = calculator.asDouble("5.0 +/-")
    #expect(temp.similarTo(-5.0))
    temp = calculator.asDouble("5.0 +/-")
    #expect(temp.similarTo(-5.0))
    temp = calculator.asDouble("5.0 +/-")
    #expect(temp.similarTo(-5.0))
    temp = calculator.asDouble("5.0 +/-")
    #expect(temp.similarTo(-5.0))
    temp = calculator.asDouble("5.0 +/-")
    #expect(temp.similarTo(-5.0))
    temp = calculator.asDouble("-3.14 +/-")
    #expect(temp.similarTo(3.14))
    temp = calculator.asDouble("0.0 +/-")
    #expect(temp.similarTo(0.0))
    temp = calculator.asDouble("100.0 +/-")
    #expect(temp.similarTo(-100.0))
    temp = calculator.asDouble("-50.0 +/-")
    #expect(temp.similarTo(50.0))
    temp = calculator.asDouble("2.0 cubed")
    #expect(temp.similarTo(8.0))
    temp = calculator.asDouble("3.0 cubed")
    #expect(temp.similarTo(27.0))
    temp = calculator.asDouble("-4.0 cubed")
    #expect(temp.similarTo(-64.0))
    temp = calculator.asDouble("5.0 cubed")
    #expect(temp.similarTo(125.0))
    temp = calculator.asDouble("-2.0 cubed")
    #expect(temp.similarTo(-8.0))
    temp = calculator.asDouble("0.0 exp2")
    #expect(temp.similarTo(1.0))
    temp = calculator.asDouble("1.0 exp2")
    #expect(temp.similarTo(2.0))
    temp = calculator.asDouble("2.0 exp2")
    #expect(temp.similarTo(4.0))
    temp = calculator.asDouble("3.0 exp2")
    #expect(temp.similarTo(8.0))
    temp = calculator.asDouble("4.0 exp2")
    #expect(temp.similarTo(16.0))
    temp = calculator.asDouble("2.0 rez")
    #expect(temp.similarTo(0.5))
    temp = calculator.asDouble("4.0 rez")
    #expect(temp.similarTo(0.25))
    temp = calculator.asDouble("0.5 rez")
    #expect(temp.similarTo(2.0))
    temp = calculator.asDouble("10.0 rez")
    #expect(temp.similarTo(0.1))
    temp = calculator.asDouble("0.2 rez")
    #expect(temp.similarTo(5.0))
    temp = calculator.asDouble("0.0 fac")
    #expect(temp.similarTo(1.0))
    temp = calculator.asDouble("1.0 fac")
    #expect(temp.similarTo(1.0))
    temp = calculator.asDouble("2.0 fac")
    #expect(temp.similarTo(2.0))
    temp = calculator.asDouble("30 sinD")
    #expect(temp.similarTo(0.5))
    temp = calculator.asDouble("45 sinD")
    #expect(temp.similarTo(0.7071))
    temp = calculator.asDouble("60 sinD")
    #expect(temp.similarTo(0.8660))
    #expect(calculator.asString("90 sinD") == "1.0")
    #expect(calculator.asString("0 sinD") == "0.0")
    temp = calculator.asDouble("180 sinD")
    #expect(temp.similarTo(0.0))
    #expect(calculator.asString("270 sinD") == "-1.0")
    temp = calculator.asDouble("30 cosD")
    #expect(temp.similarTo(0.8660))
    temp = calculator.asDouble("45 cosD")
    #expect(temp.similarTo(0.7071))
    temp = calculator.asDouble("60 cosD")
    #expect(temp.similarTo(0.5))
    temp = calculator.asDouble("90 cosD")
    #expect(temp.similarTo(0.0))
    #expect(calculator.asString("45 tanD") == "1.0")
    temp = calculator.asDouble("60 tanD")
    #expect(temp.similarTo(1.7321))
    temp = calculator.asDouble("30 tanD")
    #expect(temp.similarTo(0.5774))
    #expect(calculator.asString("0 tanD") == "0.0")
    #expect(calculator.asString("0 asinD") == "0.0")
    #expect(calculator.asString("0 acosD") == "90.0")
    #expect(calculator.asString("0.5 asinD") == "30.0")
    #expect(calculator.asString("0.5 acosD") == "60.0")
    #expect(calculator.asString("1 atanD") == "45.0")
    #expect(calculator.asString("0 atanD") == "0.0")
    temp = calculator.asDouble("1.5708 sin")
    #expect(temp.similarTo(1.0))
    temp = calculator.asDouble("0.5236 cos")
    #expect(temp.similarTo(0.8660))
    temp = calculator.asDouble("1.0472 sin")
    #expect(temp.similarTo(0.8660))
    temp = calculator.asDouble("0.7854 tan")
    #expect(temp.similarTo(1.0))
    temp = calculator.asDouble("2.3562 sin")
    #expect(temp.similarTo(0.7071))
    temp = calculator.asDouble("2.6180 cos")
    #expect(temp.similarTo(-0.8660))
    temp = calculator.asDouble("3.1416 sin")
    #expect(temp.similarTo(0.0))
    temp = calculator.asDouble("3.1416 cos")
    #expect(temp.similarTo(-1.0))
    temp = calculator.asDouble("3.6652 sin")
    #expect(temp.similarTo(-0.5))
    temp = calculator.asDouble("3.92699 cos")
    #expect(temp.similarTo(-0.7071))
    temp = calculator.asDouble("5.7596 sin")
    #expect(temp.similarTo(-0.5))
    temp = calculator.asDouble("6.2832 sin")
    #expect(temp.similarTo(0.0))
    temp = calculator.asDouble("4.7124 cos")
    #expect(temp.similarTo(0.0))
    temp = calculator.asDouble("0.0 atan")
    #expect(temp.similarTo(0.0))
    temp = calculator.asDouble("1.0 atan")
    #expect(temp.similarTo(0.7854))
    temp = calculator.asDouble("0.8660 acos")
    #expect(temp.similarTo(0.5236))
    temp = calculator.asDouble("0.5 asin")
    #expect(temp.similarTo(0.5236))
    temp = calculator.asDouble("-1.0 atan")
    #expect(temp.similarTo(-0.7854))
    temp = calculator.asDouble("0.8660 asin")
    #expect(temp.similarTo(1.0472))
    #expect(calculator.asString("1.0 acos") == "0.0")
    #expect(calculator.asString("0.0 sin") == "0.0")
    temp = calculator.asDouble("0.7854 sin")
    #expect(temp.similarTo(0.7071))
    temp = calculator.asDouble("1.5708 cos")
    #expect(temp.similarTo(0.0))
    temp = calculator.asDouble("1.0472 tan")
    #expect(temp.similarTo(1.7321))
    temp = calculator.asDouble("0.5236 sin")
    #expect(temp.similarTo(0.5))
    temp = calculator.asDouble("0.5236 tan")
    #expect(temp.similarTo(0.5774))
    temp = calculator.asDouble("1.0472 cos")
    #expect(temp.similarTo(0.5))
    temp = calculator.asDouble("2.0944 sin")
    #expect(temp.similarTo(0.8660))
    temp = calculator.asDouble("3.1416 tan")
    #expect(temp.similarTo(0.0))
    temp = calculator.asDouble("2.6180 sin")
    #expect(temp.similarTo(0.5))
    temp = calculator.asDouble("5.23599 cos")
    #expect(temp.similarTo(0.5))
    temp = calculator.asDouble("2.0944 cos")
    #expect(temp.similarTo(-0.5))
    temp = calculator.asDouble("5.7596 cos")
    #expect(temp.similarTo(0.8660))
    temp = calculator.asDouble("1.0 asin")
    #expect(temp.similarTo(1.5708))
    temp = calculator.asDouble("0.0 acos")
    #expect(temp.similarTo(1.5708))
    temp = calculator.asDouble("0.7071 acos")
    #expect(temp.similarTo(0.7854))
    temp = calculator.asDouble("0.5774 atan")
    #expect(temp.similarTo(0.5236))
}
