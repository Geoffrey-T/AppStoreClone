//
//  UIImage+extension.swift
//  AppStoreClone
//
//  Created by geoffrey on 19/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) else {
                    return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }

    func downloaded(from link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let link = link, let url = URL(string: link) else {
            return
        }
        downloaded(from: url, contentMode: mode)
    }
}
