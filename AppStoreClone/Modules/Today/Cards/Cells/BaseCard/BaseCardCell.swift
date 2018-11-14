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
        backgroundColor = UIColor.clear
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
}
