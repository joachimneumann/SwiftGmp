//
//  Token.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 30.09.24.
//

import Foundation

enum TokenizerError: Error, LocalizedError {
    case unknownOperator(op: String)
    case invalidSwiftGmp(swiftGmp: SwiftGmp)
    case unprocessed(op: String)
    case unexpectedSwiftGmp(swiftGmp: SwiftGmp)
    case memoryEmpty
    case invalidNumberCharacter(char: Character)
    
    var errorDescription: String? {
        switch self {
        case .unknownOperator(let op):
            return "Unknown operator: \(op)"
        case .invalidSwiftGmp(let swiftGmp):
            return "Invalid swiftGmp: \(swiftGmp)"
        case .unprocessed(let op):
            return "unknown: \(op)"
        case .memoryEmpty:
            return "memory empty"
        case .unexpectedSwiftGmp(let swiftGmp):
            return "unexpected swiftGmp: \(swiftGmp)"
        case .invalidNumberCharacter(let char):
            return "invalid number character: \(char)"
        }
    }
}

extension Array {
    var secondLast: Element? {
        if count > 1 { return self[count - 2] }
        return nil
    }
}
extension Array {
    var thirdLast: Element? {
        if count > 2 { return self[count - 3] }
        return nil
    }
}


class Token {
    var tokens: [OneToken] = []
    var precision: Int

    enum TokenEnum {
        case inPlace(InplaceOperation)       // sin, log, etc
        case clear
        case equal
        case percent
        case twoOperant(TwoOperantOperation) // +, -, *, /, x^y, etc
        case swiftGmp(SwiftGmp)                          // -5.3
        case parenthesesLeft
        case parenthesesRight
    }

    class OneToken: CustomDebugStringConvertible, Equatable, Identifiable {
        let id: UUID = UUID()
        static func == (lhs: Token.OneToken, rhs: Token.OneToken) -> Bool {
            lhs.id == rhs.id
        }
    
        let tokenEnum: TokenEnum

        var debugDescription: String {
            switch tokenEnum {
            case .inPlace(let op):
                "inPlace \(op.getRawValue())"
            case .twoOperant(let op):
                "twoOperant \(op.getRawValue())"
            case .swiftGmp(let s):
                "swiftGmp \(String(s.toDouble()))"
            case .parenthesesLeft:
                "("
            case .parenthesesRight:
                ")"
            case .clear:
                "C"
            case .equal:
                "="
            case .percent:
                "%"
            }
        }
        init(tokenEnum: TokenEnum) {
            self.tokenEnum = tokenEnum
        }
    }

    
    
    func setPrecision(_ newPrecision: Int) {
        self.precision = newPrecision
        // TODO: set bits
        for token in tokens {
            if case .swiftGmp(let swiftGmp) = token.tokenEnum {
                swiftGmp.setBits(generousBits(for: newPrecision))
            }
        }
    }
    
    let allOperationsSorted: [any OpProtocol]
    
    func clear() {
        tokens = []
    }
    
    func percent() {
        //         this operation in an inplace operation, but if no number is found
        //         it creates a zero out of thin air and then oerates on the zero.
        let _001 = SwiftGmp(withString: "0.01", bits: generousBits(for: precision))
        if let n1 = lastSwiftGmp {
            if let n2 = secondLastSwiftGmp {
                if hasTwoOperant {
                    n1.execute(.mul, other: _001)
                    n1.execute(.mul, other: n2)
                }
            } else {
                n1.execute(.mul, other: _001)
            }
        }
    }
    
