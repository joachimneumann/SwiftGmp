import Foundation
import SwiftGmp_C_Target

var globalUnsignedLongInt: CUnsignedLong = 0

public class SwiftGmp: Equatable, CustomDebugStringConvertible {
    private var bits: Int
    public private(set) var precision: Int

    /// init with zeros. The struct will be initialized correctly in init() with mpfr_init2()
    private var mpfr: mpfr_t = mpfr_t(_mpfr_prec: 0, _mpfr_sign: 0, _mpfr_exp: 0, _mpfr_d: &globalUnsignedLongInt)

    init(withString string: String, precision: Int) {
        self.precision = precision
        self.bits = Number.bits(for: precision)
        mpfr_init2 (&mpfr, bits)
        mpfr_set_str (&mpfr, string, 10, MPFR_RNDN)
    }

//    private init(withMpfr from_mpfr: inout __mpfr_struct, bits: Int) {
//        self.bits = bits
//        mpfr_init2 (&mpfr, bits)
//        mpfr_set(&mpfr, &from_mpfr, MPFR_RNDN)
//    }

    deinit {
        mpfr_clear(&mpfr)
    }
    
    public static func == (lhs: SwiftGmp, rhs: SwiftGmp) -> Bool {
        return mpfr_cmp(&lhs.mpfr, &rhs.mpfr) == 0
    }
    
    public func isApproximately(_ other: Double, precision: Double = 1e-3) -> Bool {
        let diff = self.toDouble() - other
        return Swift.abs(diff) <= precision
    }

    static func + (lhs: SwiftGmp, rhs: SwiftGmp) -> SwiftGmp {
        let temp = lhs.copy()
        temp.add(other: rhs)
        return temp
    }
    static func - (lhs: SwiftGmp, rhs: SwiftGmp) -> SwiftGmp {
        let temp = lhs.copy()
        temp.sub(other: rhs)
        return temp
    }
    static func * (lhs: SwiftGmp, rhs: SwiftGmp) -> SwiftGmp {
        let temp = lhs.copy()
        temp.mul(other: rhs)
        return temp
    }
    static func / (lhs: SwiftGmp, rhs: SwiftGmp) -> SwiftGmp {
        let temp = lhs.copy()
        temp.div(other: rhs)
        return temp
    }

