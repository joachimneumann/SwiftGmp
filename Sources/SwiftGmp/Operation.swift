import Foundation

public protocol OpProtocol {
    func getRawValue() -> String
    func isEqual(to other: OpProtocol) -> Bool
}

extension OpProtocol where Self: Equatable {
    public func isEqual(to other: OpProtocol) -> Bool {
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

public enum AuxOperation: String, OpProtocol, CaseIterable {
    case clear
    case equal
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
    case zero
    case pi
    case e
    case rand
}

public enum InplaceOperation: String, OpProtocol, CaseIterable {
    case abs
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
    case changeSign = "+/-"
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
    case mul = "*"
    case div = "/"
    case pow_x_y = "**"
    case pow_y_x
    case sqrty
    case logy
    case EE
}

public enum ParenthesisOperation: String, OpProtocol, CaseIterable {
    case left = "("
    case right = ")"
}

extension AuxOperation {
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension DigitOperation {
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension MemoryOperation {
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension InplaceOperation {
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension TwoOperantOperation {
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension ParenthesisOperation {
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension ConstantOperation {
    public func getRawValue() -> String {
        return self.rawValue
    }
}
