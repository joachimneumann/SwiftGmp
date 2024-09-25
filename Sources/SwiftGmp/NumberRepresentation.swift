//
//  NumberRepresentation.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 25.09.24.
//

protocol ShowAs {
    var showAsInt: Bool   { get }
    var showAsFloat: Bool { get }
}

enum DecimalSeparator: String, Codable, CaseIterable{
    case comma
    case dot
    var character: Character {
        get {
            switch self {
            case .comma: return ","
            case .dot: return "."
            }
        }
    }
    var string: String {
        get {
            String(character)
        }
    }
}
public enum GroupingSeparator: String, Codable, CaseIterable{
    case comma
    case dot
    case none
    var character: Character? {
        get {
            switch self {
            case .none: return nil
            case .comma: return ","
            case .dot: return "."
            }
        }
    }
    var string: String {
        get {
            guard let character = character else { return "" }
            return String(character)
        }
    }
}

protocol Separators {
    var decimalSeparator: DecimalSeparator   { get }
    var groupingSeparator: GroupingSeparator { get }
}


public struct NumberRepresentation {
    var left: String
    var right: String?
    var canBeInteger: Bool
    var canBeFloat: Bool

    var isZero: Bool {
        left == "0" && right == nil
    }
    
    public var allInOneLine: String {
        left + (right ?? "")
    }
    var length: Int {
        var ret = left.count
        if right != nil { ret += right!.count }
        return ret
    }
    init(left: String) {
        self.left = left
        canBeInteger = false
        canBeFloat = false
    }
}

extension String {
    public var isRepresentableAsDouble: Bool {
        var test: String = self
        if self.contains(".") {
            while test.last == "0" {
                test.removeLast()
            }
        }

        if test.count > 16 { return false }
        
        if self.contains(".") {
            if test.last == "3" {
                test.removeLast();
                test = test + "9"
            } else if test.last == "." {
                test = test + "3"
            } else {
                test.removeLast();
                test = test + "3"
            }
        } else {
            if test.last == "3" {
                test.removeLast();
                test = test + "9"
            } else {
                test.removeLast();
                test = test + "3"
            }
        }
        if let selfDouble = Double(self) {
            if let testDouble = Double(test) {
                return testDouble != selfDouble
            }
            return false
        }
        return false
    }
    
    func before(first delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            let before = prefix(upTo: index)
            return String(before)
        }
        return ""
    }
    
    func after(first delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            let after = suffix(from: index).dropFirst()
            return String(after)
        }
        return ""
    }
    
    func replacingFirstOccurrence(of target: String, with replacement: String) -> String {
        guard let range = self.range(of: target) else { return self }
        return self.replacingCharacters(in: range, with: replacement)
    }
}