    init(precision: Int) {
        self.precision = precision
        let x1: [InplaceOperation] = InplaceOperation.allCases
        let x2: [TwoOperantOperation] = TwoOperantOperation.allCases
        let x3: [ConstantOperation] = ConstantOperation.allCases
        let x4: [ClearOperation] = ClearOperation.allCases
        let x5: [EqualOperation] = EqualOperation.allCases
        let x6: [ParenthesisOperation] = ParenthesisOperation.allCases
        let x7: [PercentOperation] = PercentOperation.allCases
        var allOperationsUnsorted: [any OpProtocol] = []
        allOperationsUnsorted.append(contentsOf: x1)
        allOperationsUnsorted.append(contentsOf: x2)
        allOperationsUnsorted.append(contentsOf: x3)
        allOperationsUnsorted.append(contentsOf: x4)
        allOperationsUnsorted.append(contentsOf: x5)
        allOperationsUnsorted.append(contentsOf: x6)
        allOperationsUnsorted.append(contentsOf: x7)
        allOperationsSorted = allOperationsUnsorted.sorted { $0.getRawValue().count > $1.getRawValue().count }
    }
    //
    var numberExpected: Bool {
        guard !tokens.isEmpty else { return true }
        switch tokens.last!.tokenEnum {
        case .inPlace(_):
            return false
        case .twoOperant(_):
            return true
        case .swiftGmp(_):
            return false
        case .parenthesesLeft:
            return true
        case .parenthesesRight:
            return false
        case .clear:
            return true
        case .equal:
            return true
        case .percent:
            return false
        }
    }
    
    var pendingOperators: [any OpProtocol] {
        var ret: [any OpProtocol] = []
        for token in tokens {
            if case .inPlace(let op) = token.tokenEnum {
                ret.append(op)
            }
            if case .twoOperant(let op) = token.tokenEnum {
                ret.append(op)
            }
        }
        return ret
    }
    
    var inPlaceAllowed: Bool {
        !numberExpected
    }
    
    func dropLastSwiftGmp() {
        guard !tokens.isEmpty else { return }
        
        // check from the end
        for index in stride(from: tokens.count - 1, through: 0, by: -1) {
            if case .swiftGmp(_) = tokens[index].tokenEnum {
                tokens.remove(at: index)
            }
        }
        return
    }
    
    var lastSwiftGmp: SwiftGmp? {
        guard !tokens.isEmpty else { return nil }
        
        // check from the end
        for index in stride(from: tokens.count - 1, through: 0, by: -1) {
            if case .swiftGmp(let last) = tokens[index].tokenEnum {
                return last
            }
        }
        return nil
    }
    
    var secondLastSwiftGmp: SwiftGmp? {
        guard !tokens.isEmpty else { return nil }
        
        // check from the end
        var oneFound = false
        for index in stride(from: tokens.count - 1, through: 0, by: -1) {
            if case .swiftGmp(let last) = tokens[index].tokenEnum {
                if oneFound {
                    return last
                } else {
                    oneFound = true
                }
            }
        }
        return nil
    }
    
    var hasTwoOperant: Bool {
        guard !tokens.isEmpty else { return false }
        
        // check from the end
        for index in stride(from: tokens.count - 1, through: 0, by: -1) {
            if case .twoOperant = tokens[index].tokenEnum {
                return true
            }
        }
        return false
    }
    
    func removeLastSwiftGmp() {
        guard !tokens.isEmpty else { return }
        
        // check from the end
        for index in stride(from: tokens.count - 1, through: 0, by: -1) {
            if case .swiftGmp(_) = tokens[index].tokenEnum {
                tokens.remove(at: index)
                return
            }
        }
        return
    }
    
