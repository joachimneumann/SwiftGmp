import Foundation
import SwiftGmp_C_Target

var globalUnsignedLongInt: CUnsignedLong = 0

extension SwiftGmpInplaceOperation {
    init() {
        self = .zero
    }
}

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

public enum SwiftGmpInplaceOperation: String, OpProtocol, CaseIterable {
    case zero
    case pi
    case e
    case rand
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
    case changeSign
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


enum Operator {
    case inPlace(SwiftGmpInplaceOperation) // e.g., sin, log
    case binary(SwiftGmpTwoOperantOperation) // e.g., +, -, *, /
    case constant(SwiftGmp) // e.g., pi, e
    case parenthesesLeft
    case parenthesesRight
    
    var priority: Int {
        switch self {
        case .binary(let op):
            if op == .mul || op == .div { return 2 } // Higher precedence for * and /
            return 1 // Lower precedence for + and -
        case .inPlace:
            return 3 // Highest precedence for in-place operators like sin, log
        case .parenthesesLeft, .parenthesesRight:
            return 0 // Parentheses control grouping, not direct precedence
        case .constant:
            return 4 // Constants should be directly evaluated
        }
    }
}

public class SwiftGmp: Equatable, CustomDebugStringConvertible {
    private(set) var bits: Int
    private static var rad_deg_bits: Int = 10
    private static var deg2rad: SwiftGmp = SwiftGmp(bits: rad_deg_bits)
    private static var rad2deg: SwiftGmp = SwiftGmp(bits: rad_deg_bits)

    /// init with zeros. The struct will be initialized correctly in init() with mpfr_init2()
    private var mpfr: mpfr_t = mpfr_t(_mpfr_prec: 0, _mpfr_sign: 0, _mpfr_exp: 0, _mpfr_d: &globalUnsignedLongInt)

    init(bits: Int) {
        self.bits = bits
        mpfr_init2 (&mpfr, bits) // nan
        
        
//        let expression: [Operator] = [
//            .constant(Number("1", precision: 20).swiftGmp),
//            .binary(.add),
//            .constant(Number("3", precision: 20).swiftGmp),
//            .binary(.mul),
//            .constant(Number("10", precision: 20).swiftGmp)
//        ]
//
//        let postfixExpression = shuntingYard(expression)
//        let result = evaluatePostfix(postfixExpression)
//
//        print(result.toDouble()) // Output: 31
    }
    
    init(withString string: String, bits: Int) {
        self.bits = bits
        mpfr_init2 (&mpfr, bits)
        mpfr_set_str (&mpfr, string, 10, MPFR_RNDN)
    }

    deinit {
        mpfr_clear(&mpfr)
    }
    
    public static func == (lhs: SwiftGmp, rhs: SwiftGmp) -> Bool {
        return mpfr_cmp(&lhs.mpfr, &rhs.mpfr) == 0
    }
    
    
    func setBits(_ newBits: Int) {
        bits = newBits
        mpfr_prec_round(&mpfr, self.bits, MPFR_RNDN);
    }
    
    func isApproximately(_ other: Double, precision: Double = 1e-3) -> Bool {
        let diff = self.toDouble() - other
        return Swift.abs(diff) <= precision
    }

    public var debugDescription: String {
        guard !isNan else { return "nan"}
        guard isValid else { return "not valid"}
        let (mantissa, exponent) = mantissaExponent(len: 100)
        return "\(mantissa) \(exponent)"
    }

    static func isValidSwiftGmpString(_ gmpString: String, bits: Int) -> Bool {
        var temp_mpfr: mpfr_t = mpfr_t(_mpfr_prec: 0, _mpfr_sign: 0, _mpfr_exp: 0, _mpfr_d: &globalUnsignedLongInt)
        mpfr_init2 (&temp_mpfr, bits)
        return mpfr_set_str (&temp_mpfr, gmpString, 10, MPFR_RNDN) == 0
    }

    //
    // copy and convert
    //
    func copy() -> SwiftGmp {
        let ret = SwiftGmp.init(withString: "0", bits: bits)
        mpfr_set(&ret.mpfr, &mpfr, MPFR_RNDN)
        return ret
    }
    public func toDouble() -> Double {
        return mpfr_get_d(&mpfr, MPFR_RNDN)
    }
    static func memorySize(bits: Int) -> Int {
        mpfr_custom_get_size(bits)
    }
    func mantissaExponent(len: Int) -> (String, Int) {
        var exponent: mpfr_exp_t = 0
        
        var charArray: Array<CChar> = Array(repeating: 0, count: len+10)
        mpfr_get_str(&charArray, &exponent, 10, len, &mpfr, MPFR_RNDN)
        var mantissa: String = ""
        
        charArray.withUnsafeBufferPointer { ptr in
            mantissa = String(cString: ptr.baseAddress!)
        }

        var zeroCharacterSet = CharacterSet()
        zeroCharacterSet.insert(charactersIn: "0")
        mantissa = mantissa.trimmingCharacters(in: zeroCharacterSet)

        return (mantissa, exponent - 1)
    }
    
    
    //
    // Status Boolean
    //
    func isNegative()    -> Bool { mpfr_cmp_d(&mpfr, 0.0)  < 0 }
    var isValid: Bool {
        if mpfr_number_p(&mpfr) == 0 { return false }
        if isNan { return false }
        if isInf { return false }
        return true
    }
    var isNan: Bool {
        mpfr_nan_p(&mpfr) != 0
    }
    var isInf: Bool {
        mpfr_inf_p(&mpfr) != 0
    }
    var isZero: Bool {
        mpfr_zero_p(&mpfr) != 0
    }
    
