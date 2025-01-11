//
//  UIApplication + Extensions.swift
//  SwiftExtensions
//
//  Created by jaydeep-godhani on 10/01/25.
//

import Foundation
import UIKit

extension UIApplication {
    
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
    
}
