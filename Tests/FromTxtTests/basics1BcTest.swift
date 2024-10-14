// Note: This file is automatically generated.
//       It will be overwritten sooner or later.

import Testing
@testable import SwiftGmp

@Test func basics1BcTest() {
    let calculator = Calculator(precision: 100)

    var swiftGmp, bc: SwiftGmp

    swiftGmp = calculator.asSwiftGmp("pi")
    bc = calculator.asSwiftGmp("3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170676")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("1.1 * 1")
    bc = calculator.asSwiftGmp("1.1")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("1 + 3 * 10")
    bc = calculator.asSwiftGmp("31")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("1 + 2")
    bc = calculator.asSwiftGmp("3")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("2 * 4")
    bc = calculator.asSwiftGmp("8")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    // 3 / 0 --> bc = error
    swiftGmp = calculator.asSwiftGmp("10/2")
    bc = calculator.asSwiftGmp("5.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("abs(-5.0)")
    bc = calculator.asSwiftGmp("5.0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("abs(3.14)")
    bc = calculator.asSwiftGmp("3.14")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("abs(0.0)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("500 + 500")
    bc = calculator.asSwiftGmp("1000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("abs(-100.25)")
    bc = calculator.asSwiftGmp("100.25")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("abs(12.5)")
    bc = calculator.asSwiftGmp("12.5")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("153.4 - 153")
    bc = calculator.asSwiftGmp(".4")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("153.4 - 152")
    bc = calculator.asSwiftGmp("1.4")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("153.4 - 142")
    bc = calculator.asSwiftGmp("11.4")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("153.4 - 154")
    bc = calculator.asSwiftGmp("-.6")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("153.4 - 155")
    bc = calculator.asSwiftGmp("-1.6")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("153.4 - 165")
    bc = calculator.asSwiftGmp("-11.6")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("1 / 7")
    bc = calculator.asSwiftGmp(".1428571428571428571428571428571428571428571428571428571428571428571428571428571428571428571428571428")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
// 10 % = 0.1
// 200 + 20 % = 240
// 100 + e % ~= 102.7183
// 0.1 % = 0.001
    swiftGmp = calculator.asSwiftGmp("pi")
    bc = calculator.asSwiftGmp("3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170676")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sqrt(4.0)")
    bc = calculator.asSwiftGmp("2.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sqrt(9.0)")
    bc = calculator.asSwiftGmp("3.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sqrt(0.0)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sqrt(16.0)")
    bc = calculator.asSwiftGmp("4.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sqrt(25.0)")
    bc = calculator.asSwiftGmp("5.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    // sqrt(-1) --> bc = error
    swiftGmp = calculator.asSwiftGmp("sqrt3(8.0)")
    bc = calculator.asSwiftGmp("1.9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999997")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sqrt3(27.0)")
    bc = calculator.asSwiftGmp("2.9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999994")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sqrt3(0.0)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sqrt3(64.0)")
    bc = calculator.asSwiftGmp("3.9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999992")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sqrt3(125.0)")
    bc = calculator.asSwiftGmp("4.9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999990")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    // zeta(1) --> bc = error
    // zeta(2) --> bc = error
    // zeta(3) --> bc = error
    // zeta(4) --> bc = error
    // zeta(5) --> bc = error
    // zeta(6) --> bc = error
    // zeta(7) --> bc = error
    // zeta(8) --> bc = error
    // zeta(9) --> bc = error
    swiftGmp = calculator.asSwiftGmp("ln(1.0)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("ln(2.7183)")
    bc = calculator.asSwiftGmp("1.0000066849139875754930648506609216030129660300529110849369288885729397140401980122036136073053181427")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("ln(7.3891)")
    bc = calculator.asSwiftGmp("2.0000059413460050105437570424626773344678953072890899998262530848974192346610363196414208171647363814")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("ln(20.0855)")
    bc = calculator.asSwiftGmp("2.9999981617010415562166476691105276627401980852800693080478902682117285661201955265373168551180026112")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("ln(54.5982)")
    bc = calculator.asSwiftGmp("4.0000009151744677502315144192733857336399049733159706846546417432382636514766056126444711375248889582")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("log10(1.0)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("log10(10.0)")
    bc = calculator.asSwiftGmp("1.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("log10(100.0)")
    bc = calculator.asSwiftGmp("2.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("log10(1000.0)")
    bc = calculator.asSwiftGmp("3.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("log10(10000.0)")
    bc = calculator.asSwiftGmp("4.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("log2(1.0)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("log2(2.0)")
    bc = calculator.asSwiftGmp("1.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("log2(4.0)")
    bc = calculator.asSwiftGmp("2.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("log2(8.0)")
    bc = calculator.asSwiftGmp("3.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("log2(16.0)")
    bc = calculator.asSwiftGmp("4.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sqr(2.0)")
    bc = calculator.asSwiftGmp("4.00")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sqr(3.0)")
    bc = calculator.asSwiftGmp("9.00")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sqr(5.0)")
    bc = calculator.asSwiftGmp("25.00")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sqr(-4.0)")
    bc = calculator.asSwiftGmp("16.00")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sqr(10.0)")
    bc = calculator.asSwiftGmp("100.00")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("exp(1.0)")
    bc = calculator.asSwiftGmp("2.7182818284590452353602874713526624977572470936999595749669676277240766303535475945713821785251664274")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("exp(2.0)")
    bc = calculator.asSwiftGmp("7.3890560989306502272304274605750078131803155705518473240871278225225737960790577633843124850791217947")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("exp(3.0)")
    bc = calculator.asSwiftGmp("20.0855369231876677409285296545817178969879078385541501443789342296988458780919737312044971602530177021")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("exp(0.0)")
    bc = calculator.asSwiftGmp("1.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("exp(-1.0)")
    bc = calculator.asSwiftGmp(".3678794411714423215955237701614608674458111310317678345078368016974614957448998033571472743459196437")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("exp10(0.0)")
    bc = calculator.asSwiftGmp("1.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("exp10(1.0)")
    bc = calculator.asSwiftGmp("9.9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999995")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("exp10(2.0)")
    bc = calculator.asSwiftGmp("99.9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999916")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("exp10(3.0)")
    bc = calculator.asSwiftGmp("999.9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999998740")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("exp10(-1.0)")
    bc = calculator.asSwiftGmp(".1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
// 0.0 ± ~= 0
// 0.0 ± = 0
// 5.0 ± ~= -5
// -3.14 ± ~= 3.14
// 0.0 ± ~= 0
// 100.0 ± ~= -100
// -50.0 ± ~= 50
    swiftGmp = calculator.asSwiftGmp("cubed(2.0)")
    bc = calculator.asSwiftGmp("8.000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cubed(3.0)")
    bc = calculator.asSwiftGmp("27.000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cubed(-4.0)")
    bc = calculator.asSwiftGmp("-64.000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cubed(5.0)")
    bc = calculator.asSwiftGmp("125.000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cubed(-2.0)")
    bc = calculator.asSwiftGmp("-8.000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("rez(2.0)")
    bc = calculator.asSwiftGmp(".5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("rez(4.0)")
    bc = calculator.asSwiftGmp(".2500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("rez(0.5)")
    bc = calculator.asSwiftGmp("2.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("rez(10.0)")
    bc = calculator.asSwiftGmp(".1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("rez(0.2)")
    bc = calculator.asSwiftGmp("5.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("fac(0.0)")
    bc = calculator.asSwiftGmp("1")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("fac(1.0)")
    bc = calculator.asSwiftGmp("1.0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("fac(2.0)")
    bc = calculator.asSwiftGmp("2.00")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sind(30)")
    bc = calculator.asSwiftGmp(".4999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999996")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sind(45)")
    bc = calculator.asSwiftGmp(".7071067811865475244008443621048490392848359376884740365883398689953662392310535194251937671638207863")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sind(60)")
    bc = calculator.asSwiftGmp(".8660254037844386467637231707529361834714026269051903140279034897259665084544000185405730933786242876")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sind(90)")
    bc = calculator.asSwiftGmp(".9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sind(0)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sind(180)")
    bc = calculator.asSwiftGmp(".0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sind(270)")
    bc = calculator.asSwiftGmp("-1.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cosd(30)")
    bc = calculator.asSwiftGmp(".8660254037844386467637231707529361834714026269051903140279034897259665084544000185405730933786242880")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cosd(45)")
    bc = calculator.asSwiftGmp(".7071067811865475244008443621048490392848359376884740365883398689953662392310535194251937671638207864")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cosd(60)")
    bc = calculator.asSwiftGmp(".5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cosd(90)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("tand(45)")
    bc = calculator.asSwiftGmp("1")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("tand(60)")
    bc = calculator.asSwiftGmp("1.7320508075688772935274463415058723669428052538103806280558069794519330169088000370811461867572485745")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("tand(30)")
    bc = calculator.asSwiftGmp(".5773502691896257645091487805019574556476017512701268760186023264839776723029333456937153955857495246")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("tand(0)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("asind(0)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("acosd(0)")
    bc = calculator.asSwiftGmp("90.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("asind(0.5)")
    bc = calculator.asSwiftGmp("29.9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999880")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("acosd(0.5)")
    bc = calculator.asSwiftGmp("59.9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999940")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("atand(1)")
    bc = calculator.asSwiftGmp("45.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("atand(0)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sin(1.5708)")
    bc = calculator.asSwiftGmp(".9999999999932537821342563234857847001743304120374337812494883680051519712937182457946440263532983356")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cos(0.5236)")
    bc = calculator.asSwiftGmp(".8660247915829389283384407643242925178539024367942734768094595442045602220812252720779572636629132488")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sin(1.0472)")
    bc = calculator.asSwiftGmp(".8660266281835431519956993530308367577416296372812884243247960262327375752781245260456940324297627567")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("tan(0.7854)")
    bc = calculator.asSwiftGmp("1.0000036732118496151546287584164831789502130208301067495501132342461422790890141802892431353695322434")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sin(2.3562)")
    bc = calculator.asSwiftGmp(".7071028851534584428505913687388526151310398516589677194699291666930666512573523578594808516100901569")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cos(2.6180)")
    bc = calculator.asSwiftGmp("-.8660284647724625670304347917872670690611499486026485311689230040983165836622864318341773025563099164")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sin(3.1416)")
    bc = calculator.asSwiftGmp("-.0000073464102066954567115689093426895397402737433045270762986435085570222303457897762151582195191647")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cos(3.1416)")
    bc = calculator.asSwiftGmp("-.9999999999730151285371163168541229590289166749878117700756418525009258205156424954701138410888016930")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sin(3.6652)")
    bc = calculator.asSwiftGmp("-.5000074225224784945135950280501222756528728949457678979657395483476949283777749677264979649089011890")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cos(3.92699)")
    bc = calculator.asSwiftGmp("-.7071073588835301802460784696103700126688651828854291675347059952884450705452582198582049070749440130")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sin(5.7596)")
    bc = calculator.asSwiftGmp("-.4999883359618970362190362570501673164558007581324079304274287974145520240335201120581080328650313696")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sin(6.2832)")
    bc = calculator.asSwiftGmp(".0000146928204129944295528552313853322233386399759195921303936186082432291543274571882523373639908740")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cos(4.7124)")
    bc = calculator.asSwiftGmp(".0000110196153099192838578894703775826559296094792780761512233351977263763190703037559868846708958564")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("atan(0.0)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("atan(1.0)")
    bc = calculator.asSwiftGmp(".7853981633974483096156608458198757210492923498437764552437361480769541015715522496570087063355292669")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("acos(0.8660)")
    bc = calculator.asSwiftGmp(".5236495809318289131223595214463915095259620913138472158232556675180791904602499524877306156936079483")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("asin(0.5)")
    bc = calculator.asSwiftGmp(".5235987755982988730771072305465838140328615665625176368291574320513027343810348331046724708903528446")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("atan(-1.0)")
    bc = calculator.asSwiftGmp("-.7853981633974483096156608458198757210492923498437764552437361480769541015715522496570087063355292669")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("asin(0.8660)")
    bc = calculator.asSwiftGmp("1.0471467458630677061089621701933599325726226083737056946642166286358290126828545468262867969774505856")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("acos(1.0)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sin(0.0)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sin(0.7854)")
    bc = calculator.asSwiftGmp(".7071080798594735943581292183798443298351436848627626149538671129811230923092860037336763909392885892")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cos(1.5708)")
    bc = calculator.asSwiftGmp("-.0000036732051033725085976773671369635609390781796037460247302542243622036589134530380939997831506541")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("tan(1.0472)")
    bc = calculator.asSwiftGmp("1.7320606028240324321812416171202994673228837255420550075558584310450992175828737936877453304464044060")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sin(0.5236)")
    bc = calculator.asSwiftGmp(".5000010603626028226505930991964310868555919434712695295756064864507603958509972040009407165498169520")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("tan(0.5236)")
    bc = calculator.asSwiftGmp(".5773519017263813222456071733666963500925683024516430227628357396492827363138466351086275915674736633")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cos(1.0472)")
    bc = calculator.asSwiftGmp(".4999978792725456169998841491040422896050577062141272017069531414439047048565378527074618714416416780")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sin(2.0944)")
    bc = calculator.asSwiftGmp(".8660229549706499208388746425661699271636076917528088859981368437814651717498076691803554054617977564")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("tan(3.1416)")
    bc = calculator.asSwiftGmp(".0000073464102068936986467155525258514533007027965474038199521028074481953554638635670279032242957356")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("sin(2.6180)")
    bc = calculator.asSwiftGmp(".4999946981757422220972104047608444619820934497966392326297372764578270907228760134005639493033797873")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cos(5.23599)")
    bc = calculator.asSwiftGmp(".5000019433744793788654608712776096796091801065658075513906335165695842918359448756146926378592570400")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cos(2.0944)")
    bc = calculator.asSwiftGmp("-.5000042414459137961286841021173413401003447579804523733898594157885876656179320631592377021130492613")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("cos(5.7596)")
    bc = calculator.asSwiftGmp(".8660321379152468721122620348368575487189770509497502948785503862632706182690463226537576002250626371")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("asin(1.0)")
    bc = calculator.asSwiftGmp("1.5707963267948966192313216916397514420985846996875529104874722961539082031431044993140174126710585338")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("acos(0.0)")
    bc = calculator.asSwiftGmp("1.5707963267948966192313216916397514420985846996875529104874722961539082031431044993140174126710585338")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("acos(0.7071)")
    bc = calculator.asSwiftGmp(".7854077533974488975983802764893854295523704516776097406633213109669146040599202372167600430602496466")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
    swiftGmp = calculator.asSwiftGmp("atan(0.5774)")
    bc = calculator.asSwiftGmp(".5236360729028993908629265643815666584178920230044926414831936878053734414854100192077458291546081662")
    #expect(swiftGmp.similar(to: bc, precision: 1e-100))
}