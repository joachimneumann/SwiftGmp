//
//  testCommandParser.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 26.09.24.
//


import Testing
import SwiftGmp

@Test func testCommandParser() {
    let commandParser = CommandParser()
    #expect(commandParser.parse("1 + 2 =") == "3")
}
