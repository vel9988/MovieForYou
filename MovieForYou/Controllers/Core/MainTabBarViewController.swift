//
//  MainTabBarViewController.swift
//  MovieForYou
//
//  Created by Dmitryi Velko on 21.12.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupViewControllers()
        
    }
    
    private func setupViewControllers() {
        let vc1 = HomeViewController()
        let vc2 = MyViewController()
        let vc3 = SearchViewController()
        let vc4 = ProfileViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "star")
        vc3.tabBarItem.image = UIImage(systemName: "text.magnifyingglass") // sparkle.magnifyingglass
        vc4.tabBarItem.image = UIImage(systemName: "person") // person.fill
        
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "sparkle.magnifyingglass")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "person.fill")

        vc1.title = "Главное"
        vc2.title = "Мое"
        vc3.title = "Поиск"
        vc4.title = "Профиль"
        
        tabBar.tintColor = .label

        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }


}

