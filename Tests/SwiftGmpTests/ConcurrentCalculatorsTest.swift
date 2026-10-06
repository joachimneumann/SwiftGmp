import Testing
@testable import SwiftGmp

@Test func concurrentCalculators() async {
    await withTaskGroup(of: Void.self) { group in
        for index in 0..<16 {
            group.addTask {
                let calculator = Calculator(precision: index.isMultiple(of: 2) ? 100 : 1000)
                for _ in 0..<10 {
                    calculator.evaluateString("1e48+1-1e48")
                    #expect(calculator.string == "1")

                    calculator.evaluateString("sqrt(pi^2)")
                    #expect(calculator.double.similar(to: Double.pi))

                    calculator.evaluateString("sind(30)")
                    #expect(calculator.double.similar(to: 0.5))
                }
            }
        }
    }
}
