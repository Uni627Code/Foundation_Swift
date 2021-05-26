//
//  ETabBar.swift
//  Community_c
//
//  Created by uni on 2020/2/4.
//  Copyright © 2020 uni. All rights reserved.
//

import UIKit
public class ETabBar: UITabBar {
    
    public lazy var centerBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
//        button.setImage(loadImage("tabBar_manager"), for: .normal)
        return button
    }()

    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "客服管家"
//        label.font = Fonts.caption1
//        label.textColor = EColors.text.lightGray
        return label
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(centerBtn)
        addSubview(label)
        
        // 去除顶部横线
//        self.backgroundImage = UIImage.imageWithColor(.white)
//        self.shadowImage = UIImage.imageWithColor(.white)
        
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
                
        var index:CGFloat = 0
        let width = bounds.size.width / 3
        
        centerBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(0)
            make.width.equalTo(55)
            make.height.equalTo(55)
        }
        label.sizeToFit()
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(centerBtn.snp.bottom).offset(5)
        }
        
        
        for sub in subviews {
            if let classname =  NSClassFromString("UITabBarButton") {
                if sub.isKind(of: classname) {
                    let frame = sub.frame
                    
                    sub.frame = CGRect(x: index * width, y: bounds.origin.y, width: width, height: frame.size.height)
                    index += 1
                    
                    if index == 1 {
                        index += 1
                    }
                }
            }
        }
        
    }
    
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isHidden == false {
            let newPoint = self.convert(point, to: centerBtn)
            
            if centerBtn.point(inside: newPoint, with: event) {
                return centerBtn
            } else {
                return super.hitTest(point, with: event)
            }
        } else {
            return super.hitTest(point, with: event)
        }
    }
    
}
