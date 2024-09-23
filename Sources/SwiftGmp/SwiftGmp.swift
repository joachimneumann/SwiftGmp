import Foundation
import SwiftGmp_C_Target

@MainActor var globalUnsignedLongInt: CUnsignedLong = 0

@MainActor
public class SwiftGmp: @preconcurrency Equatable, @preconcurrency CustomDebugStringConvertible {
    private var bits: Int
    private(set) var precision: Int

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

    public var debugDescription: String {
        let (mantissa, exponent) = mantissaExponent(len: 100)
        return "\(mantissa) \(exponent)"
    }

    static func isValidSwiftGmpString(_ gmpString: String, bits: Int) -> Bool {
        var temp_mpfr: mpfr_t = mpfr_t(_mpfr_prec: 0, _mpfr_sign: 0, _mpfr_exp: 0, _mpfr_d: &globalUnsignedLongInt)
        mpfr_init2 (&temp_mpfr, bits)
        return mpfr_set_str (&temp_mpfr, gmpString, 10, MPFR_RNDN) == 0
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

    public func copy() -> SwiftGmp {
        let ret = SwiftGmp.init(withString: "0", precision: precision)
        mpfr_set(&ret.mpfr, &mpfr, MPFR_RNDN)
        return ret
    }
    
    static var randstate: gmp_randstate_t? = nil
    
    //func isNull()       -> Bool { mpfr_cmp_d(&mpfr, 0.0) == 0 }
    public func isNegtive()    -> Bool { mpfr_cmp_d(&mpfr, 0.0)  < 0 }
    
    public func inPlace(op: inplaceType) { op(self)() }
    /// in the second argument, I a simultaneously using the same memory
    /// Option 1: &mpfr -> &copy().mpfr
    /// Option 2: in the build settings set exclusiv access to memory to compiletime enfocement only
    public func abs()        { mpfr_abs(  &mpfr, &mpfr, MPFR_RNDN) }
    public func sqrt()       { mpfr_sqrt( &mpfr, &mpfr, MPFR_RNDN) }
    public func sqrt3()      { mpfr_cbrt( &mpfr, &mpfr, MPFR_RNDN) }
    public func Z()          { mpfr_zeta( &mpfr, &mpfr, MPFR_RNDN) }
    public func ln()         { mpfr_log(  &mpfr, &mpfr, MPFR_RNDN) }
    public func log10()      { mpfr_log10(&mpfr, &mpfr, MPFR_RNDN) }
    public func log2()       { mpfr_log2 (&mpfr, &mpfr, MPFR_RNDN) }
    public func sin()        { mpfr_sin(  &mpfr, &mpfr, MPFR_RNDN) }
    public func cos()        { mpfr_cos(  &mpfr, &mpfr, MPFR_RNDN) }
    public func tan()        { mpfr_tan(  &mpfr, &mpfr, MPFR_RNDN) }
    public func asin()       { mpfr_asin( &mpfr, &mpfr, MPFR_RNDN) }
    public func acos()       { mpfr_acos( &mpfr, &mpfr, MPFR_RNDN) }
    public func atan()       { mpfr_atan( &mpfr, &mpfr, MPFR_RNDN) }
    public func sinh()       { mpfr_sinh( &mpfr, &mpfr, MPFR_RNDN) }
    public func cosh()       { mpfr_cosh( &mpfr, &mpfr, MPFR_RNDN) }
    public func tanh()       { mpfr_tanh( &mpfr, &mpfr, MPFR_RNDN) }
    public func asinh()      { mpfr_asinh(&mpfr, &mpfr, MPFR_RNDN) }
    public func acosh()      { mpfr_acosh(&mpfr, &mpfr, MPFR_RNDN) }
    public func atanh()      { mpfr_atanh(&mpfr, &mpfr, MPFR_RNDN) }
    public func pow_x_2()    { mpfr_sqr(  &mpfr, &mpfr, MPFR_RNDN) }
    public func pow_e_x()    { mpfr_exp(  &mpfr, &mpfr, MPFR_RNDN) }
    public func pow_10_x()   { mpfr_exp10(&mpfr, &mpfr, MPFR_RNDN) }
    public func changeSign() { mpfr_neg(  &mpfr, &mpfr, MPFR_RNDN) }
    
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
        }
        rad_deg_precision = precision
    }
    
    public func sinD()  { SwiftGmp.check(precision); mpfr_mul(&mpfr, &mpfr, &SwiftGmp.deg2rad!.mpfr, MPFR_RNDN); mpfr_sin(  &mpfr, &mpfr, MPFR_RNDN) }
    public func cosD()  { SwiftGmp.check(precision); mpfr_mul(&mpfr, &mpfr, &SwiftGmp.deg2rad!.mpfr, MPFR_RNDN); mpfr_cos(  &mpfr, &mpfr, MPFR_RNDN) }
    public func tanD()  { SwiftGmp.check(precision); mpfr_mul(&mpfr, &mpfr, &SwiftGmp.deg2rad!.mpfr, MPFR_RNDN); mpfr_tan(  &mpfr, &mpfr, MPFR_RNDN) }
    public func asinD() { SwiftGmp.check(precision); mpfr_asin( &mpfr, &mpfr, MPFR_RNDN); mpfr_mul(&mpfr, &mpfr, &SwiftGmp.rad2deg!.mpfr, MPFR_RNDN) }
    public func acosD() { SwiftGmp.check(precision); mpfr_acos( &mpfr, &mpfr, MPFR_RNDN); mpfr_mul(&mpfr, &mpfr, &SwiftGmp.rad2deg!.mpfr, MPFR_RNDN) }
    public func atanD() { SwiftGmp.check(precision); mpfr_atan( &mpfr, &mpfr, MPFR_RNDN); mpfr_mul(&mpfr, &mpfr, &SwiftGmp.rad2deg!.mpfr, MPFR_RNDN) }
    
    public func π() {
        mpfr_const_pi(&mpfr, MPFR_RNDN)
    }
    public func e() {
        mpfr_exp( &mpfr, &SwiftGmp(withString: "1.0", precision: precision).mpfr, MPFR_RNDN)
        /// Note: mpfr_const_euler() returns 0.577..., not 2.718
    }
    
    public func rand() {
        if SwiftGmp.randstate == nil {
            SwiftGmp.randstate = gmp_randstate_t()
            __gmp_randinit_mt(&SwiftGmp.randstate!)
            __gmp_randseed_ui(&SwiftGmp.randstate!, UInt.random(in: 0..<UInt.max));
        }
        mpfr_urandom(&mpfr, &SwiftGmp.randstate!, MPFR_RNDN)
    }
    
    
    public func pow_x_3()    { mpfr_pow_ui(&mpfr, &mpfr, 3, MPFR_RNDN) }
    public func pow_2_x()    { mpfr_ui_pow(&mpfr, 2, &mpfr, MPFR_RNDN) }
    public func rez()        { mpfr_ui_div(&mpfr, 1, &mpfr, MPFR_RNDN) }
    public func fac() {
        let n = mpfr_get_si(&mpfr, MPFR_RNDN)
        if n >= 0 {
            let un = UInt(n)
            mpfr_fac_ui(&mpfr, un, MPFR_RNDN)
        } else {
            mpfr_set_d(&mpfr, 0.0, MPFR_RNDN)
        }
    }
    
    public func execute(_ op: twoOperantsType, with other: SwiftGmp) { op(self)(other) }
    public func add (other: SwiftGmp) { mpfr_add(&mpfr, &mpfr, &other.mpfr, MPFR_RNDN) }
    public func sub (other: SwiftGmp) {
        mpfr_sub(&mpfr, &mpfr, &other.mpfr, MPFR_RNDN)
    }
    public func mul (other: SwiftGmp) { mpfr_mul(&mpfr, &mpfr, &other.mpfr, MPFR_RNDN) }
    public func div (other: SwiftGmp) { mpfr_div(&mpfr, &mpfr, &other.mpfr, MPFR_RNDN) }
    
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
    
    public func toDouble() -> Double {
        return mpfr_get_d(&mpfr, MPFR_RNDN)
    }
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
        
    public static func memorySize(bits: Int) -> Int {
        mpfr_custom_get_size(bits)
    }
}

