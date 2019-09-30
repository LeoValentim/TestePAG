//
//  AppDelegate.swift
//  TesteiOS
//
//  Created by resource on 29/09/19.
//  Copyright © 2019 leovalentim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        do {
            let viewController = try HomeRouter.createModule()
            let navigation = UINavigationController()
            navigation.viewControllers = [viewController]
            window?.rootViewController = navigation
            window?.makeKeyAndVisible()
            
            AppNavigator.shared.setContext(to: navigation)
        } catch {
            fatalError(error.localizedDescription)
        }
        
        return true
    }


}

