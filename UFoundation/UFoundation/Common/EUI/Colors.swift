//
//  Colors.swift
//  EUI
//
//  Created by LynnCheng on 2019/9/26.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import UIKit

//TODO: 根据UI规范修改颜色值
public struct Colors {
    
    /// 重要级文字，内容标题以及部分icon(导航名称，列表标题)
    public static var primary = UIColor(rgb: 0x132D42)
    
    /// 用于2px细分割线
    public static var line = UIColor(rgb: 0xF5F5F5)
    
    ///字体颜色
    public struct text {
        ///普通文字，箭头图标颜色
        public static var body = UIColor(rgb: 0x9DA3B4)
        
        ///特别需要和特别强调，按钮和icon
        public static var keynote = UIColor(rgb: 0x185CC7)
        
        ///主要辅助颜色，起到高亮作用，增加页面活力（如备注型文字，辅助型文字）
        public static var comment = UIColor(rgb: 0xFCBC0C)
        
        /// 用于背景颜色是#F8F9FB色值时，灰色文字颜色
        public static var auxiliary = UIColor(rgb: 0x8D9ABF)
        
        /// 用于较弱文字信息
        public static var weak = UIColor(rgb: 0xD8D8D8)
        
        ///不可用状态下的文字颜色
        public static var disabled = UIColor(rgb: 0xcccccc)
        
        ///警告性
        public static var alarm = UIColor.red
        
    }
    
    ///背景色
    public struct background {
        ///正文背景色
        public static var content = UIColor.white
        
        ///视图默认背景色
        public static var view = UIColor(rgb: 0xeeeeee)
        
        ///警示性按钮、提示框的背景色
        public static var alarm = UIColor.red.withAlphaComponent(0.1)
        
        ///禁止点击状态下的背景色
        public static var disabled = UIColor(rgb: 0xFFFFFF, alpha: 0.5)
        
        /// 点击状态下背景色
        public static var highlighted = UIColor(rgb: 0x000000, alpha: 0.14)
        
        /// 用于20px的分割线以及部分页面主体背景
        public static var separator = UIColor(rgb: 0xF8F9FB)
        
        public static var shadow = UIColor(rgb: 0x185CC7, alpha: 1)
    }
    
    public struct button {
        
        public static var right = UIColor(rgb: 0x185CC7)
        
        public static var left = UIColor(rgb: 0x5C9BFF)

    }
}


public func kRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

