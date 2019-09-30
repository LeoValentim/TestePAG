//
//  HomeViewController.swift
//  TesteiOS
//
//  Created by resource on 29/09/19.
//  Copyright © 2019 leovalentim. All rights reserved.
//

import UIKit


class HomeViewController: UITabBarController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        let moviesView = MoviesRouter.createModule() ?? UIViewController()
        let firstItem = UINavigationController()
        firstItem.viewControllers = [moviesView]
        firstItem.tabBarItem.title = "Filmes"
        firstItem.tabBarItem.image = UIImage(named: "list_icon")
        
        let favoritesView = FavoritesRouter.createModule() ?? UIViewController()
        let secondItem = UINavigationController()
        secondItem.viewControllers = [favoritesView]
        secondItem.tabBarItem.title = "Favoritos"
        secondItem.tabBarItem.image = UIImage(named: "favorite_empty_icon")
        
        viewControllers = [firstItem, secondItem]
    }
    
}
