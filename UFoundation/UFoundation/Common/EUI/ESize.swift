//
//  ESize.swift
//  EUI
//
//  Created by LynnCheng on 2019/10/8.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import UIKit

///定义视觉尺寸相关的常量
public struct ESize {
    
    ///处于视图上方的TabBar的默认高度
    public static let topTabBarHeight:CGFloat = 40
    
    ///内容块之间的最小间距
    public static let minContentSpace:CGFloat = 5.5
    
    ///内容结束的最小间距
    public static let minContentBlank:CGFloat = 8
    
    ///屏幕左右与内容的间距
    public static let marginSize:CGFloat = 15
    
    ///常规内容块的高度
    public static let rowHeight:CGFloat = 50
    
    ///小标题栏的高度
    public static let titleHeight:CGFloat = 32
    
    /// 常规按钮高度
    public static let buttonHeight:CGFloat = 44
    
}


public let screenWidth = UIScreen.main.bounds.width
public let screenHeight = UIScreen.main.bounds.height


/// 导航栏高度
public let navigationHeight:CGFloat = navBarHeight()

/// 状态栏高度
public let statusbarHeitht : CGFloat = isNoun() ? 44 : 20

/// 底部菜单栏高度
public let tabBarHeight : CGFloat = isNoun() ? 49 + 34 : 49

/// 底部安全区高度
public let bottomAndSafeHeight:CGFloat = isNoun() ? 34 : 0


/// 圆角大小
public enum CornerRadius: Int {
    case large = 10
    case little = 5
}

/// 是否是刘海屏
public func isNoun() -> Bool {
    if #available(iOS 11, *) {
        guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
            return false
        }
        if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
            return true
        }
    }
    return false
}

func navBarHeight() -> CGFloat {
    return isNoun() ? 88 : 64
}
