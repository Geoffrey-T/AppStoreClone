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
    func cardSelected(frame: CGRect) {
        performSegue(withIdentifier: Segues.presentCard, sender: self)
    }
}
