//
//  UIViewController + Alert.swift
//  SwiftExtensions
//
//  Created by jaydeep-godhani on 10/01/25.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayAlert(alertMessage: String) {
        let okayButton = CustomAction(title: "OK", actionStyle: .default, handler: nil)
        let alert = CustomAlert(message: alertMessage, preferredStyle: .alert, actions: [okayButton])
        presentCustomAlert(alert)
    }
    
    func presentAnimatedAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
        let duration: Double = 1
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true)
        }
    }
    
    func presentCustomAlert(_ alert: CustomAlert) {
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.preferredStyle)
        
        for action in alert.actions {
            let alertAction = UIAlertAction(title: action.title, style: action.actionStyle, handler: action.handler)
            
            alertController.addAction(alertAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
}

struct CustomAlert {
    
    let actions: [CustomAction]
    let message: String?
    let preferredStyle: UIAlertController.Style
    let title: String?
    
    init(title: String? = "Motivation", message: String? = nil, preferredStyle: UIAlertController.Style = .alert, actions: [CustomAction] = [CustomAction()]) {
        self.actions = actions
        self.message = message
        self.preferredStyle = preferredStyle
        self.title = title
    }
    
}

struct CustomAction {
    
    let handler: ((UIAlertAction) -> Void)?
    let actionStyle: UIAlertAction.Style
    let title: String
    
    init(title: String = "OK", actionStyle: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) {
        self.handler = handler
        self.actionStyle = actionStyle
        self.title = title
    }
    
}
