//
// Created by MrYu87 on 12/28/17.
// Copyright (c) 2017 MrYu87. All rights reserved.
//

extension UInt256: Comparable {
    public static func <(lhs: UInt256, rhs: UInt256) -> Bool {
        for i in 0..<4 {
            if lhs[i] < rhs[i] {
                return true
            } else if lhs[i] > rhs[i] {
                return false
            }
        }

        return false
    }

    public static func >(lhs: UInt256, rhs: UInt256) -> Bool {
        return rhs < lhs
    }

    public static func <=(lhs: UInt256, rhs: UInt256) -> Bool {
        return lhs == rhs || lhs < rhs
    }

    public static func >=(lhs: UInt256, rhs: UInt256) -> Bool {
        return lhs == rhs || lhs > rhs
    }
}
