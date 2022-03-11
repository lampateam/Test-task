//
//  UIViewControllerExtensions.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import UIKit

extension UIViewController {
    func pushToVC(_ vc: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    func showAlert(with error: Error?, message: String?, title: String, actionTitle: String? = "OK") {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let message = error?.localizedDescription ?? message
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: actionTitle, style: .default))
            self.present(ac, animated: true)
        }
    }
    
    static var fromStoryboard: Self {
        let selfName = NSStringFromClass(self).components(separatedBy: ".").last!
        let storyboard = UIStoryboard(name: selfName, bundle: nil)
        let customViewController = storyboard.instantiateViewController(withIdentifier: selfName) as! Self
        
        return customViewController
    }
    
    func blockScreenViewStart(flag: Bool) {
        DispatchQueue.main.async {
            let tag = 121212
            
            guard let currentWindow = UIApplication.shared.keyWindow else { return }
            
            for v in currentWindow.subviews {
                if v.tag == tag {
                    if let blv: BlockUILoadingView = v as? BlockUILoadingView {
                        v.removeFromSuperview()
                        blv.dismissView()
                    }
                    
                    break
                }
            }
            
            if !flag { return }
            
            let blview = BlockUILoadingView.fromNib()
            blview.frame = UIScreen.main.bounds
            blview.tag = tag
            currentWindow.addSubview(blview)
        }
    }
}
