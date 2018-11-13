//
//  CardCollectionViewController.swift
//  AppStoreClone
//
//  Created by geoffrey thenot on 12/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

class CardCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    struct Cell {
        static let margin: CGFloat = 20.0
        static let height: CGFloat = 400.0

        static var totalMargin: CGFloat {
            return margin * 2
        }

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
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellWidth(index: indexPath.item)
    }
    
    private func cellWidth(index: Int) -> CGSize {
        guard UIDevice.current.userInterfaceIdiom != .phone else {
            return CGSize(width: collectionView.bounds.width - Cell.totalMargin, height: Cell.height)
        }
        
        let rowIsPair = ((index / 2) % 2) > 0
        let isFirst = (index+1) % 2 > 0
        
        let width = (!rowIsPair && isFirst) || (rowIsPair && !isFirst) ? cardCellWidth() : condensedCardCellWidth()

        return CGSize(width: width, height: Cell.height)
    }
    
    private func cardCellWidth() -> CGFloat {
        return ((collectionView.bounds.width / 3) * 2) - Cell.totalMargin
    }
    
    private func condensedCardCellWidth() -> CGFloat {
        return collectionView.bounds.width / 3  - Cell.totalMargin
    }


    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TO DO: HANDLE Touch to present detail
    }
}
