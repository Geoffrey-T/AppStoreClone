//
//  CardDetailViewController.swift
//  AppStoreClone
//
//  Created by geoffrey on 13/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentCardView: ContentCardView!
    @IBOutlet weak var textView: UITextView!

    @IBOutlet weak var bottomAreaConstraint: NSLayoutConstraint!
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
