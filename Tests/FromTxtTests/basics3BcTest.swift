// Note: This file is automatically generated.
//       It will be overwritten sooner or later.

import Testing
@testable import SwiftGmp

@Test func basics3BcTest() {
    let calculator = Calculator(precision: 100)

    var swiftGmp, bc: SwiftGmp

    swiftGmp = calculator.asSwiftGmp("sqr(4.0)")
    bc = calculator.asSwiftGmp("16.00")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("sqr(2.0)")
    bc = calculator.asSwiftGmp("4.00")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("cubed(5.0)")
    bc = calculator.asSwiftGmp("125.000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("cubed(2.0)")
    bc = calculator.asSwiftGmp("8.000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("exp(1.0)")
    bc = calculator.asSwiftGmp("2.7182818284590452353602874713526624977572470936999595749669676277240766303535475945713821785251664274")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("exp(2.0)")
    bc = calculator.asSwiftGmp("7.3890560989306502272304274605750078131803155705518473240871278225225737960790577633843124850791217947")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("exp10(1.0)")
    bc = calculator.asSwiftGmp("9.9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999995")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("exp10(2.0)")
    bc = calculator.asSwiftGmp("99.9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999916")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
// 1.0 ± = -1
// -1.0 ± = 1
    swiftGmp = calculator.asSwiftGmp("rez(2.0)")
    bc = calculator.asSwiftGmp(".5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("rez(4.0)")
    bc = calculator.asSwiftGmp(".2500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("fac(5.0)")
    bc = calculator.asSwiftGmp("120.00000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("fac(3.0)")
    bc = calculator.asSwiftGmp("6.000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("0")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("pi")
    bc = calculator.asSwiftGmp("3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170676")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("e")
    bc = calculator.asSwiftGmp("2.7182818284590452353602874713526624977572470936999595749669676277240766303535475945713821785251664274")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("abs(-3.0)")
    bc = calculator.asSwiftGmp("3.0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("sqrt(9.0)")
    bc = calculator.asSwiftGmp("3.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("sqrt3(8.0)")
    bc = calculator.asSwiftGmp("1.9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999997")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("sqrt(2.0)")
    bc = calculator.asSwiftGmp("1.4142135623730950488016887242096980785696718753769480731766797379907324784621070388503875343276415727")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    // zeta(3.0) --> bc = error
    swiftGmp = calculator.asSwiftGmp("ln(1.0)")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("ln(2.0)")
    bc = calculator.asSwiftGmp(".6931471805599453094172321214581765680755001343602552541206800094933936219696947156058633269964186875")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("log10(10.0)")
    bc = calculator.asSwiftGmp("1.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("log10(100.0)")
    bc = calculator.asSwiftGmp("2.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("log2(8.0)")
    bc = calculator.asSwiftGmp("3.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("log2(16.0)")
    bc = calculator.asSwiftGmp("4.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
}
