// Note: This file is automatically generated.
//       It will be overwritten sooner or later.

import Testing
@testable import SwiftGmp

@Test func basics2BcTest() {
    let calculator = Calculator(precision: 100)

    var swiftGmp, bc: SwiftGmp

    swiftGmp = calculator.asSwiftGmp("2 ^ 3 * 4")
    bc = calculator.asSwiftGmp("32")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("2 * 3 ^ 4")
    bc = calculator.asSwiftGmp("162")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    // 16 sqrty 4 --> bc = error
    // 5 + 16 sqrty 4 --> bc = error
    // 9 * 16 sqrty 4 --> bc = error
    // 3 ^ 16 sqrty 4 --> bc = error
    swiftGmp = calculator.asSwiftGmp("2 ^ 3")
    bc = calculator.asSwiftGmp("8")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    // 16 sqrty 4 --> bc = error
    // 2 powyx 3 --> bc = error
    // 2 + 3 * 9 sqrty 3 - 2 ^ 4 --> bc = error
    // 4 powyx 3 + 12 / 9 sqrty 3 --> bc = error
    // 9 * 3 ^ 2 + 16 sqrty 4 --> bc = error
    // 25 logy 5 + 4 ^ 2 --> bc = error
    // 2 ^ 3 * 81 sqrty 9 - 9 --> bc = error
    // 16 sqrty 4 ^ 2 + 9 * 25 logy 5 / 64 sqrty 4 --> bc = error
    // 4 powyx 3 * 5 + 9 sqrty 25 logy 5 - 81 sqrty 9 --> bc = error
    // 8 powyx 3 / 16 sqrty 81 sqrty 9 + 5 ^ 3 --> bc = error
    // 9 powyx 4 / 25 logy 5 - 81 sqrty 16 ^ 3 powyx 4 --> bc = error
    // 25 logy 5 * 9 sqrty 3 + 4 ^ 2 / 81 sqrty 9 * 2 powyx 3 --> bc = error
    // 64 sqrty 9 powyx 2 * 25 logy 5 ^ 4 / 8 powyx 4 + 81 sqrty 9 --> bc = error
    // 4 ^ 5 + 25 logy 5 * 16 sqrty 9 powyx 2 + 81 sqrty 9 --> bc = error
    // 81 sqrty 64 sqrty 4 ^ 2 + 9 powyx 4 / 25 logy 16 ^ 2 --> bc = error
    // 9 powyx 5 + 4 sqrty 64 ^ 2 * 16 sqrty 9 ^ 2 + 25 logy 5 --> bc = error
    swiftGmp = calculator.asSwiftGmp("1500 + 2000")
    bc = calculator.asSwiftGmp("3500")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1 + 2")
    bc = calculator.asSwiftGmp("3")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("-1 + 1.0000")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("10.1 + 2")
    bc = calculator.asSwiftGmp("12.1")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("10 + 9.9999")
    bc = calculator.asSwiftGmp("19.9999")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("34.999 + 1.0")
    bc = calculator.asSwiftGmp("35.999")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("-5 + 0")
    bc = calculator.asSwiftGmp("-5")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("0 + 5")
    bc = calculator.asSwiftGmp("5")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("-5 + 5")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("300000000 + 900000000")
    bc = calculator.asSwiftGmp("1200000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("900000000 + 900000000")
    bc = calculator.asSwiftGmp("1800000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("999999999 + 1")
    bc = calculator.asSwiftGmp("1000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("-1987.50 + 1987")
    bc = calculator.asSwiftGmp("-.50")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 - 2000")
    bc = calculator.asSwiftGmp("-500")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("6 * 2 + 8")
    bc = calculator.asSwiftGmp("20")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 - 2000 + 0.25")
    bc = calculator.asSwiftGmp("-499.75")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 - 2000 + 1.23456789")
    bc = calculator.asSwiftGmp("-498.76543211")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 - 2000 + 123456789")
    bc = calculator.asSwiftGmp("123456289")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 - 2000")
    bc = calculator.asSwiftGmp("-500")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("9 - 3")
    bc = calculator.asSwiftGmp("6")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("-3 - 0")
    bc = calculator.asSwiftGmp("-3")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("3 - 0")
    bc = calculator.asSwiftGmp("3")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("-1 - 2.25")
    bc = calculator.asSwiftGmp("-3.25")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 - 2000")
    bc = calculator.asSwiftGmp("-500")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("6 * 2")
    bc = calculator.asSwiftGmp("12")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("9.35 - 1")
    bc = calculator.asSwiftGmp("8.35")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("9 - 1.35")
    bc = calculator.asSwiftGmp("7.65")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("0.29 - 1.35")
    bc = calculator.asSwiftGmp("-1.06")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("7.1234567 - 2.2109876")
    bc = calculator.asSwiftGmp("4.9124691")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1000 + - 10.99")
    bc = calculator.asSwiftGmp("989.01")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("50 + - 60")
    bc = calculator.asSwiftGmp("-10")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("-5 + - 20")
    bc = calculator.asSwiftGmp("-25")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 - 2000")
    bc = calculator.asSwiftGmp("-500")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("-1.33 - 2")
    bc = calculator.asSwiftGmp("-3.33")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("123456789 - 210987654")
    bc = calculator.asSwiftGmp("-87530865")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("7.12345678 - 2.21098765")
    bc = calculator.asSwiftGmp("4.91246913")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 - 2000")
    bc = calculator.asSwiftGmp("-500")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 - 2000")
    bc = calculator.asSwiftGmp("-500")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 * 2000")
    bc = calculator.asSwiftGmp("3000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("6 * 2")
    bc = calculator.asSwiftGmp("12")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1.212 * 8")
    bc = calculator.asSwiftGmp("9.696")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("3 * 1.212")
    bc = calculator.asSwiftGmp("3.636")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("0.133 * 1.212")
    bc = calculator.asSwiftGmp(".161196")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 * 0")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("-1500 * 2000")
    bc = calculator.asSwiftGmp("-3000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("-1.212 * 8")
    bc = calculator.asSwiftGmp("-9.696")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("-8 * 1.212")
    bc = calculator.asSwiftGmp("-9.696")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 - 2000")
    bc = calculator.asSwiftGmp("-500")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 - 2000")
    bc = calculator.asSwiftGmp("-500")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("6 * 2")
    bc = calculator.asSwiftGmp("12")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1.23456789 * 2.10987654")
    bc = calculator.asSwiftGmp("2.6047858281483006")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("123456789 * 210987654")
    bc = calculator.asSwiftGmp("26047858281483006")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 - 2000")
    bc = calculator.asSwiftGmp("-500")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 - 2000")
    bc = calculator.asSwiftGmp("-500")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("0 * 6 * 6")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1500 / 2000")
    bc = calculator.asSwiftGmp(".7500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("6 / 2")
    bc = calculator.asSwiftGmp("3.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("0 / 2000")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("-1500 / 2000")
    bc = calculator.asSwiftGmp("-.7500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("-3.123 / 5")
    bc = calculator.asSwiftGmp("-.6246000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("-5 / 3.123")
    bc = calculator.asSwiftGmp("-1.6010246557796990073647134165866154338776817162984309958373358949727825808517451168747998719180275376")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("4.21 / 3")
    bc = calculator.asSwiftGmp("1.4033333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("10 / 3.123")
    bc = calculator.asSwiftGmp("3.2020493115593980147294268331732308677553634325968619916746717899455651617034902337495997438360550752")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("0.234 / 3.123")
    bc = calculator.asSwiftGmp(".0749279538904899135446685878962536023054755043227665706051873198847262247838616714697406340057636887")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("(1500 - 2000) / 3.12")
    bc = calculator.asSwiftGmp("-160.2564102564102564102564102564102564102564102564102564102564102564102564102564102564102564102564102564")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("(1500 - 2000) / 312")
    bc = calculator.asSwiftGmp("-1.6025641025641025641025641025641025641025641025641025641025641025641025641025641025641025641025641025")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("(6 * 2) / 8")
    bc = calculator.asSwiftGmp("1.5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    // 1500 / 0 --> bc = error
    // 6 / 0 --> bc = error
    // -6 / 0 --> bc = error
    swiftGmp = calculator.asSwiftGmp("1.23456789 / 2.10987654")
    bc = calculator.asSwiftGmp(".5851375028796708645331446739532920727200464535237687414638962713903629640813011741435828278369311599")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("(1500 - 2000) / 1234.56789")
    bc = calculator.asSwiftGmp("-.4050000036855000335380503051962577772859457733021065370491694871474423330417252306796995991852663525")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("(1500 - 2000) / 123456789")
    bc = calculator.asSwiftGmp("-.0000040500000368550003353805030519625777728594577330210653704916948714744233304172523067969959918526")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
// -12.3 C ~= error
// 12.3 C ~= error
// -123 C ~= error
// 123 C ~= error
// 123456789 C C C ~= error
// 1234.56789 C ~= error
// -1234.56789 C ~= error
// -123456789 C ~= error
// 123456789 C ~= error
    swiftGmp = calculator.asSwiftGmp(".11111")
    bc = calculator.asSwiftGmp(".11111")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("0000")
    bc = calculator.asSwiftGmp("0")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("000.11111")
    bc = calculator.asSwiftGmp(".11111")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("06")
    bc = calculator.asSwiftGmp("6")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("6 * 06")
    bc = calculator.asSwiftGmp("36")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1111.11111")
    bc = calculator.asSwiftGmp("1111.11111")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("123.567")
    bc = calculator.asSwiftGmp("123.567")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("0.6")
    bc = calculator.asSwiftGmp(".6")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp(".6")
    bc = calculator.asSwiftGmp(".6")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("6 * 0.6")
    bc = calculator.asSwiftGmp("3.6")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("6 * .6")
    bc = calculator.asSwiftGmp("3.6")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("1.1")
    bc = calculator.asSwiftGmp("1.1")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("12.3456789")
    bc = calculator.asSwiftGmp("12.3456789")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
    swiftGmp = calculator.asSwiftGmp("0123456789")
    bc = calculator.asSwiftGmp("123456789")
    #expect(swiftGmp.similar(to: bc, precision: 1e-96))
}
