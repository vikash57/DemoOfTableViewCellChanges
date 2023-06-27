//
//  CommonUsedMethod.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 14/06/23.
//

import Foundation
import UIKit

class Common : NSObject{
    
    static var delegate = Common()
    
    func applyShadowOnView(_ view: UIView) {
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.systemBlue.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
    }
    
    func applyRadiusButton(_ btn:UIButton, _ radius: CGFloat,_ bWidth: CGFloat,_ color:UIColor) {
        btn.layer.cornerRadius = radius
        btn.layer.borderWidth = bWidth
        btn.layer.borderColor = color.cgColor
        btn.layer.masksToBounds = true
    }
    
    
    func alert(view: UIViewController, title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            })
            alert.addAction(defaultAction)
            DispatchQueue.main.async(execute: {
                view.present(alert, animated: true)
            })
        }

    
}
