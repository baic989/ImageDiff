//
//  Pixel.swift
//  ImageDiff
//
//  Created by Super Hrvoje on 23/10/2017.
//  Copyright © 2017 Hrvoje Baić. All rights reserved.
//

import Foundation

struct Pixel {
    
    // MARK: - Properties -
    
    let red: UInt8
    let green: UInt8
    let blue: UInt8
    let alpha: UInt8
    
    // MARK: - Lifecycle -
    
    init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    init(from pixel: Pixel) {
        self.init(red: pixel.red, green: pixel.green, blue: pixel.blue, alpha: pixel.alpha)
    }
}

// MARK: - Extensions -
// MARK: Equatable
extension Pixel: Equatable {
    static func ==(lhs: Pixel, rhs: Pixel) -> Bool {
        if lhs.red == rhs.red &&
            lhs.green == rhs.green &&
            lhs.blue == rhs.blue &&
            lhs.alpha == rhs.alpha {
            return true
        }
        return false
    }
}
