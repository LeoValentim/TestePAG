//
//  UIApplication+extensions.swift
//  TesteiOS
//
//  Created by resource on 29/09/19.
//  Copyright © 2019 leovalentim. All rights reserved.
//

import UIKit

extension UIApplication {
    
    /// Current presented view controller
    public var topViewController: UIViewController? {
        guard var topController: UIViewController = keyWindow?.rootViewController else {return nil}
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
    
}
