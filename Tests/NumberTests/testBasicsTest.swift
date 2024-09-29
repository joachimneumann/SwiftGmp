// Note: This file is automatically generated.
//       It will be overwritten sooner or later.

import Testing
import SwiftGmp

@Test func testBasicsTest() {
    let calculator = Calculator(precision: 20)
    var result: String

    #expect(calculator.calc("1 + 2") == "3.0")
    #expect(calculator.calc("2 * 4") == "8.0")
    #expect(calculator.calc("3 / 0") == "inf")
    #expect(calculator.calc("10/2") == "5.0")
    result = calculator.calc("-5.0 abs")
    if let d = Double(result) {
        #expect(d.similarTo(Double("5.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("3.14 abs")
    if let d = Double(result) {
        #expect(d.similarTo(Double("3.14")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.0 abs")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("-100.25 abs")
    if let d = Double(result) {
        #expect(d.similarTo(Double("100.25")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("12.5 abs")
    if let d = Double(result) {
        #expect(d.similarTo(Double("12.5")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("4.0 sqrt")
    if let d = Double(result) {
        #expect(d.similarTo(Double("2.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("9.0 sqrt")
    if let d = Double(result) {
        #expect(d.similarTo(Double("3.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.0 sqrt")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("16.0 sqrt")
    if let d = Double(result) {
        #expect(d.similarTo(Double("4.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("25.0 sqrt")
    if let d = Double(result) {
        #expect(d.similarTo(Double("5.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("8.0 sqrt3")
    if let d = Double(result) {
        #expect(d.similarTo(Double("2.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("27.0 sqrt3")
    if let d = Double(result) {
        #expect(d.similarTo(Double("3.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.0 sqrt3")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("64.0 sqrt3")
    if let d = Double(result) {
        #expect(d.similarTo(Double("4.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("125.0 sqrt3")
    if let d = Double(result) {
        #expect(d.similarTo(Double("5.0")!))
    } else {
        #expect(result == "valid")
    }
    #expect(calculator.calc("1 zeta") == "inf")
    result = calculator.calc("2 zeta")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.6449340668482264")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("3 zeta")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.2020569031595942")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("4 zeta")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0823232337111381")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("5 zeta")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0369277551433699")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("6 zeta")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0173430619844490")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("7 zeta")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0083492773819228")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("8 zeta")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0040773561979440")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("9 zeta")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0020083928260822")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("1.0 ln")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("2.7183 ln")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("7.3891 ln")
    if let d = Double(result) {
        #expect(d.similarTo(Double("2.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("20.0855 ln")
    if let d = Double(result) {
        #expect(d.similarTo(Double("3.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("54.5982 ln")
    if let d = Double(result) {
        #expect(d.similarTo(Double("4.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("1.0 log10")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("10.0 log10")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("100.0 log10")
    if let d = Double(result) {
        #expect(d.similarTo(Double("2.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("1000.0 log10")
    if let d = Double(result) {
        #expect(d.similarTo(Double("3.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("10000.0 log10")
    if let d = Double(result) {
        #expect(d.similarTo(Double("4.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("1.0 log2")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("2.0 log2")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("4.0 log2")
    if let d = Double(result) {
        #expect(d.similarTo(Double("2.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("8.0 log2")
    if let d = Double(result) {
        #expect(d.similarTo(Double("3.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("16.0 log2")
    if let d = Double(result) {
        #expect(d.similarTo(Double("4.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("2.0 sqr")
    if let d = Double(result) {
        #expect(d.similarTo(Double("4.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("3.0 sqr")
    if let d = Double(result) {
        #expect(d.similarTo(Double("9.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("5.0 sqr")
    if let d = Double(result) {
        #expect(d.similarTo(Double("25.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("-4.0 sqr")
    if let d = Double(result) {
        #expect(d.similarTo(Double("16.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("10.0 sqr")
    if let d = Double(result) {
        #expect(d.similarTo(Double("100.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("1.0 exp")
    if let d = Double(result) {
        #expect(d.similarTo(Double("2.7183")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("2.0 exp")
    if let d = Double(result) {
        #expect(d.similarTo(Double("7.3891")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("3.0 exp")
    if let d = Double(result) {
        #expect(d.similarTo(Double("20.0855")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.0 exp")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("-1.0 exp")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.3679")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.0 exp10")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("1.0 exp10")
    if let d = Double(result) {
        #expect(d.similarTo(Double("10.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("2.0 exp10")
    if let d = Double(result) {
        #expect(d.similarTo(Double("100.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("3.0 exp10")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1000.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("-1.0 exp10")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.1")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("5.0 changeSign")
    if let d = Double(result) {
        #expect(d.similarTo(Double("-5.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("-3.14 changeSign")
    if let d = Double(result) {
        #expect(d.similarTo(Double("3.14")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.0 changeSign")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("100.0 changeSign")
    if let d = Double(result) {
        #expect(d.similarTo(Double("-100.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("-50.0 changeSign")
    if let d = Double(result) {
        #expect(d.similarTo(Double("50.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("2.0 cubed")
    if let d = Double(result) {
        #expect(d.similarTo(Double("8.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("3.0 cubed")
    if let d = Double(result) {
        #expect(d.similarTo(Double("27.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("-4.0 cubed")
    if let d = Double(result) {
        #expect(d.similarTo(Double("-64.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("5.0 cubed")
    if let d = Double(result) {
        #expect(d.similarTo(Double("125.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("-2.0 cubed")
    if let d = Double(result) {
        #expect(d.similarTo(Double("-8.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.0 exp2")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("1.0 exp2")
    if let d = Double(result) {
        #expect(d.similarTo(Double("2.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("2.0 exp2")
    if let d = Double(result) {
        #expect(d.similarTo(Double("4.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("3.0 exp2")
    if let d = Double(result) {
        #expect(d.similarTo(Double("8.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("4.0 exp2")
    if let d = Double(result) {
        #expect(d.similarTo(Double("16.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("2.0 rez")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.5")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("4.0 rez")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.25")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.5 rez")
    if let d = Double(result) {
        #expect(d.similarTo(Double("2.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("10.0 rez")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.1")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.2 rez")
    if let d = Double(result) {
        #expect(d.similarTo(Double("5.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.0 fac")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("1.0 fac")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("2.0 fac")
    if let d = Double(result) {
        #expect(d.similarTo(Double("2.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("30 sinD")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.5")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("45 sinD")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.7071")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("60 sinD")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.8660")!))
    } else {
        #expect(result == "valid")
    }
    #expect(calculator.calc("90 sinD") == "1.0")
    #expect(calculator.calc("0 sinD") == "0.0")
    result = calculator.calc("180 sinD")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    #expect(calculator.calc("270 sinD") == "-1.0")
    result = calculator.calc("30 cosD")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.8660")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("45 cosD")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.7071")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("60 cosD")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.5")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("90 cosD")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    #expect(calculator.calc("45 tanD") == "1.0")
    result = calculator.calc("60 tanD")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.7321")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("30 tanD")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.5774")!))
    } else {
        #expect(result == "valid")
    }
    #expect(calculator.calc("0 tanD") == "0.0")
    #expect(calculator.calc("0 asinD") == "0.0")
    #expect(calculator.calc("0 acosD") == "90.0")
    #expect(calculator.calc("0.5 asinD") == "30.0")
    #expect(calculator.calc("0.5 acosD") == "60.0")
    #expect(calculator.calc("1 atanD") == "45.0")
    #expect(calculator.calc("0 atanD") == "0.0")
    result = calculator.calc("1.5708 sin")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.5236 cos")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.8660")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("1.0472 sin")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.8660")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.7854 tan")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("2.3562 sin")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.7071")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("2.6180 cos")
    if let d = Double(result) {
        #expect(d.similarTo(Double("-0.8660")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("3.1416 sin")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("3.1416 cos")
    if let d = Double(result) {
        #expect(d.similarTo(Double("-1.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("3.6652 sin")
    if let d = Double(result) {
        #expect(d.similarTo(Double("-0.5")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("3.92699 cos")
    if let d = Double(result) {
        #expect(d.similarTo(Double("-0.7071")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("5.7596 sin")
    if let d = Double(result) {
        #expect(d.similarTo(Double("-0.5")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("6.2832 sin")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("4.7124 cos")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.0 atan")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("1.0 atan")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.7854")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.8660 acos")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.5236")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.5 asin")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.5236")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("-1.0 atan")
    if let d = Double(result) {
        #expect(d.similarTo(Double("-0.7854")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.8660 asin")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.0472")!))
    } else {
        #expect(result == "valid")
    }
    #expect(calculator.calc("1.0 acos") == "0.0")
    #expect(calculator.calc("0.0 sin") == "0.0")
    result = calculator.calc("0.7854 sin")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.7071")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("1.5708 cos")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("1.0472 tan")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.7321")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.5236 sin")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.5")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.5236 tan")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.5774")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("1.0472 cos")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.5")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("2.0944 sin")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.8660")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("3.1416 tan")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.0")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("2.6180 sin")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.5")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("5.23599 cos")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.5")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("2.0944 cos")
    if let d = Double(result) {
        #expect(d.similarTo(Double("-0.5")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("5.7596 cos")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.8660")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("1.0 asin")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.5708")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.0 acos")
    if let d = Double(result) {
        #expect(d.similarTo(Double("1.5708")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.7071 acos")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.7854")!))
    } else {
        #expect(result == "valid")
    }
    result = calculator.calc("0.5774 atan")
    if let d = Double(result) {
        #expect(d.similarTo(Double("0.5236")!))
    } else {
        #expect(result == "valid")
    }
}