    static var randstate: gmp_randstate_t? = nil
    
    public func execute(_ twoOperantOperation: SwiftGmpTwoOperantOperation, other: SwiftGmp) {
        print(self.toDouble())
        print(other.toDouble())
        var temp = self.mpfr;
        switch twoOperantOperation {
        case .add:
            mpfr_add(&mpfr, &temp, &other.mpfr, MPFR_RNDN)
        case .sub:
            mpfr_sub(&mpfr, &temp, &other.mpfr, MPFR_RNDN)
        case .mul:
            mpfr_mul(&mpfr, &temp, &other.mpfr, MPFR_RNDN)
        case .div:
            mpfr_div(&mpfr, &temp, &other.mpfr, MPFR_RNDN)
        case .pow_x_y:
            mpfr_pow(&mpfr, &temp, &other.mpfr, MPFR_RNDN)
        case .pow_y_x:
            mpfr_pow(&mpfr, &temp, &other.mpfr, MPFR_RNDN)
        case .sqrty:
            other.execute(.rez)
            execute(.pow_x_y, other: other)
        case .logy:
            other.execute(.ln)
            execute(.div, other: other)
        case .EE:
            other.execute(.exp10)
            execute(.mul, other: other)
        }
    }
    public func execute(_ inplaceOp: SwiftGmpInplaceOperation) {
        switch inplaceOp {
        case .zero:
            mpfr_set_d(&mpfr, 0.0, MPFR_RNDN)
        case .pi:
            mpfr_const_pi(&mpfr, MPFR_RNDN)
        case .e:
            mpfr_exp( &mpfr, &SwiftGmp(withString: "1.0", bits: bits).mpfr, MPFR_RNDN)
        case .rand:
            if SwiftGmp.randstate == nil {
                SwiftGmp.randstate = gmp_randstate_t()
                __gmp_randinit_mt(&SwiftGmp.randstate!)
                __gmp_randseed_ui(&SwiftGmp.randstate!, UInt.random(in: 0..<UInt.max));
            }
            mpfr_urandom(&mpfr, &SwiftGmp.randstate!, MPFR_RNDN)
        case .abs:
            var temp = mpfr; mpfr_abs(  &mpfr, &temp, MPFR_RNDN)
        case .sqrt:
            var temp = mpfr; mpfr_sqrt( &mpfr, &temp, MPFR_RNDN)
        case .sqrt3:
            var temp = mpfr; mpfr_cbrt( &mpfr, &temp, MPFR_RNDN)
        case .zeta:
            var temp = mpfr; mpfr_zeta( &mpfr, &temp, MPFR_RNDN)
        case .ln:
            var temp = mpfr; mpfr_log(  &mpfr, &temp, MPFR_RNDN)
        case .log10:
            var temp = mpfr; mpfr_log10(&mpfr, &temp, MPFR_RNDN)
        case .log2:
            var temp = mpfr; mpfr_log2 (&mpfr, &temp, MPFR_RNDN)
        case .sin:
            var temp = mpfr; mpfr_sin(  &mpfr, &temp, MPFR_RNDN)
        case .cos:
            var temp = mpfr; mpfr_cos(  &mpfr, &temp, MPFR_RNDN)
        case .tan:
            var temp = mpfr; mpfr_tan(  &mpfr, &temp, MPFR_RNDN)
        case .asin:
            var temp = mpfr; mpfr_asin( &mpfr, &temp, MPFR_RNDN)
        case .acos:
            var temp = mpfr; mpfr_acos( &mpfr, &temp, MPFR_RNDN)
        case .atan:
            var temp = mpfr; mpfr_atan( &mpfr, &temp, MPFR_RNDN)
        case .sinh:
            var temp = mpfr; mpfr_sinh( &mpfr, &temp, MPFR_RNDN)
        case .cosh:
            var temp = mpfr; mpfr_cosh( &mpfr, &temp, MPFR_RNDN)
        case .tanh:
            var temp = mpfr; mpfr_tanh( &mpfr, &temp, MPFR_RNDN)
        case .asinh:
            var temp = mpfr; mpfr_asinh(&mpfr, &temp, MPFR_RNDN)
        case .acosh:
            var temp = mpfr; mpfr_acosh(&mpfr, &temp, MPFR_RNDN)
        case .atanh:
            var temp = mpfr; mpfr_atanh(&mpfr, &temp, MPFR_RNDN)
        case .sqr:
            var temp = mpfr; mpfr_sqr(  &mpfr, &temp, MPFR_RNDN)
        case .cubed:
            var temp = mpfr; mpfr_pow_ui(&mpfr, &temp, 3, MPFR_RNDN)
        case .exp:
            var temp = mpfr; mpfr_exp(  &mpfr, &temp, MPFR_RNDN)
        case .exp2:
            var temp = mpfr; mpfr_ui_pow(&mpfr, 2, &temp, MPFR_RNDN)
        case .exp10:
            var temp = mpfr; mpfr_exp10(&mpfr, &temp, MPFR_RNDN)
        case .changeSign:
            var temp = mpfr; mpfr_neg(  &mpfr, &temp, MPFR_RNDN)
        case .rez:
            var temp = mpfr; mpfr_ui_div(&mpfr, 1, &temp, MPFR_RNDN)
        case .fac:
            let n = mpfr_get_si(&mpfr, MPFR_RNDN)
            if n >= 0 {
                let un = UInt(n)
                mpfr_fac_ui(&mpfr, un, MPFR_RNDN)
            } else {
                mpfr_set_d(&mpfr, 0.0, MPFR_RNDN)
            }
        case .sinD:
            check(bits: bits)
            var temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.deg2rad.mpfr, MPFR_RNDN); temp = mpfr; mpfr_sin(  &mpfr, &temp, MPFR_RNDN)
        case .cosD:
            check(bits: bits)
            var temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.deg2rad.mpfr, MPFR_RNDN); temp = mpfr; mpfr_cos(  &mpfr, &temp, MPFR_RNDN)
        case .tanD:
            check(bits: bits)
            var temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.deg2rad.mpfr, MPFR_RNDN); temp = mpfr; mpfr_tan(  &mpfr, &temp, MPFR_RNDN)
        case .asinD:
            check(bits: bits)
            var temp = mpfr; mpfr_asin( &mpfr, &temp, MPFR_RNDN); temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.rad2deg.mpfr, MPFR_RNDN)
        case .acosD:
            check(bits: bits)
            var temp = mpfr; mpfr_acos( &mpfr, &temp, MPFR_RNDN); temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.rad2deg.mpfr, MPFR_RNDN)
        case .atanD:
            check(bits: bits)
            var temp = mpfr; mpfr_atan( &mpfr, &temp, MPFR_RNDN); temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.rad2deg.mpfr, MPFR_RNDN)
        }
    }
    