    func walkThroughTokens(tokens: inout [OneToken]) {
        
        // firstly, detect if there is a pair of open and closed parenthesis
        // if yes, collapse these into a number
        
        for index in 0..<tokens.count { print("token[\(index)] = \(tokens[index])") }
        for rightIndex in 0..<tokens.count {
            if case .parenthesesRight = tokens[rightIndex].tokenEnum {
                print("rightIndex = \(rightIndex)")
                for leftIndex in (0..<rightIndex).reversed() {
                    if case .parenthesesLeft = tokens[leftIndex].tokenEnum {
                        print("leftIndex = \(leftIndex)")
                        print("Parenthesis operations:")
                        var tokensInParenthesis: [OneToken] = []
                        for parenthesisIndex in (leftIndex+1)..<rightIndex {
                            tokensInParenthesis.append(tokens[parenthesisIndex])
                            print(tokens[parenthesisIndex])
                        }
                        walkThroughTokens(tokens: &tokensInParenthesis)
                        guard case .swiftGmp(let s) = tokensInParenthesis.first?.tokenEnum else { fatalError("No SwiftGmp found") }
                        for index in 0..<tokens.count { print("token[\(index)] = \(tokens[index])") }
                        tokens[rightIndex] = OneToken(tokenEnum: .swiftGmp(s))
                        tokens.removeSubrange(leftIndex..<rightIndex)
                        for index in 0..<tokens.count { print("token[\(index)] = \(tokens[index])") }
                        return
                    }
                }
            }
        }
        for index in 0..<tokens.count { print("token[\(index)] = \(tokens[index])") }

        
        var priority = 2
        for token in tokens {
            guard let before = tokens.element(before: token) else { continue }
            guard let after = tokens.element(after: token) else { continue }
            guard case .twoOperant(let twoOperantOperation) = token.tokenEnum else { continue }
            guard case .swiftGmp(let beforeSwiftGmp) = before.tokenEnum else { continue }
            guard case .swiftGmp(let afterSwiftGmp) = after.tokenEnum else { continue }
            guard twoOperantOperation.operatorPriority == priority else { continue }
            beforeSwiftGmp.execute(twoOperantOperation, other: afterSwiftGmp)
            tokens = tokens.filter { $0 != after }
            tokens = tokens.filter { $0 != token }
        }
        var hasPriority2 = false
        for token in tokens {
            guard case .twoOperant(let twoOperantOperation) = token.tokenEnum else { continue }
            if twoOperantOperation.operatorPriority == 2 {
                hasPriority2 = true
            }
        }
        if !hasPriority2 {
            priority = 1
            for token in tokens {
                guard let before = tokens.element(before: token) else { continue }
                guard let after = tokens.element(after: token) else { continue }
                guard case .twoOperant(let twoOperantOperation) = token.tokenEnum else { continue }
                guard case .swiftGmp(let beforeSwiftGmp) = before.tokenEnum else { continue }
                guard case .swiftGmp(let afterSwiftGmp) = after.tokenEnum else { continue }
                guard twoOperantOperation.operatorPriority == priority else { continue }

                beforeSwiftGmp.execute(twoOperantOperation, other: afterSwiftGmp)
                tokens = tokens.filter { $0 != after }
                tokens = tokens.filter { $0 != token }
            }
        }
    }
        
    func newToken(_ constant: ConstantOperation) {
        if numberExpected {
            let temp = SwiftGmp(withString: "0", bits: generousBits(for: precision))
            temp.execute(constant)
            tokens.append(OneToken(tokenEnum: .swiftGmp(temp)))
        } else {
            if let last = lastSwiftGmp {
                last.execute(constant)
            } else {
                fatalError("Expected a number or a constant but found ")
            }
        }
    }
    
    func newToken(_ swiftGmp: SwiftGmp) {
        tokens.append(OneToken(tokenEnum: .swiftGmp(swiftGmp)))
    }
    func newSwiftGmpToken(_ s: String) {
        tokens.append(OneToken(tokenEnum: .swiftGmp(SwiftGmp(withString: s, bits: generousBits(for: precision)))))
    }
    
    func newToken(_ twoOperant: TwoOperantOperation) {
        tokens.append(OneToken(tokenEnum: .twoOperant(twoOperant)))
    }
    
    func newTokenClear() {
        tokens.append(OneToken(tokenEnum: .clear))
    }
    
    func newTokenEqual() {
        tokens.append(OneToken(tokenEnum: .equal))
    }
    
    func newTokenPercent() {
        tokens.append(OneToken(tokenEnum: .percent))
    }
    
    func newToken(_ inPlace: InplaceOperation) {
        tokens.append(OneToken(tokenEnum: .inPlace(inPlace)))
    }
    
    func newTokenParenthesesLeft() {
        tokens.append(OneToken(tokenEnum: .parenthesesLeft))
    }
    
    func newTokenParenthesesRight() {
        tokens.append(OneToken(tokenEnum: .parenthesesRight))
    }
    
    func generousBits(for precision: Int) -> Int {
        Int(Double(generousPrecision(for: precision)) * 3.32192809489)
    }
    
    func generousPrecision(for precision: Int) -> Int {
        return precision + 20
        //        if precision <= 500 {
        //            return 1000
        //        } else if precision <= 10000 {
        //            return 2 * precision
        //        } else if precision <= 100000 {
        //            return Int(round(1.5*Double(precision)))
        //        } else {
        //            return precision + 50000
        //        }
    }
    
