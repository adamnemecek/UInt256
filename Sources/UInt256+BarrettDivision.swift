//

import Foundation

extension UInt256 {
    static func barrettDivision(
        of dividend: (high: UInt256, low: UInt256),
        by divisor: UInt256,
        withPrecomputedInverse inv: (high: UInt256, low: UInt256)
        )
        -> (quotient: UInt256, remainder: UInt256)
    {
        let q1 = dividend.high
        let q0 = dividend.high.multipliedFullWidth(by: inv.low)
        let q = q1.addingReportingOverflow(q0.high)
        var qb = q.partialValue.multipliedFullWidth(by: divisor)
        if q.overflow {
            qb.high = qb.high + divisor
        }
        var rL = dividend.low.subtractingReportingOverflow(qb.low)
        var rH = dividend.high.subtractingReportingOverflow(qb.high)
        if rL.overflow {
            rH.partialValue = rH.partialValue - 1
        }

        var quotient = q.partialValue
        while rH.partialValue > 0 || rL.partialValue >= divisor {
            quotient = quotient + 1
            rL = rL.partialValue.subtractingReportingOverflow(divisor)
            if rL.overflow && rH.partialValue > 0 {
                rH.partialValue = rH.partialValue - 1
            }
        }
        return (quotient, rL.partialValue)
    }
}