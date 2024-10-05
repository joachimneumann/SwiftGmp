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


public enum SwiftGmpDigitOperation: String, OpProtocol, CaseIterable {
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

public enum SwiftGmpMemoryOperation: String, OpProtocol, CaseIterable {
    case recall = "MR"
    case add    = "M+"
    case sub    = "M-"
    case clear  = "MC"
}

public enum SwiftGmpConstantOperation: String, OpProtocol, CaseIterable {
    // this operation in an inplace operation, but if no number is found
    // it creates a zero out of thin air and then perated on the zero.
    case zero
    case pi
    case e
    case rand
}

public enum SwiftGmpInplaceOperation: String, OpProtocol, CaseIterable {
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

public enum SwiftGmpTwoOperantOperation: String, OpProtocol, CaseIterable {
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

public enum SwiftGmpParenthesisOperation: String, OpProtocol, CaseIterable {
    case left = "("
    case right = ")"
}



extension SwiftGmpDigitOperation {
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension SwiftGmpMemoryOperation {
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension SwiftGmpInplaceOperation {
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension SwiftGmpTwoOperantOperation {
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension SwiftGmpParenthesisOperation {
    public func getRawValue() -> String {
        return self.rawValue
    }
}

extension SwiftGmpConstantOperation {
    public func getRawValue() -> String {
        return self.rawValue
    }
}
