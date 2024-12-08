import Foundation

public protocol OpProtocol: Equatable {
    var operatorPriority: Int { get }
    var requiresValidNumber: Bool { get }
    var numberExpected: Bool { get }
    var argument: String? { get }
    func getRawValue() -> String
    func isEqual(to other: any OpProtocol) -> Bool
}

extension OpProtocol where Self: Equatable {
    public func isEqual(to other: any OpProtocol) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
    public var argument: String? { nil }
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
    case clear = "AC"
    case back = "back"
}

public enum EqualOperation: String, OpProtocol, CaseIterable {
    case equal = "="
}

public enum PercentOperation: String, OpProtocol, CaseIterable {
    case percent = "%"
}

public enum MemoryOperation: String, OpProtocol, CaseIterable {
    case clearM   = "mc"
    case recallM  = "mr"
    case addToM   = "m+"
    case subFromM = "m-"
}

public enum ConstantOperation: String, OpProtocol, CaseIterable {
    // this operation in an inplace operation, but if no number is found
    // it creates a zero out of thin air and then perated on the zero.
    case pi = "π"
    case e = "e"
    case rand = "Rand"
}

public enum InplaceOperation: String, OpProtocol, CaseIterable {
    case abs = "abs"
    case floor
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
    case exp10
    case changeSign = "±"
    case rez
    case fac
    case sind
    case cosd
    case tand
    case asind
    case acosd
    case atand
}

public enum TwoOperantOperation: String, OpProtocol, CaseIterable {
    case add = "+"
    case sub = "-"
    case mul = "*"
    case div = "/"
    case powxy
    case powyx
    case sqrty
    case logy
    case EE
}

public enum ParenthesisOperation: String, OpProtocol, CaseIterable {
    case left = "("
    case right = ")"
}

public enum ControlOperation: String, OpProtocol, CaseIterable {
    case calc = "calc"
    case settings = "settings"
    case second = "2nd"
    case rad = "Rad"
    case deg = "Deg"
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
    static let highestPriority: Int = 4
    public var operatorPriority: Int {
        get {
            switch self {
            case .add, .sub:
                1
            case .mul, .div:
                2
            case .powxy:
                3
            case .powyx:
                3
            case .sqrty:
                3
            case .logy:
                3
            case .EE:
                4 // TODO: is that correct?
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


extension ControlOperation {
    public var operatorPriority: Int { 5 }
    public var numberExpected: Bool { false }
    public var requiresValidNumber: Bool { false }
    public func getRawValue() -> String { return self.rawValue }
}
