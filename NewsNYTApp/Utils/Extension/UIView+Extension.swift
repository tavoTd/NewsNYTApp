//
//  UIView+Extension.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 29/11/24.
//

import UIKit

extension UIView {
    
    public func roundCorners(corners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
        self.layer.masksToBounds = true
    }
}
