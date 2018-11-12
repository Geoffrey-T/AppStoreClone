//
//  CardCollectionViewController.swift
//  AppStoreClone
//
//  Created by geoffrey thenot on 12/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

class CardCollectionViewController: UICollectionViewController {
    struct Cell {
        struct articleCard {
            static let identifier = "ArticleCardCell"
            static let xib = String(describing: ArticleCardCell.self)
        }
        struct appCard {
            static let identifier = "AppCardCell"
            static let xib = String(describing: AppCardCell.self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    private func registerCells() {
        collectionView?.register(nibName: Cell.articleCard.xib, forCellWithReuseIdentifier: Cell.articleCard.identifier)
        collectionView?.register(nibName: Cell.appCard.xib, forCellWithReuseIdentifier: Cell.appCard.identifier)
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ArticleCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.articleCard.identifier,
                                                                             for: indexPath) as? ArticleCardCell else {
            fatalError("Unknow reusable cell!") // Should never happened
        }
        
        return cell
    }
}
