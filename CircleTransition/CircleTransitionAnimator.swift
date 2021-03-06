//
//  CircleTransitionAnimator.swift
//  CircleTransition
//
//  Created by mc373 on 13.05.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class CircleTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

	weak var transitionContext: UIViewControllerContextTransitioning?

	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?)
		-> NSTimeInterval {

			return 0.5
	}

	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		//1
		self.transitionContext = transitionContext

		//2
		let containerView = transitionContext.containerView()
		// swiftlint:disable line_length
		// swiftlint:disable:next force_cast
		let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! CircleViewController
		// swiftlint:disable:next force_cast
		let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! CircleViewController
		// swiftlint:enable line_length
		let button = fromViewController.button

		//3
		containerView!.addSubview(toViewController.view)

		//4
		// swiftlint:disable line_length
		// swiftlint:disable legacy_cggeometry_functions
		let circleMaskPathInitial = UIBezierPath(ovalInRect: button.frame)
		let extremePoint = CGPoint(x: button.center.x - 0, y: button.center.y - CGRectGetHeight(toViewController.view.bounds))
		let radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y))
		let circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(button.frame, -radius, -radius))

		// swiftlint:enable line_length
		// swiftlint:enable legacy_cggeometry_functions
		//5
		let maskLayer = CAShapeLayer()
		maskLayer.path = circleMaskPathFinal.CGPath
		toViewController.view.layer.mask = maskLayer

		//6
		let maskLayerAnimation = CABasicAnimation(keyPath: "path")
		maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
		maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
		maskLayerAnimation.duration = self.transitionDuration(transitionContext)
		maskLayerAnimation.delegate = self
		maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
	}

	override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
		self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())

		// swiftlint:disable:next line_length
		self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
	}

}
