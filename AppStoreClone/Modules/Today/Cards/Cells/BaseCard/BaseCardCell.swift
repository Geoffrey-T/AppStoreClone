//
//  BaseCardCell.swift
//  AppStoreClone
//
//  Created by geoffrey thenot on 12/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

class BaseCardCell: UICollectionViewCell {
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 20.0
    private var fillColor: UIColor = .gray

    var disabledHighlightedAnimation = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.white
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()

            shadowLayer.masksToBounds = false
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor

            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 10)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 8

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }

    func freezeAnimations() {
        disabledHighlightedAnimation = true
        layer.removeAllAnimations()
    }

    func unfreezeAnimations() {
        disabledHighlightedAnimation = false
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        if let touch = touches.first {
            let location = touch.location(in: self)
            if isOutside(location: location) {
                resetAnimation()
            } else {
                let rate = touch.force / touch.maximumPossibleForce
                let scaling = 1.0 - (rate / 8)
                UIView.animate(withDuration: 0.25) {
                    self.transform = CGAffineTransform(scaleX: scaling, y: scaling)
                }
            }
        }
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        resetAnimation()
    }

    private func resetAnimation() {
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
            self.transform = .identity
        })
    }

    private func isOutside(location: CGPoint) -> Bool {
        return location.x > bounds.maxX || location.x < 0
            || location.y > bounds.maxY || location.y < 0
    }
}
