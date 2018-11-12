//
//  CollectionView+extension.swift
//  AppStoreClone
//
//  Created by geoffrey thenot on 12/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    // MARK: - CollectionViewCell Registration -
    
    func register(nibName name: String, forCellWithReuseIdentifier identifier: String? = nil, bundle: Bundle? = nil) {
        let nib = UINib(nibName: name, bundle: bundle)
        self.register(nib, forCellWithReuseIdentifier: identifier ?? name)
    }
}
