import Foundation

public protocol OpProtocol: Equatable {
    var operatorPriority: Int { get }
    var requiresValidNumber: Bool { get }
    var numberExpected: Bool { get }
    func getRawValue() -> String
    func isEqual(to other: any OpProtocol) -> Bool
}

extension OpProtocol where Self: Equatable {
    public func isEqual(to other: any OpProtocol) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}


public enum DigitOperation: String, OpProtocol, CaseIterable {
    case zero  = "0"
    case one   = "1"
    case two   = "2"
    case three = "3"
    case four  = "4"
    case five  = "5"
    case six   = "6"
    case seven = "7"
    case eight = "8"
    case nine  = "9"
    case dot  = "."
}

public enum ClearOperation: String, OpProtocol, CaseIterable {
    case clear = "C"
}
public enum EqualOperation: String, OpProtocol, CaseIterable {
    case equal = "="
}
public enum PercentOperation: String, OpProtocol, CaseIterable {
    case percent = "%"
}

public enum MemoryOperation: String, OpProtocol, CaseIterable {
    case recallM  = "MR"
    case addToM   = "M+"
    case subFromM = "M-"
    case clearM   = "MC"
}

public enum ConstantOperation: String, OpProtocol, CaseIterable {
    // this operation in an inplace operation, but if no number is found
    // it creates a zero out of thin air and then perated on the zero.
    case pi = "π"
    case e = "e"
    case rand = "rand"
}

public enum InplaceOperation: String, OpProtocol, CaseIterable {
    case abs = "abs"
    case sqrt
    case sqrt3
    case zeta
    case ln
    case log10
    case log2
    case sin
    case cos
    case tan
    case asin
    case acos
    case atan
    case sinh
    case cosh
    case tanh
    case asinh
    case acosh
    case atanh
    case sqr
    case cubed
    case exp
    case exp2
    case exp10
    case changeSign = "±"
    case rez
    case fac
    case sinD
    case cosD
    case tanD
    case asinD
    case acosD
    case atanD
}

public enum TwoOperantOperation: String, OpProtocol, CaseIterable {
    case add = "+"
    case sub = "-"
    case mul = "x"
    case div = "/"
    case pow_x_y = "^"
    case pow_y_x
    case sqrty
    case logy
    case EE
}

public enum ParenthesisOperation: String, OpProtocol, CaseIterable {
    case left = "("
    case right = ")"
}


extension DigitOperation {
    public var operatorPriority: Int { 3 }
    public var numberExpected: Bool { false }
    public var requiresValidNumber: Bool { false }
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension ClearOperation {
    public var operatorPriority: Int { 3 }
    public var numberExpected: Bool { true }
    public var requiresValidNumber: Bool { false }
    public func getRawValue() -> String {
        return self.rawValue
    }
}
extension EqualOperation {
    public var operatorPriority: Int { 3 }
    public var numberExpected: Bool { true }
    public var requiresValidNumber: Bool { false }
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension PercentOperation {
    public var operatorPriority: Int { 3 }
    public var numberExpected: Bool { false }
    public var requiresValidNumber: Bool { false }
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension MemoryOperation {
    public var operatorPriority: Int { 3 }
    public var numberExpected: Bool { false }
    public var requiresValidNumber: Bool {
        switch self {
        case .clearM:
            return false
        case .recallM:
            return true
        case .addToM:
            return true
        case .subFromM:
            return true
        }
    }
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension ConstantOperation {
    public var operatorPriority: Int { 3 }
    public var numberExpected: Bool { false }
    public var requiresValidNumber: Bool { false }
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension InplaceOperation {
    public var operatorPriority: Int { 3 }
    public var numberExpected: Bool { false }
    public var requiresValidNumber: Bool { true }
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension TwoOperantOperation {
    public var operatorPriority: Int {
        get {
            switch self {
            case .add, .sub:
                1
            case .mul, .div:
                2
            case .pow_x_y:
                2
            case .pow_y_x:
                2
            case .sqrty:
                2
            case .logy:
                2
            case .EE:
                2 // TODO: is that correct?
            }
        }
    }
    public var numberExpected: Bool { true }
    public var requiresValidNumber: Bool { true }
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension ParenthesisOperation {
    public var operatorPriority: Int { 3 }
    public var numberExpected: Bool {
        switch self {
        case .left:
            true
        case .right:
            false
        }
    }
    public var requiresValidNumber: Bool { true }
    public func getRawValue() -> String {
        return self.rawValue
    }
}
