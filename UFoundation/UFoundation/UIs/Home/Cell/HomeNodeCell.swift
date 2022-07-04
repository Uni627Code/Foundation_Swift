//
//  HomeNodeCell.swift
//  UFoundation
//  https://bawn.github.io/2017/12/Texture-Layout/
//  Created by 陆小懒 on 2022/3/30.
//  Copyright © 2022 Uni. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import RxSwift
import RxCocoa

class HomeNodeCell: ASCellNode {

    lazy var backView: ASDisplayNode = {
        let node = ASDisplayNode()
        
        return node
    }()
    
    
    lazy var coverImageNode: ASNetworkImageNode = {// 大图
        let node = ASNetworkImageNode()
//        node.image = UIImage(named: "Banner")
//        node.contentMode = .scaleAspectFill
        return node
    }()
    
    
    lazy var titleNode: ASTextNode = {//标题
        let node = ASTextNode()
        return node
    }()
   
    lazy var subTitleNode: ASTextNode = {// 副标题
        let node = ASTextNode()
        return node
    }()
    
    lazy var dateTextNode: ASTextNode = {// 发布时间
        let node = ASTextNode()
        let text = NSAttributedString(string: "昨天")
        node.attributedText = text
        return node
    }()
    
    lazy var shareImageNode: ASImageNode = {// 分享图标
        let node = ASImageNode()
        node.image = UIImage(named: "")
        return node
    }()
    
    lazy var shareNumberNode: ASTextNode = {// 分享数量
        let node = ASTextNode()
        let text = NSAttributedString(string: "11")
        node.attributedText = text
        return node
    }()
    
    lazy var likeImageNode: ASImageNode = {// 喜欢图标
        let node = ASImageNode()
        node.image = UIImage(named: "")
        return node
    }()
    
    lazy var likeNumberNode: ASTextNode = {// 喜欢数量
        let node = ASTextNode()
        let text = NSAttributedString(string: "22")
        node.attributedText = text
        return node
    }()
    
    init(_ model: Category) {
        super.init()
                
        addSubnode(coverImageNode)
        addSubnode(titleNode)
        addSubnode(subTitleNode)
        
        addSubnode(dateTextNode)

        addSubnode(likeImageNode)
        addSubnode(likeNumberNode)

        addSubnode(shareImageNode)
        addSubnode(shareNumberNode)
        
        selectionStyle = .none
        
        if let url = URL(string: model.imageURL) {
            coverImageNode.url = url
        }
        
        let title = NSAttributedString(string: model.title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        titleNode.attributedText = title
        
        let subtitle = NSAttributedString(string: "\(model.numberOfProducts) products", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        subTitleNode.attributedText = subtitle

    }
    /// 返回定义单元格布局的布局规范。
    /// - Parameter constrainedSize: constrainedSize description
    /// - Returns: description
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        self.shareImageNode.style.preferredSize = CGSize(width: 15, height: 15);
        self.likeImageNode.style.preferredSize = CGSize(width: 15, height: 15);

        //1.根据布局的原则，首先利用 ASStackLayoutSpec 布局 分享图标 和 分享数量、 喜欢图标 和 喜欢数量。
        let likeLayout = ASStackLayoutSpec()
        likeLayout.direction = .horizontal
        likeLayout.spacing = 4
        likeLayout.justifyContent = .start
        likeLayout.alignItems = .center
        likeLayout.children = [likeImageNode, likeNumberNode]
        
        let shareLayout = ASStackLayoutSpec()
        shareLayout.direction = .horizontal
        shareLayout.spacing = 4
        shareLayout.justifyContent = .start
        shareLayout.alignItems = .center
        shareLayout.children = [shareImageNode, shareNumberNode]
        
        
        let otherLayout = ASStackLayoutSpec()
        otherLayout.direction = .horizontal
        otherLayout.spacing = 10
        otherLayout.justifyContent = .start
        otherLayout.alignItems = .center
        otherLayout.children = [likeLayout, shareLayout]
        
        let bottomLayout = ASStackLayoutSpec()
        bottomLayout.direction = .horizontal
        bottomLayout.justifyContent = .spaceBetween
        bottomLayout.alignItems =  .center
        bottomLayout.children = [dateTextNode, otherLayout]
        
        self.titleNode.style.spacingBefore = 12
        
        self.subTitleNode.style.spacingBefore = 12
        self.subTitleNode.style.spacingAfter = 20
        
        let rationLayout = ASRatioLayoutSpec(ratio: 5 , child: coverImageNode)
        rationLayout.style.preferredSize = CGSize(width: self.frame.size.width, height: 150)
        
        let contentLayout = ASStackLayoutSpec()
        contentLayout.direction = .vertical
        contentLayout.justifyContent = .start
        contentLayout.alignItems = .stretch
        contentLayout.children = [rationLayout, titleNode, subTitleNode, bottomLayout]
        
        let insetLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: contentLayout)
        
        return insetLayout
                
    }
    
    ///  在主线程上调用。添加手势识别器等的好地方。
    override func didLoad() {
        super.didLoad()
    }
    
    /// 也在主线程上调用。在调用 super 之后布局就完成了，这意味着你可以做任何你需要做的额外调整。
    override func layout() {
        super.layout()
    }
}


extension HomeNodeCell {
    
    
}
