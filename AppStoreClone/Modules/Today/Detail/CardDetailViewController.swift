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

    public var contentCardModel: ContentCardModel?

    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
        contentCardView.contentCardModel = contentCardModel
    }
}
