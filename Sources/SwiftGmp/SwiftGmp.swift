import Foundation
import SwiftGmp_C_Target

public enum MantissaExponentType {
    case unknown
    case integer
    case floatLargerThanOne
    case floatSmallerThanOne
    case scientifiNotation
}

public struct Raw {
    public var mantissa: String
    public var exponent: Int
    public var isNegative: Bool
    init(mantissa: String, exponent: Int) {
        if mantissa.hasPrefix("-") {
            self.mantissa = String(mantissa.dropFirst())
            isNegative = true
        } else {
            self.mantissa = mantissa
            isNegative = false
        }
        self.exponent = exponent
    }
    var negativeSign: String {
        isNegative ? "-" : ""
    }
}

class SwiftGmp: Equatable, CustomDebugStringConvertible {
    
    
    private(set) var bits: Int
    private static var rad_deg_bits: Int = 10
    private static var deg2rad: SwiftGmp = SwiftGmp(bits: rad_deg_bits)
    private static var rad2deg: SwiftGmp = SwiftGmp(bits: rad_deg_bits)
    
    private var mpfr = mpfr_t()

    init(bits: Int) {
        self.bits = bits
        mpfr_init2(&mpfr, bits) // nan
    }
    
    init(withString string: String, bits: Int) {
        let without_ = string.replacingOccurrences(of: "_", with: "")
        self.bits = bits

        mpfr_init2(&mpfr, bits) // nan
        mpfr_set_str (&mpfr, without_, 10, MPFR_RNDN)
    }
    
    init(withSwiftGmp: SwiftGmp, bits: Int) {
        self.bits = bits

        mpfr_init2(&mpfr, bits) // nan
        mpfr_set(&mpfr, &withSwiftGmp.mpfr, MPFR_RNDN)
    }
    
    deinit {
        mpfr_clear(&mpfr)
    }
    
    static func == (lhs: SwiftGmp, rhs: SwiftGmp) -> Bool {
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
    
    var debugDescription: String {
        guard !isNan else { return "nan"}
        guard isValid else { return "not valid"}
        guard !isZero else { return "zero"}
        let mantissaExponent = raw()
        return "\(mantissaExponent.mantissa) \(mantissaExponent.exponent)"
    }
    
    static func isValidSwiftGmpString(_ gmpString: String, bits: Int) -> Bool {
        var temp_mpfr: mpfr_t = mpfr_t(_mpfr_prec: 0, _mpfr_sign: 0, _mpfr_exp: 0, _mpfr_d: nil)
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
    func toDouble() -> Double {
        return mpfr_get_d(&mpfr, MPFR_RNDN)
    }
    static func memorySize(bits: Int) -> Int {
        mpfr_custom_get_size(bits)
    }
    
    func raw(digits digitsParameter: Int? = nil) -> Raw {
        var digits: Int = bits / 3
        if let digitsParameter {
            digits = digitsParameter
        }
        var exponent: mpfr_exp_t = 0
        
        var charArray: Array<CChar> = Array(repeating: 0, count: digits+3)
        mpfr_get_str(&charArray, &exponent, 10, digits + 3, &mpfr, MPFR_RNDN)
        var mantissa: String = ""
        
        charArray.withUnsafeBufferPointer { ptr in
            mantissa = String(cString: ptr.baseAddress!)
        }
        
        mantissa.removeTrailingZeroes()

        if mantissa.count >= digits + 3 {
            var no999 = false
            let suffix = mantissa.suffix(3)
            for s in suffix {
                if s != "9" {
                    no999 = true
                }
            }
            mantissa.removeLast(3)
            if !no999 {
                if mantissa.incrementAbsIntegerValue() { exponent += 1 }
            }
        }
        
        mantissa.removeTrailingZeroes()
        if mantissa == "" { mantissa = "0" }
        
        return Raw(mantissa: mantissa, exponent: exponent - 1)
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
    
    func execute(_ twoOperantOperation: TwoOperantOperation, other: SwiftGmp) {
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
        case .powxy:
            mpfr_pow(&mpfr, &temp, &other.mpfr, MPFR_RNDN)
        case .powyx:
            mpfr_pow(&mpfr, &other.mpfr, &temp, MPFR_RNDN)
        case .sqrty:
            other.execute(.rez)
            execute(.powxy, other: other)
        case .logy:
            other.execute(.ln)
            self.execute(.ln)
            execute(.div, other: other)
        case .EE:
            other.execute(.exp10)
            execute(.mul, other: other)
        }
    }
    func execute(_ constOp: ConstantOperation) {
        switch constOp {
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
        }
    }
    
    func execute(_ inplaceOp: InplaceOperation) {
        switch inplaceOp {
        case .abs:
            var temp = mpfr; mpfr_abs(  &mpfr, &temp, MPFR_RNDN)
        case .floor:
            var temp = mpfr; mpfr_floor(&mpfr, &temp)
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
        case .sind:
            check(bits: bits)
            var temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.deg2rad.mpfr, MPFR_RNDN); temp = mpfr; mpfr_sin(  &mpfr, &temp, MPFR_RNDN)
        case .cosd:
            check(bits: bits)
            var temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.deg2rad.mpfr, MPFR_RNDN); temp = mpfr; mpfr_cos(  &mpfr, &temp, MPFR_RNDN)
        case .tand:
            check(bits: bits)
            var temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.deg2rad.mpfr, MPFR_RNDN); temp = mpfr; mpfr_tan(  &mpfr, &temp, MPFR_RNDN)
        case .asind:
            check(bits: bits)
            var temp = mpfr; mpfr_asin( &mpfr, &temp, MPFR_RNDN); temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.rad2deg.mpfr, MPFR_RNDN)
        case .acosd:
            check(bits: bits)
            var temp = mpfr; mpfr_acos( &mpfr, &temp, MPFR_RNDN); temp = mpfr; mpfr_mul(&mpfr, &temp, &SwiftGmp.rad2deg.mpfr, MPFR_RNDN)
        case .atand:
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
    
