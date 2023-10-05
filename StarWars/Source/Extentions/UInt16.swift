//
//  UInt16.swift
//  StarWars
//
//  Created by Roman on 9/22/23.
//

import Foundation

public extension ExpressibleByIntegerLiteral {
    static func arc4random() -> Self {
        var r: Self = 0
        arc4random_buf(&r, MemoryLayout<Self>.size)
        return r
    }
}