    private func numberCharacterToOpProtocol(_ char: Character) throws -> any OpProtocol {
        switch char {
        case "0": DigitOperation.zero
        case "1": DigitOperation.one
        case "2": DigitOperation.two
        case "3": DigitOperation.three
        case "4": DigitOperation.four
        case "5": DigitOperation.five
        case "6": DigitOperation.six
        case "7": DigitOperation.seven
        case "8": DigitOperation.eight
        case "9": DigitOperation.nine
        case ".": DigitOperation.dot
        default: throw TokenizerError.invalidNumberCharacter(char: char)
        }
    }
    
    private func numberToOpProtocol(_ number: String) throws -> [any OpProtocol] {
        var ret: [any OpProtocol] = []
        var numberBuffer = number
        if !numberBuffer.isEmpty {
            var mantissaNegative: Bool = false
            var exponentNegative: Bool = false
            var mantissa: String
            var exponent: String? = nil
            if numberBuffer.starts(with: "-") {
                numberBuffer.removeFirst()
                mantissaNegative = true
            }
            let me = numberBuffer.split(separator: "e")
            if me.count == 2 {
                mantissa = String(me[0])
                exponent = String(me[1])
                if exponent!.starts(with: "-") {
                    numberBuffer.removeFirst()
                    exponentNegative = true
                }
            } else {
                mantissa = numberBuffer
            }
            numberBuffer = ""
            
            // TODO: put into parentesis to show number in display?
            for char in mantissa {
                try ret.append(numberCharacterToOpProtocol(char))
            }
            if mantissaNegative {
                ret.append(InplaceOperation.changeSign)
            }
            if let exponent = exponent {
                ret.append(TwoOperantOperation.EE)
                for char in exponent {
                    try ret.append(numberCharacterToOpProtocol(char))
                }
                if exponentNegative {
                    ret.append(InplaceOperation.changeSign)
                }
            }
        }
        return ret
    }
    

    private func rearrangeInplaceFunctions(in input: String) -> String {
        var functionIndex: String.Index = input.startIndex
        let inputEndIndex: String.Index = input.endIndex
        while functionIndex < inputEndIndex {
            var inputSlice: Substring = input[functionIndex...]
            for op in allOperationsSorted {
                let opRawValue: String = op.getRawValue()
                if inputSlice.hasPrefix(opRawValue) {
                    if op is InplaceOperation {
                        // inplace operator found
                        // skip possible whitespaces
                        var argumentIndex = input.index(functionIndex, offsetBy: opRawValue.count)
                        inputSlice = input[argumentIndex...]
                        while inputSlice.hasPrefix(" ") {
                            inputSlice.removeFirst()
                            argumentIndex = input.index(after: argumentIndex)
                        }
                        guard inputSlice.hasPrefix("(") else { continue }
                        // get everything between the "(" and the matching ")"
                        // remove the inplace string and put it after the matching ")"
                        var parenthesisCounter = 1
                        var searchIndex = inputSlice.index(after: argumentIndex)
                        while searchIndex < inputEndIndex {
                            if input[searchIndex] == "(" { parenthesisCounter += 1 }
                            if input[searchIndex] == ")" { parenthesisCounter -= 1 }
                            searchIndex = input.index(after: searchIndex)
                            if parenthesisCounter == 0 {
                                // function argument isolated: [index, searchIndex]
                                var input2 = input
                                input2.insert(contentsOf: op.getRawValue(), at: searchIndex)
                                var functionArgument = String(input2[argumentIndex..<searchIndex])
                                functionArgument = rearrangeInplaceFunctions(in: functionArgument)
                                input2.insert(contentsOf: functionArgument, at: searchIndex)
                                input2.removeSubrange(argumentIndex..<searchIndex)
                                input2.removeSubrange(functionIndex..<argumentIndex)
                                print(input2)
                                return input2
                            }
                        }

                    }
                }
            }
            // Move to the next character
            functionIndex = input.index(after: functionIndex)
        }
        return input
    }
    
