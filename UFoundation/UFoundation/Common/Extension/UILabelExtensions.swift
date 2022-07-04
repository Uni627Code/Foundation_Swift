//
//  UILabelExtensions.swift
//  EUI
//
//  Created by 1010788249@qq.com on 2019/11/8.
//

import Foundation

public extension UILabel {
    /// 生成更多富文本
    /// - Parameters:
    ///   - leftText: 左边内容
    ///   - leftFont: 左边字体
    ///   - leftColor: 左边颜色
    ///   - rightText: 右边内容
    ///   - rightFont: 右边字体
    ///   - rightColor: 右边颜色
    public func createMoreAttribute(leftText:String, leftFont:UIFont, leftColor:UIColor, rightText:String, rightFont:UIFont, rightColor:UIColor){
        let attribute = NSMutableAttributedString(string: "\(leftText)\(rightText)")
        let leftAttribute = [NSAttributedString.Key.foregroundColor:leftColor,NSAttributedString.Key.font:leftFont]
        let rightAttribute = [NSAttributedString.Key.foregroundColor:rightColor,NSAttributedString.Key.font:rightFont]
        attribute.addAttributes(leftAttribute, range: NSRange(location: 0, length: leftText.count))
        attribute.addAttributes(rightAttribute, range: NSRange(location: leftText.count, length: rightText.count))
        self.attributedText = attribute
    }
}
