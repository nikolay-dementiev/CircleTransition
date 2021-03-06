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
	// swiftlint:disable:next line_length
	func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

		return  CircleTransitionAnimator()
	}

	//MARK: An Interactive Gesture Animation
	@IBOutlet weak var navigationController: UINavigationController?

	var interactionController: UIPercentDrivenInteractiveTransition?

	// swiftlint:disable line_length
	func navigationController(navigationController: UINavigationController,
	                          interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		// swiftlint:enable line_length
		return self.interactionController
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		// swiftlint:disable:next line_length
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(NavigationControllerDelegate.panned(_:)))
		self.navigationController!.view.addGestureRecognizer(panGesture)
	}

	//1
	@IBAction func panned(gestureRecognizer: UIPanGestureRecognizer) {
		switch gestureRecognizer.state {
		case .Began:
			self.interactionController = UIPercentDrivenInteractiveTransition()
			if self.navigationController?.viewControllers.count > 1 {
				self.navigationController?.popViewControllerAnimated(true)
			} else {
				// swiftlint:disable:next line_length
				self.navigationController?.topViewController!.performSegueWithIdentifier("PushSegue", sender: nil)
			}

		//2
		case .Changed:
			let translation = gestureRecognizer.translationInView(self.navigationController!.view)
			// swiftlint:disable legacy_cggeometry_functions
			let completionProgress = translation.x/CGRectGetWidth(self.navigationController!.view.bounds)

			self.interactionController?.updateInteractiveTransition(completionProgress)

		//3
		case .Ended:
			// swiftlint:disable:next control_statement
			if (gestureRecognizer.velocityInView(self.navigationController!.view).x > 0) {
				self.interactionController?.finishInteractiveTransition()
			} else {
				self.interactionController?.cancelInteractiveTransition()
			}
			self.interactionController = nil

		//4
		default:
			self.interactionController?.cancelInteractiveTransition()
			self.interactionController = nil
		}
	}
}
