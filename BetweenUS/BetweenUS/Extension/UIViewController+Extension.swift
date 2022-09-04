//
//  UIViewController+Extension.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/04.
//

import UIKit

extension UIViewController {
    func tabbarItem(title: String, image: String, selectedImage: String) {
        tabBarItem.title = title
        tabBarItem.image = UIImage(systemName: image)
        tabBarItem.selectedImage = UIImage(systemName: selectedImage)
    }
}