    func x_double_up_arrow_y(other: SwiftGmp) {
        var temp: mpfr_t = mpfr_t(_mpfr_prec: 0, _mpfr_sign: 0, _mpfr_exp: 0, _mpfr_d: nil)
        mpfr_init2 (&temp, mpfr_get_prec(&mpfr))
        mpfr_set(&temp, &mpfr, MPFR_RNDN)
        
        let counter: CLong = mpfr_get_si(&other.mpfr, MPFR_RNDN) - 1
        guard counter > 0 else { return }
        for _ in 0..<counter {
            mpfr_pow(&mpfr, &temp, &mpfr, MPFR_RNDN)
        }
        mpfr_clear(&temp)
    }
    
    public func similar(to other: SwiftGmp, precision: Double = 1e-3) -> Bool {
        let abs = self.copy()
        abs.execute(InplaceOperation.abs)
        abs.execute(TwoOperantOperation.sub, other: SwiftGmp.init(withString: "1000", bits: bits))
        if abs.isNegative() {
            // smaller than 1000
            // return abs(self - other) <= precision
            let diff = self.copy()
            diff.execute(TwoOperantOperation.sub, other: other)
            diff.execute(InplaceOperation.abs)
            let threshold = SwiftGmp(withString: String(precision), bits: bits)
            threshold.execute(TwoOperantOperation.sub, other: diff)
            return !threshold.isNegative()
        } else {
            // larger than 1000
            // return abs(self - other) <= precision * abs(self)
            let diff = self.copy()
            diff.execute(TwoOperantOperation.sub, other: other)
            diff.execute(InplaceOperation.abs)
            let threshold = SwiftGmp(withString: String(precision), bits: bits)
            threshold.execute(TwoOperantOperation.sub, other: diff)
            return !threshold.isNegative()
        }
    }

//    func isSimilar(d1: Double, d2: Double) -> Bool {
//        let n = 6  // Number of significant digits to compare
//        let digits1 = extractDigits(d1, n: n)
//        let digits2 = extractDigits(d2, n: n)
//        return digits1 == digits2
//    }
}


extension String {
    public mutating func removeTrailingZeroes() {
        // Loop to remove trailing "0" characters
        while self.last == "0" {
            self.removeLast()
        }
    }
    
    mutating func incrementAbsIntegerValue() -> Bool {
        if self.last != nil {
            if self.last == "9" {
                self.removeLast()
                let exponentNeedsToIncrease = self.incrementAbsIntegerValue()
                return exponentNeedsToIncrease
            } else {
                let new = String(Int(String(self.last!))! + 1)
                self.removeLast()
                self += new
                return false
            }
        } else {
            self = "1"
            return true
        }
    }
}

