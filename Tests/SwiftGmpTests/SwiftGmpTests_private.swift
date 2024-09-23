import Testing
@testable import SwiftGmp

@Test func number() async throws {
    let number = Number("1", precision: 20)
    #expect(number.str == "1")
}
