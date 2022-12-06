//
//  UIButton + Ext.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 06.12.2022.
//

import UIKit

extension UIButton{

    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }

}
