//
//  CACornerMask + Extensions.swift
//  SwiftExtensions
//
//  Created by jaydeep-godhani on 10/01/25.
//

import Foundation
import UIKit

extension CACornerMask {
    
    static func AllCorner() -> CACornerMask {
        return [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    static func topTwoCorner() -> CACornerMask {
        return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    static func bottomTwoCorner() -> CACornerMask {
        return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    static func LR_BL() -> CACornerMask {
        return [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    static func R_BRL() -> CACornerMask {
        return [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
}
