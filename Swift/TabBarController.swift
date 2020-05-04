//
//  TabBarController.swift
//  Users
//
//  Created by Nitigya Kapoor on 03/04/20.
//

import UIKit

class MasterTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTabs()
    }
    
    fileprivate func setupTabs(){
        
        
        let navigationController = UINavigationController(rootViewController: TableViewController())
        navigationController.navigationBar.prefersLargeTitles = true
        
        let userScreenController = navigationController
        userScreenController.tabBarItem = UITabBarItem(title : "Posts", image : UIImage(systemName: "square.and.pencil")!, tag: 0)
        
        let sampleScreenController = HomeScreen()
        sampleScreenController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person")!, tag: 1)

        viewControllers = [userScreenController,sampleScreenController]
        
    }
    
    fileprivate func setupLayout(){
        tabBar.isTranslucent = true
    }
}


