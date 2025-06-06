//
//  TabBarViewController.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 06/06/25.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repositories = JavaRepositoriesViewController(favoriteTab: false)
        let favorites = JavaRepositoriesViewController(favoriteTab: true)
        
        repositories.tabBarItem = UITabBarItem(title: "Repos", image: UIImage(systemName: "house.fill"), tag: 0)
        favorites.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 1)
        
        let controllers = [repositories, favorites]
        self.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
    }
}
