//
//  MainTabbarViewController.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/04.
//

import UIKit

final class MainTabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabbar()
    }
    
    private func configureTabbar() {
        let homeVC = HomeViewController()
        let dayVC = DayViewController()
        let galleryVC = GalleryViewController()
        let profileVC = ProfileViewController()
        
        homeVC.tabbarItem(title: "홈", image: "house", selectedImage: "house.fill")
        dayVC.tabbarItem(title: "일정", image: "calendar", selectedImage: "calendar")
        galleryVC.tabbarItem(title: "갤러리", image: "photo", selectedImage: "photo.fill")
        profileVC.tabbarItem(title: "프로필", image: "person", selectedImage: "person.fill")
        
        tabBar.tintColor = .darkTintColor
        tabBar.unselectedItemTintColor = .lightTintColor
        
        setViewControllers([homeVC, dayVC, galleryVC, profileVC], animated: true)
    }
    
}
