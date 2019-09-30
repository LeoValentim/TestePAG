//
//  UINavigationController+extensions.swift
//  TesteiOS
//
//  Created by resource on 29/09/19.
//  Copyright © 2019 leovalentim. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    /// Pops all the view controllers on the stack except the root view controller and updates the display.
    /// - Parameter animated: Set this value to true to animate the transition.
    /// - Parameter completion: Sets the completion block object.
    public func popToRootViewController(animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
    
}
