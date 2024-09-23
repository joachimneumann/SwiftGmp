import Foundation
import MyCTarget

@MainActor var globalUnsignedLongInt: CUnsignedLong = 0

@MainActor
class SwiftGmp {
    private var bits: Int = 0
    private(set) var precision: Int = 0
    
    /// init with zeros. The struct will be initialized correctly in init() with mpfr_init2()
    private var mpfr: mpfr_t = mpfr_t(_mpfr_prec: 0, _mpfr_sign: 0, _mpfr_exp: 0, _mpfr_d: &globalUnsignedLongInt)
}
