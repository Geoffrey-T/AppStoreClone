//
//  ContentCardView.swift
//  AppStoreClone
//
//  Created by geoffrey on 14/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

struct ContentCardModel {
    let subject: String
    let title: String
    let backgroundImage: String
    let description: String
}

class ContentCardView: UIView {

    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    public var contentCardModel: ContentCardModel? {
        didSet {
            subjectLabel.text = contentCardModel?.subject
            titleLabel.text = contentCardModel?.title
            backgroundImage.downloaded(from: contentCardModel?.backgroundImage)
            descriptionLabel.text = contentCardModel?.description
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ContentCardView", bundle: bundle)
        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }

        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.edges(to: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        layer.cornerRadius = 20
    }
}