//    func inPlace(op: inplaceType) { op(self)() }
    /// in the second argument, I a simultaneously using the same memory
    /// Option 1: &mpfr -> &copy().mpfr
    /// Option 2: in the build settings set exclusiv access to memory to compiletime enfocement only
    
    func check(bits: Int) {
        if bits != SwiftGmp.rad_deg_bits {
            let _180 = SwiftGmp(withString: "180", bits: bits)
            let _pi = SwiftGmp(bits: bits)
            _pi.execute(.pi)
            SwiftGmp.rad2deg = _180.copy()
            SwiftGmp.rad2deg.execute(.div, other: _pi)
            SwiftGmp.deg2rad = SwiftGmp.rad2deg.copy()
            SwiftGmp.deg2rad.execute(.rez)
            SwiftGmp.rad_deg_bits = bits
        }
    }
    
    public typealias swiftGmpInplaceType = (SwiftGmp) -> () -> ()
    public typealias swiftGmpTwoOperantsType = (SwiftGmp) -> (SwiftGmp) -> ()
    
    func setValue(other: SwiftGmp) {
        mpfr_set(&mpfr, &other.mpfr, MPFR_RNDN)
    }
    
    func x_double_up_arrow_y(other: SwiftGmp) {
        var temp: mpfr_t = mpfr_t(_mpfr_prec: 0, _mpfr_sign: 0, _mpfr_exp: 0, _mpfr_d: &globalUnsignedLongInt)
        mpfr_init2 (&temp, mpfr_get_prec(&mpfr))
        mpfr_set(&temp, &mpfr, MPFR_RNDN)
        
        let counter: CLong = mpfr_get_si(&other.mpfr, MPFR_RNDN) - 1
        guard counter > 0 else { return }
        for _ in 0..<counter {
            mpfr_pow(&mpfr, &temp, &mpfr, MPFR_RNDN)
        }
        mpfr_clear(&temp)
    }
}

