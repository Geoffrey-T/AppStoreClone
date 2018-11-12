//
//  BaseCardCell.swift
//  AppStoreClone
//
//  Created by geoffrey thenot on 12/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

class BaseCardCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.black
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.shadowOpacity = 0.6
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 14
        self.layer.cornerRadius = 20
    }

}