    public var debugDescription: String {
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
    public func copy() -> SwiftGmp {
        let ret = SwiftGmp.init(withString: "0", precision: precision)
        mpfr_set(&ret.mpfr, &mpfr, MPFR_RNDN)
        return ret
    }
    public func toDouble() -> Double {
        return mpfr_get_d(&mpfr, MPFR_RNDN)
    }
    public static func memorySize(bits: Int) -> Int {
        mpfr_custom_get_size(bits)
    }
    public func mantissaExponent(len: Int) -> (String, Int) {
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
    //func isNull()       -> Bool { mpfr_cmp_d(&mpfr, 0.0) == 0 }
    public func isNegtive()    -> Bool { mpfr_cmp_d(&mpfr, 0.0)  < 0 }
    public var isValid: Bool {
        if mpfr_number_p(&mpfr) == 0 { return false }
        if NaN { return false }
        if inf { return false }
        return true
    }
    public var NaN: Bool {
        mpfr_nan_p(&mpfr) != 0
    }
    public var inf: Bool {
        mpfr_inf_p(&mpfr) != 0
    }
    public var isZero: Bool {
        mpfr_zero_p(&mpfr) != 0
    }
    
    //
    // constants
    //
    public func π() { mpfr_const_pi(&mpfr, MPFR_RNDN) }
    public func e() { mpfr_exp( &mpfr, &SwiftGmp(withString: "1.0", precision: precision).mpfr, MPFR_RNDN) } /// Note: mpfr_const_euler() returns 0.577..., not 2.718
    static var randstate: gmp_randstate_t? = nil
    public func rand() {
        if SwiftGmp.randstate == nil {
            SwiftGmp.randstate = gmp_randstate_t()
            __gmp_randinit_mt(&SwiftGmp.randstate!)
            __gmp_randseed_ui(&SwiftGmp.randstate!, UInt.random(in: 0..<UInt.max));
        }
        mpfr_urandom(&mpfr, &SwiftGmp.randstate!, MPFR_RNDN)
    }

    
    //
    // inPlace
    //
    public func inPlace(op: inplaceType) { op(self)() }
    /// in the second argument, I a simultaneously using the same memory
    /// Option 1: &mpfr -> &copy().mpfr
    /// Option 2: in the build settings set exclusiv access to memory to compiletime enfocement only
    public func abs()        { var temp = mpfr; mpfr_abs(  &mpfr, &temp, MPFR_RNDN) }
    public func sqrt()       { var temp = mpfr; mpfr_sqrt( &mpfr, &temp, MPFR_RNDN) }
    public func sqrt3()      { var temp = mpfr; mpfr_cbrt( &mpfr, &temp, MPFR_RNDN) }
    public func Z()          { var temp = mpfr; mpfr_zeta( &mpfr, &temp, MPFR_RNDN) }
    public func ln()         { var temp = mpfr; mpfr_log(  &mpfr, &temp, MPFR_RNDN) }
    public func log10()      { var temp = mpfr; mpfr_log10(&mpfr, &temp, MPFR_RNDN) }
    public func log2()       { var temp = mpfr; mpfr_log2 (&mpfr, &temp, MPFR_RNDN) }
    public func sin()        { var temp = mpfr; mpfr_sin(  &mpfr, &temp, MPFR_RNDN) }
    public func cos()        { var temp = mpfr; mpfr_cos(  &mpfr, &temp, MPFR_RNDN) }
    public func tan()        { var temp = mpfr; mpfr_tan(  &mpfr, &temp, MPFR_RNDN) }
    public func asin()       { var temp = mpfr; mpfr_asin( &mpfr, &temp, MPFR_RNDN) }
    public func acos()       { var temp = mpfr; mpfr_acos( &mpfr, &temp, MPFR_RNDN) }
    public func atan()       { var temp = mpfr; mpfr_atan( &mpfr, &temp, MPFR_RNDN) }
    public func sinh()       { var temp = mpfr; mpfr_sinh( &mpfr, &temp, MPFR_RNDN) }
    public func cosh()       { var temp = mpfr; mpfr_cosh( &mpfr, &temp, MPFR_RNDN) }
    public func tanh()       { var temp = mpfr; mpfr_tanh( &mpfr, &temp, MPFR_RNDN) }
    public func asinh()      { var temp = mpfr; mpfr_asinh(&mpfr, &temp, MPFR_RNDN) }
    public func acosh()      { var temp = mpfr; mpfr_acosh(&mpfr, &temp, MPFR_RNDN) }
    public func atanh()      { var temp = mpfr; mpfr_atanh(&mpfr, &temp, MPFR_RNDN) }
    public func pow_x_2()    { var temp = mpfr; mpfr_sqr(  &mpfr, &temp, MPFR_RNDN) }
    public func pow_e_x()    { var temp = mpfr; mpfr_exp(  &mpfr, &temp, MPFR_RNDN) }
    public func pow_10_x()   { var temp = mpfr; mpfr_exp10(&mpfr, &temp, MPFR_RNDN) }
    public func changeSign() { var temp = mpfr; mpfr_neg(  &mpfr, &temp, MPFR_RNDN) }
    public func pow_x_3()    { var temp = mpfr; mpfr_pow_ui(&mpfr, &temp, 3, MPFR_RNDN) }
    public func pow_2_x()    { var temp = mpfr; mpfr_ui_pow(&mpfr, 2, &temp, MPFR_RNDN) }
    public func rez()        { var temp = mpfr; mpfr_ui_div(&mpfr, 1, &temp, MPFR_RNDN) }
    public func fac() {
        let n = mpfr_get_si(&mpfr, MPFR_RNDN)
        if n >= 0 {
            let un = UInt(n)
            mpfr_fac_ui(&mpfr, un, MPFR_RNDN)
        } else {
            mpfr_set_d(&mpfr, 0.0, MPFR_RNDN)
        }
    }

    static var deg2rad: SwiftGmp? = nil
    static var rad2deg: SwiftGmp? = nil
    static var rad_deg_precision: Int = 0
    
    static func check(_ precision: Int) {
        if precision != rad_deg_precision {
            deg2rad = SwiftGmp(withString: "0", precision: precision);
            deg2rad!.π()
            deg2rad!.div(other: SwiftGmp(withString: "180", precision: precision))
            SwiftGmp.rad2deg = SwiftGmp(withString: "0", precision: precision);
            SwiftGmp.rad2deg!.π()
            SwiftGmp.rad2deg!.rez()
            SwiftGmp.rad2deg!.mul(other: SwiftGmp(withString: "180", precision: precision))
            rad_deg_precision = precision
        }
    }
    public func sinD()  { SwiftGmp.check(precision); var temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.deg2rad!.mpfr, MPFR_RNDN); temp = mpfr; mpfr_sin(  &mpfr, &temp, MPFR_RNDN) }
    public func cosD()  { SwiftGmp.check(precision); var temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.deg2rad!.mpfr, MPFR_RNDN); temp = mpfr; mpfr_cos(  &mpfr, &temp, MPFR_RNDN) }
    public func tanD()  { SwiftGmp.check(precision); var temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.deg2rad!.mpfr, MPFR_RNDN); temp = mpfr; mpfr_tan(  &mpfr, &temp, MPFR_RNDN) }
    public func asinD() { SwiftGmp.check(precision); var temp = mpfr; mpfr_asin( &mpfr, &temp, MPFR_RNDN); temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.rad2deg!.mpfr, MPFR_RNDN) }
    public func acosD() { SwiftGmp.check(precision); var temp = mpfr; mpfr_acos( &mpfr, &temp, MPFR_RNDN); temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.rad2deg!.mpfr, MPFR_RNDN) }
    public func atanD() { SwiftGmp.check(precision); var temp = mpfr; mpfr_atan( &mpfr, &temp, MPFR_RNDN); temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.rad2deg!.mpfr, MPFR_RNDN) }
    
    //
    // twoOperants
    //
    public func execute(_ op: twoOperantsType, with other: SwiftGmp) { op(self)(other) }
    public func add (other: SwiftGmp) { var temp = mpfr; mpfr_add(&mpfr, &temp, &other.mpfr, MPFR_RNDN) }
    public func sub (other: SwiftGmp) { var temp = mpfr; mpfr_sub(&mpfr, &temp, &other.mpfr, MPFR_RNDN) }
    public func mul (other: SwiftGmp) { var temp = mpfr; mpfr_mul(&mpfr, &temp, &other.mpfr, MPFR_RNDN) }
    public func div (other: SwiftGmp) { var temp = mpfr; mpfr_div(&mpfr, &temp, &other.mpfr, MPFR_RNDN) }
    
    public func pow_x_y(exponent: SwiftGmp) { mpfr_pow(&mpfr, &mpfr, &exponent.mpfr, MPFR_RNDN) }
    public func pow_y_x(base: SwiftGmp)     { mpfr_pow(&mpfr, &base.mpfr, &mpfr, MPFR_RNDN) }
    public func sqrty(exponent: SwiftGmp)   { exponent.rez(); pow_x_y(exponent: exponent) }
    public func logy(base: SwiftGmp) {
        self.ln()
        base.ln()
        self.div(other: base)
    }
    public func EE(other: SwiftGmp) {
        other.pow_10_x()
        self.mul(other: other)
    }
    
    public func setValue(other: SwiftGmp) {
        mpfr_set(&mpfr, &other.mpfr, MPFR_RNDN)
    }
    
    public func x_double_up_arrow_y(other: SwiftGmp) {
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

