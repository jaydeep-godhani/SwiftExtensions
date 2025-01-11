//
//  UIImageView + Extensions.swift
//  SwiftExtensions
//
//  Created by jaydeep-godhani on 10/01/25.
//

import Foundation
import UIKit

extension UIImageView {
    
    var intrinsicScaledContentSize: CGSize? {
        switch contentMode {
        case .scaleAspectFit:
            if let image = self.image {
                let imageWidth = image.size.width
                let imageHeight = image.size.height
                let viewWidth = self.frame.size.width
                
                let ratio = viewWidth/imageWidth
                let scaledHeight = imageHeight * ratio
                
                return CGSize(width: viewWidth, height: scaledHeight)
            }
        case .scaleAspectFill:
            if let image = self.image {
                let imageWidth = image.size.width
                let imageHeight = image.size.height
                let viewHeight = self.frame.size.width
                let ratio = viewHeight / imageHeight
                let scaledWidth = imageWidth * ratio
                return CGSize(width: scaledWidth, height: imageHeight)
            }
        default:
            return self.bounds.size
        }
        return nil
    }
    
}

