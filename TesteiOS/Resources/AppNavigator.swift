//
//  AppNavigator.swift
//  TesteiOS
//
//  Created by resource on 29/09/19.
//  Copyright © 2019 leovalentim. All rights reserved.
//

import UIKit

public class AppNavigator {
    
    /// Main context: UINavigationController.
    private(set) weak var context: UINavigationController?
    
    /// Shared class instance. (Singleton)
    public static let shared = AppNavigator()
    
    /// Defines the app main context.
    ///
    /// - Parameter context: UINavigationController
    public func setContext(to context: UINavigationController) {
        self.context = context
    }
    
}
