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
        //button.contentVerticalAlignment = .fill
        //button.contentHorizontalAlignment = .fill
        //button.imageView?.scalesLargeContentImage = true
        //button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
       // button.tintColor = .white
        return button
    }
}
