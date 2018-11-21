//
//  CardCollectionViewController.swift
//  AppStoreClone
//
//  Created by geoffrey thenot on 12/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

protocol CardCollectionDelegate: class {
    func cardSelected(cell: BaseCardCell)
}

class CardCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    struct Cell {
        static let margin: CGFloat = 20.0
        static let height: CGFloat = 400.0

        static var totalMargin: CGFloat {
            return margin * 2
        }

        struct header {
            static let identifier = "HeaderCell"
            static let xib = String(describing: HeaderCell.self)
            static let height: CGFloat = 80.0
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

    public var cards: [ContentCardModel]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    public weak var delegate: CardCollectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    private func registerCells() {
        collectionView?.register(nibName: Cell.articleCard.xib, forCellWithReuseIdentifier: Cell.articleCard.identifier)
        collectionView?.register(nibName: Cell.appCard.xib, forCellWithReuseIdentifier: Cell.appCard.identifier)

        collectionView?.register(UINib(nibName: Cell.header.xib, bundle: nil),
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: Cell.header.identifier)
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: AppCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.appCard.identifier,
                                                                             for: indexPath) as? AppCardCell else {
            fatalError("Unknow reusable cell!") // Should never happened
        }

        if let cardModel = cards?[indexPath.row] {
            cell.containerView.contentCardModel = cardModel
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
        if let cell = collectionView.cellForItem(at: indexPath) as? BaseCardCell {
            delegate?.cardSelected(cell: cell)
        }
    }

    // Mark: - Header

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: Cell.header.identifier,
                                                                             for: indexPath)
            // TODO: Setup header
            return headerView

        default: break
        }

        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Cell.header.height)
    }
}
