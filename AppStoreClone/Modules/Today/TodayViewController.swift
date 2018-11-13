//
//  TodayViewController.swift
//  AppStoreClone
//
//  Created by geoffrey thenot on 12/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
    struct Segues {
        static let presentCard = "presentCard"
        static let embeddedCardCollection = "CardCollection"
    }

    private var transition: Transition?

    var cardCollectionViewController: CardCollectionViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.embeddedCardCollection {
            cardCollectionViewController = segue.destination as? CardCollectionViewController
            cardCollectionViewController?.delegate = self
        }
    }
}

extension TodayViewController: CardCollectionDelegate {
    func cardSelected(cell: BaseCardCell) {
        cell.freezeAnimations()

        let currentCellFrame = cell.layer.presentation()!.frame

        let cardPresentationFrameOnScreen = cell.superview!.convert(currentCellFrame, to: nil)

        let cardFrameWithoutTransform = { () -> CGRect in
            let center = cell.center
            let size = cell.bounds.size
            let r = CGRect(
                x: center.x - size.width / 2,
                y: center.y - size.height / 2,
                width: size.width,
                height: size.height
            )
            return cell.superview!.convert(r, to: nil)
        }()

        //let cardModel = cardModels[indexPath.row]

        let detailVc = storyboard!.instantiateViewController(withIdentifier: "cardDetailVc") as! CardDetailViewController

        let params = Transition.Params(fromCardFrame: cardPresentationFrameOnScreen,
                                       fromCardFrameWithoutTransform: cardFrameWithoutTransform,
                                       fromCell: cell)
        transition = Transition(params: params)
        detailVc.transitioningDelegate = transition

        detailVc.modalPresentationCapturesStatusBarAppearance = true
        detailVc.modalPresentationStyle = .custom

        present(detailVc, animated: true, completion: { [unowned cell] in
            cell.unfreezeAnimations()
        })
    }
}
