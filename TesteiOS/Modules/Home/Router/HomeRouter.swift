//
//  HomeRouter.swift
//  TesteiOS
//
//  Created by resource on 29/09/19.
//  Copyright © 2019 leovalentim. All rights reserved.
//

import UIKit

// MARK: - Router
public class HomeRouter {
    
    weak var view: HomeViewController?
    
    static var storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle(for: HomeRouter.self))
    
    static func createModule() throws -> HomeViewController {
        guard let view = storyBoard.instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as? HomeViewController
            else {
                throw HomeEntity.Errors.homeNotConfigured
        }
        
        return view
    }
    
}
