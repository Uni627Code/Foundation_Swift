//
//  Color.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit
import SwiftyJSON
import SwiftyColor
struct Color {
    /// 主题紫（0x8474F4）
    static let themePurple = 0x8474F4.color
    /// 主题蓝（0x2080FE）
    static let themeBlue = 0x2080FE.color
    /// 主红（0xFC1616）
    static let themeRed = 0xFC1616.color
    /// 主背景色（0xFBFBFB）
    static let mainBackground = 0xFBFBFB.color
    /// 点缀色（蓝绿：0x59DDE2）
    static let beautifyGreen = 0x59DDE2.color
    /// 紫粉色（0xF4F3FA）
    static let pinkInPurple = 0xF4F3FA.color
    /// 提示色（橘黄：0xFFAA1E）
    static let tipOrange = 0xFFAA1E.color
    /// 警示色（红：0xFF688C）
    static let warningRed = 0xFF688C.color

    /// 默认黑色文字（标题栏、标题：0x333333）
    static let textBlack = 0x333333.color
    /// 默认深灰文字（二级标题、副标题：0x0C1331）
    static let textDeepGray = 0x999999.color
    /// 默认j浅灰文字（辅助提示：0xADADAD）
    static let textLightGray = 0xADADAD.color

    /// 半透明背景 (StatusBar\NavigationBar\BottomBar黑色半透明背景色)
    static let barBackground = UIColor(white: 0, alpha: 0.5)

    /// 控制器背景色
    static let viewBackground = 0xF7F7F7.color

    /// 分割线（灰：0xF6F6F6）
    static let separatedLine = 0xF6F6F6.color

    /// 占位文字颜色（0xC3C3C3）
    static let placeholder = 0xC3C3C3.color

    /// 浅紫色（0xF2F1FD）
    static let lightPurple = 0xF2F1FD.color

    /// VIP橘黄色
    static let userVIPNameColor =  0xF5A623.color
}

