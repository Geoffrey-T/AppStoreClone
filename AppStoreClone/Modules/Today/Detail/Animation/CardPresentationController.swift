//
//  CardPresentationController.swift
//  AppStoreClone
//
//  Created by geoffrey on 13/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

final class CardPresentationController: UIPresentationController {

    private lazy var blurView = UIVisualEffectView(effect: nil)

    override var shouldRemovePresentersView: Bool {
        return false
    }

    override func presentationTransitionWillBegin() {
        let container = containerView!
        blurView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(blurView)
        blurView.edges(to: container)
        blurView.alpha = 0.0

        presentingViewController.beginAppearanceTransition(false, animated: false)
        presentedViewController.transitionCoordinator!.animate(alongsideTransition: { (ctx) in
            UIView.animate(withDuration: 0.5, animations: {
                self.blurView.effect = UIBlurEffect(style: .light)
                self.blurView.alpha = 1
            })
        }) { (ctx) in }
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        presentingViewController.endAppearanceTransition()
    }

    override func dismissalTransitionWillBegin() {
        presentingViewController.beginAppearanceTransition(true, animated: true)
        presentedViewController.transitionCoordinator!.animate(alongsideTransition: { (ctx) in
            self.blurView.alpha = 0.0
        }, completion: nil)
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        presentingViewController.endAppearanceTransition()
        if completed {
            blurView.removeFromSuperview()
        }
    }
}
