//
//  PresentCardAnimator.swift
//  AppStoreClone
//
//  Created by geoffrey on 13/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

class PresentCardAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private let params: Params

    struct Params {
        let fromCardFrame: CGRect
        let fromCell: BaseCardCell
    }

    private let presentAnimationDuration: TimeInterval
    private let springAnimator: UIViewPropertyAnimator
    private var transitionDriver: PresentCardTransitionDriver?

    init(params: Params) {
        self.params = params
        self.springAnimator = PresentCardAnimator.createBaseSpringAnimator(params: params)
        self.presentAnimationDuration = springAnimator.duration
        super.init()
    }

    private static func createBaseSpringAnimator(params: PresentCardAnimator.Params) -> UIViewPropertyAnimator {
        let cardPositionY = params.fromCardFrame.minY
        let distanceToBounce = abs(params.fromCardFrame.minY)
        let extentToBounce = cardPositionY < 0 ? params.fromCardFrame.height : UIScreen.main.bounds.height
        let dampFactorInterval: CGFloat = 0.3
        let damping: CGFloat = 1.0 - dampFactorInterval * (distanceToBounce / extentToBounce)

        let baselineDuration: TimeInterval = 0.5
        let maxDuration: TimeInterval = 0.9
        let duration: TimeInterval = baselineDuration + (maxDuration - baselineDuration) * TimeInterval(max(0, distanceToBounce)/UIScreen.main.bounds.height)

        let springTiming = UISpringTimingParameters(dampingRatio: damping, initialVelocity: .init(dx: 0, dy: 0))
        return UIViewPropertyAnimator(duration: duration, timingParameters: springTiming)
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presentAnimationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionDriver = PresentCardTransitionDriver(params: params,
                                                       transitionContext: transitionContext,
                                                       baseAnimator: springAnimator)
        interruptibleAnimator(using: transitionContext).startAnimation()
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return transitionDriver!.animator
    }

    func animationEnded(_ transitionCompleted: Bool) {
        transitionDriver = nil
    }
}

class PresentCardTransitionDriver {
    let animator: UIViewPropertyAnimator
    init(params: PresentCardAnimator.Params, transitionContext: UIViewControllerContextTransitioning, baseAnimator: UIViewPropertyAnimator) {
        let ctx = transitionContext
        guard let cardDetail = ctx.viewController(forKey: .to) as? CardDetailViewController,
            let cardDetailView = ctx.view(forKey: .to) else {
                animator = baseAnimator
            return
        }

        let container = ctx.containerView
        let fromCardFrame = params.fromCardFrame

        // Temporary container view for animation
        let animatedContainerView = UIView()
        animatedContainerView.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(animatedContainerView)

        do {
            let animatedContainerConstraints = [
                animatedContainerView.widthAnchor.constraint(equalToConstant: container.bounds.width),
                animatedContainerView.heightAnchor.constraint(equalToConstant: container.bounds.height),
                animatedContainerView.centerXAnchor.constraint(equalTo: container.centerXAnchor)
            ]
            NSLayoutConstraint.activate(animatedContainerConstraints)
        }

        let animatedContainerVerticalConstraint: NSLayoutConstraint = {
            return animatedContainerView.centerYAnchor.constraint(
                equalTo: container.centerYAnchor,
                constant: (fromCardFrame.height/2 + fromCardFrame.minY) - container.bounds.height/2
            )
        }()

        animatedContainerVerticalConstraint.isActive = true

        animatedContainerView.addSubview(cardDetailView)
        cardDetailView.translatesAutoresizingMaskIntoConstraints = false

        do {
            let verticalAnchor: NSLayoutConstraint = {
                return cardDetailView.centerYAnchor.constraint(equalTo: animatedContainerView.centerYAnchor)
            }()
            let cardConstraints = [
                verticalAnchor,
                cardDetailView.centerXAnchor.constraint(equalTo: animatedContainerView.centerXAnchor),
                ]
            NSLayoutConstraint.activate(cardConstraints)
        }
        let cardWidthConstraint = cardDetailView.widthAnchor.constraint(equalToConstant: fromCardFrame.width)
        let cardHeightConstraint = cardDetailView.heightAnchor.constraint(equalToConstant: fromCardFrame.height)
        NSLayoutConstraint.activate([cardWidthConstraint, cardHeightConstraint])

        //
        cardDetailView.layer.cornerRadius = 20

        params.fromCell.isHidden = true
        params.fromCell.transform = .identity

        container.layoutIfNeeded()

        func animateContainerBouncingUp() {
            animatedContainerVerticalConstraint.constant = 0
            container.layoutIfNeeded()
        }

        func animateCardDetailViewSizing() {
            cardWidthConstraint.constant = animatedContainerView.bounds.width
            cardHeightConstraint.constant = animatedContainerView.bounds.height

            cardDetail.contentCardView.layer.cornerRadius = 0

            container.layoutIfNeeded()
        }

        func completeEverything() {
            animatedContainerView.removeConstraints(animatedContainerView.constraints)
            animatedContainerView.removeFromSuperview()

            container.addSubview(cardDetailView)

            cardDetailView.removeConstraints([cardWidthConstraint, cardHeightConstraint])

            cardDetailView.edges(to: container, top: -1)

            let success = !ctx.transitionWasCancelled
            ctx.completeTransition(success)
        }

        baseAnimator.addAnimations {
            animateContainerBouncingUp()

            let cardExpanding = UIViewPropertyAnimator(duration: baseAnimator.duration * 0.6, curve: .linear) {
                animateCardDetailViewSizing()
            }
            cardExpanding.startAnimation()
        }

        baseAnimator.addCompletion { (_) in
            completeEverything()
        }

        self.animator = baseAnimator
    }
}
