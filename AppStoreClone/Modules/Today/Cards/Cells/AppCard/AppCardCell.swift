//
//  AppCardCell.swift
//  AppStoreClone
//
//  Created by geoffrey thenot on 12/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

class AppCardCell: BaseCardCell {

    @IBOutlet weak var containerView: ContentCardView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
    }

}
