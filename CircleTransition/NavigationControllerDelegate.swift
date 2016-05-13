//
//  NavigationControllerDelegate.swift
//  CircleTransition
//
//  Created by mc373 on 13.05.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
//    This method receives the two view controllers that the navigation controller is transitioning
//    between, and its job is to return an object that implements
//    UIViewControllerAnimatedTransitioning.
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return  CircleTransitionAnimator()
    }

}
