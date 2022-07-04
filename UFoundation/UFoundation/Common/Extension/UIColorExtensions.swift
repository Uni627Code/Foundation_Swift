//
//  UIColorExtensions.swift
//  EUI
//
//  Created by LynnCheng on 2019/9/27.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red:   CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat((rgb & 0x0000FF) >> 0)  / 255.0,
            alpha: alpha)
    }
}

