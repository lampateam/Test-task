//
//  UIImageViewExtensions.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import UIKit
import SDWebImage

protocol ImageLoadable {
    func setImage(from url: URL, completion: ((UIImage) -> Void)?)
}

extension ImageLoadable where Self: UIImageView {
    func setImage(from url: URL, completion: ((UIImage) -> Void)? = nil) {
        self.sd_setImage(with: url, completed: nil)
    }
}

extension UIImageView: ImageLoadable {}
