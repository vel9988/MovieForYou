//
//  MainTabBarViewController.swift
//  MovieForYou
//
//  Created by Dmitryi Velko on 21.12.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupViewControllers()
        
    }
    
    // MARK: - Private methods
    private func setupViewControllers() {
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: MyViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: ProfileViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "star")
        vc3.tabBarItem.image = UIImage(systemName: "text.magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "person")
        
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "sparkle.magnifyingglass")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "person.fill")

        vc1.title = "Home"
        vc2.title = "My"
        vc3.title = "Search"
        vc4.title = "Profile"
        
        tabBar.tintColor = .label

        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }


}

