//
//  UIAlertController+Extension.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/04.
//

import UIKit

extension UIAlertController {
    static func createAlert(
        title: String? = nil,
        message: String? = nil,
        style: UIAlertController.Style = .alert
    ) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: style
        )
        
        return alert
    }
    
    func addAction(
        title: String,
        style: UIAlertAction.Style = .default,
        completion: (() -> Void)? = nil
    ) -> UIAlertController {
        let action = UIAlertAction(
            title: title,
            style: style) { _ in
                completion?()
            }
        
        self.addAction(action)
        
        return self
    }
}
