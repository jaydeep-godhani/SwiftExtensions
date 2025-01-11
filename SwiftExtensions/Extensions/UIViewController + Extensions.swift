//
//  UIViewController + Extensions.swift
//  SwiftExtensions
//
//  Created by jaydeep-godhani on 10/01/25.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(message: String, title: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
