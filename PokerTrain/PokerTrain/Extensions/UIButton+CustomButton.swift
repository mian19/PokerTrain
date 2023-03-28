//
//  UIButton+CustomButton.swift
//  SportImages
//
//  Created by Kyzu on 22.10.22.
//

import UIKit

extension UIButton {
    static func roundedButton(imageName: String, side: CGFloat) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = side / 2
        button.setImage(UIImage(named: imageName), for: .normal)
        return button
    }
    
    static func learnButton(imageName: String, title: String, numberLines: Int = 1, big: Bool = false) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: big ? 336 : 162, height: 68)
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        button.layer.shadowPath = UIBezierPath(roundedRect: button.bounds, cornerRadius: button.layer.cornerRadius).cgPath
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setTitle(title, for: .normal)
        button.titleLabel?.numberOfLines = numberLines
        button.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 17)
        let bgImage = UIImageView(image: UIImage(named: big ? "bigButton" : "smallButton")!)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        bgImage.frame = button.frame
        bgImage.contentMode = .scaleToFill
        button.insertSubview(bgImage, belowSubview: button.imageView!)
        return button
    }
    
    static func settingsButton(imageName: String, title: String ) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 336, height: 56)
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        button.layer.shadowPath = UIBezierPath(roundedRect: button.bounds, cornerRadius: button.layer.cornerRadius).cgPath
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setTitle(title, for: .normal)
       
        button.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 17)
        let bgImage = UIImageView(image: UIImage(named: "bigButton")!.resizeImageTo(size: CGSize(width: 336, height: 56)))
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        bgImage.frame = button.frame
        bgImage.contentMode = .scaleToFill
        button.insertSubview(bgImage, belowSubview: button.imageView!)
        button.titleEdgeInsets = UIEdgeInsets(top: 12, left: -100, bottom: 12, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: -130, bottom: 12, right: 0)
        return button
    }
}
