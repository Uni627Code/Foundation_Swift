//
//  Font.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit

enum Font: String {
    /// 使用系统默认字体
    case system

    /// 方正兰亭细黑_GBK （项目中一般用的这个）
    case fz         = "FZLanTingHei-L-GBK"

    /// 方正兰亭准黑_GBK
    case fzBold     = "FZLanTingHei-M-GBK"


    func size(_ size: CGFloat) -> UIFont {
        if case .system = self {
            return UIFont.systemFont(ofSize: size)
        } else {
            return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }

    init(_ font: UIFont){
        switch font.familyName {
        case Font.fz.rawValue:
            self = .fz
        case Font.fzBold.rawValue:
            self = .fzBold
        default: self = .system
        }
    }

}
