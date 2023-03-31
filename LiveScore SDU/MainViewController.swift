//
//  MainViewController.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 04.03.2023.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor.black
        tabBar.tintColor = .orange
//        tabBar.backgroundColor = .clear
        
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
        
        
        let vc1 = UINavigationController(rootViewController: ScoresViewController())
        let vc2 = UINavigationController(rootViewController: FavoritesViewController())
        let vc3 = UINavigationController(rootViewController: RefreshViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "soccerball.inverse")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "soccerball.inverse")
        vc2.tabBarItem.image = UIImage(systemName: "star")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        vc3.tabBarItem.image = UIImage(systemName: "repeat")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "repeat.fill")
        
        vc1.title = "Scores"
        vc2.title = "Favorites"
        vc3.title = "Refresh"
        
        setViewControllers([vc1, vc2, vc3], animated: true)
        
    }

}
