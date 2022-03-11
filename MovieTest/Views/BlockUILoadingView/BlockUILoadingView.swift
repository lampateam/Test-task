//
//  BlockUILoadingView.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import UIKit

class BlockUILoadingView: UIView {
    @IBOutlet private var backgroundContainerView: UIView!
    @IBOutlet private var kdView: UIView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    private let duration: Double = 0.25
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        showBackGround()
        setupView()
    }
    
    class func fromNib() -> BlockUILoadingView {
        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BlockUILoadingView
    }
    
    private func setupView() {
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        activityIndicator.transform = transform
        activityIndicator.color = .darkGray
    }
    
    private func showBackGround() {
        UIView.animate(withDuration: duration, animations: {
            self.backgroundContainerView.alpha = 0.40
        })
    }
    
    func dismissView() {
        UIView.animate(withDuration: duration, animations: {
            self.backgroundContainerView.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}
