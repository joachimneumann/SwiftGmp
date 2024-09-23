//
//  SwiftGmpTests_public.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 23.09.24.
//

import Testing
import SwiftGmp

@Test func brain() async throws {
    let brain = Brain(precision: 20)
    brain.operation(SwiftGmpConstants.pi)
    #expect(brain.str().hasPrefix("3.1415926"))
}
