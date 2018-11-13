//
//  BluredTabBar.swift
//  AppStoreClone
//
//  Created by geoffrey on 13/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

class BlurredTabBar: UITabBar {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        isTranslucent = true
//
//        let blurredMask = UIVisualEffectView(effect: UIBlurEffect(style: .light))
//        blurredMask.frame = bounds
//        blurredMask.autoresizingMask = .flexibleWidth
//        barTintColor = UIColor.clear
//        backgroundColor = UIColor.clear
//
//        insertSubview(blurredMask, at: 0)
        let blurredMask = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurredMask.frame = bounds
        blurredMask.autoresizingMask = .flexibleWidth
        insertSubview(blurredMask, at: 0)
    }

}