    func stringToPressCommands(_ notArranged: String) throws -> [any OpProtocol] {
        var input = notArranged//.replacingOccurrences(of: " ", with: "")
        input = rearrangeInplaceFunctions(in: input)
//        let input = notArranged
        var ret: [any OpProtocol] = []
        var numberBuffer: String = ""

        var index: String.Index = input.startIndex
        let inputEndIndex: String.Index = input.endIndex
        while index < inputEndIndex {
            let char: Character = input[index]
            
            // Check if the character is part of a number
            if ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"].contains(char) || char == "." || (char == "e" && !numberBuffer.isEmpty) || (char == "-" && numberBuffer.last == "e") {
                // Append characters that are part of a number (including scientific notation)
                numberBuffer.append(char)
            }
            // Check for whitespace
            else if char.isWhitespace {
                ret.append(contentsOf: try numberToOpProtocol(numberBuffer))
                numberBuffer = ""
            }
            else if char == "=" {
                ret.append(EqualOperation.equal)
            }
            // Handle '-' character
            else if char == "-" {
                var unaryMinus = true
                if let last = ret.last {
                    unaryMinus = last.numberExpected
                }
                if !numberBuffer.isEmpty { unaryMinus = false }
                let remainingCharsCount: Int = input.distance(from: index, to: inputEndIndex)
                let nextIndex: String.Index = input.index(after: index)
                
                // Ensure nextIndex is within bounds
                if remainingCharsCount > 1, nextIndex < inputEndIndex {
                    let afterMinus: Character = input[nextIndex]
                    if afterMinus == " " {
                        unaryMinus = false
                    }
                }
                
                if unaryMinus {
                    // Unary minus (e.g., -5)
                    numberBuffer.append(char)
                } else {
                    // Subtraction operator
                    if !numberBuffer.isEmpty {
                        ret.append(contentsOf: try numberToOpProtocol(numberBuffer))
                        numberBuffer = ""
                    }
                    ret.append(TwoOperantOperation.sub)
                }
            }
            // Handle operators and parentheses
            else {
                var opFound: Bool = false
                let inputSlice: Substring = input[index...]
                
                for op in allOperationsSorted {
                    let opRawValue: String = op.getRawValue()
                    
                    if inputSlice.hasPrefix(opRawValue) {
                        opFound = true
                        
                        if !numberBuffer.isEmpty {
                            ret.append(contentsOf: try numberToOpProtocol(numberBuffer))
                            numberBuffer = ""
                        }
                        
                        // Add the corresponding token based on the operation type
                        if let inPlace = op as? InplaceOperation {
                            ret.append(inPlace)
                        } else if let _ = op as? PercentOperation {
                            ret.append(PercentOperation.percent)
                        } else if let constant = op as? ConstantOperation {
                            ret.append(constant)
                        } else if let twoOperant = op as? TwoOperantOperation {
                            ret.append(twoOperant)
                        } else if opRawValue == "(" {
                            ret.append(ParenthesisOperation.left)
                        } else if opRawValue == ")" {
                            ret.append(ParenthesisOperation.right)
                        } else {
                            throw TokenizerError.unknownOperator(op: opRawValue)
                        }
                        
                        // Advance the index by the length of the operator minus one (since we'll increment it at the end of the loop)
                        index = input.index(index, offsetBy: opRawValue.count - 1)
                        break // Exit the loop since we found a matching operator
                    }
                }
                
                if !opFound {
                    var failedCandidate: String = String(inputSlice)
                    if let spaceIndex = failedCandidate.firstIndex(of: " ") {
                        failedCandidate = String(failedCandidate[..<spaceIndex])
                    }
                    throw TokenizerError.unknownOperator(op: failedCandidate)
                }
            }
            
            // Move to the next character
            index = input.index(after: index)
        }
        
        // If there's any remaining number in the buffer, add it as a token
        if !numberBuffer.isEmpty {
            ret.append(contentsOf: try numberToOpProtocol(numberBuffer))
            numberBuffer = ""
        }

        return ret
    }
}

extension Collection where Element: Equatable {
    
    func element(after element: Element) -> Element? {
        if let index = self.firstIndex(of: element){
            let followingIndex = self.index(after: index)
            if followingIndex < self.endIndex{
                return self[followingIndex]
            }
        }
        return nil
    }
}

extension BidirectionalCollection where Element: Equatable {
    
    func element(before element: Element) -> Element? {
        if let index = self.firstIndex(of: element){
            let precedingIndex = self.index(before: index)
            if precedingIndex >= self.startIndex{
                return self[precedingIndex]
            }
        }
        return nil
    }
}
