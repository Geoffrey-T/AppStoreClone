//
//  HeaderView.swift
//  AppStoreClone
//
//  Created by geoffrey on 13/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

public struct HeaderInformations {
    let subject: String = "<Subject>"
    let title: String = "<Title>"
    let rightImage: UIImage? = nil
}

class HeaderView: UIView {

    struct Defaults {
        static let nibName = String(describing: HeaderView.self)
    }

    public var headerInformations: HeaderInformations? {
        didSet {
            subjectLabel.text = headerInformations?.subject
            titleLabel.text = headerInformations?.title

            guard let image = headerInformations?.rightImage else {
                rightImageView.isHidden = true
                return
            }
            
            rightImageView.image = image
            rightImageView.isHidden = false
        }
    }
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()


        guard let view = loadViewFromNib() else {
            return // TODO: Handle error
        }

        view.frame = self.bounds
        self.addSubview(view)
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: Defaults.nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
