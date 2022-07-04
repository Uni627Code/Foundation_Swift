//
//  YYNavigationController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/19.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import AttributedString

public class YYNavigationController: UINavigationController{
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.interactivePopGestureRecognizer?.delaysTouchesBegan = true
        self.interactivePopGestureRecognizer?.delegate = self
        self.interactivePopGestureRecognizer?.isEnabled = true
        
        let attribute = [NSAttributedString.Key.foregroundColor :UIColor.black,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18)]
        
        if #available(iOS 15.0, *) {
            let apperance = UINavigationBarAppearance()
            apperance.backgroundColor = .white;//设置背景色
            
            //设置标题字体
            apperance.titleTextAttributes = attribute
            
            apperance.shadowImage = UIImage()
            apperance.shadowColor=nil;//分割线去除
            
            UINavigationBar.appearance().standardAppearance = apperance;
            UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance
        } else {
            self.navigationBar.shadowImage = UIImage.init()
            
            self.navigationBar.barStyle = UIBarStyle.default
            self.navigationBar.barTintColor = .white
            self.navigationBar.isTranslucent = true
            
            self.navigationBar.titleTextAttributes = attribute
            
        }
        
       
    }
}


extension YYNavigationController
{
    public override func pushViewController(_ viewController: UIViewController, animated: Bool)
    {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            let backBtn = UIButton(type: .custom)
            backBtn.frame = CGRect(x: 0, y: 0, width: 70, height: 32)
            
            //返回按钮的图片-状态
            backBtn.setImage(UIImage(named: "navi_back"), for: .normal)
            
            //添加事件
            backBtn.addTarget(self, action: #selector(leftClick), for: .touchUpInside)
            
            backBtn.contentHorizontalAlignment = .left
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    //返回上一层控制器
    @objc func leftClick()  {
        
        popViewController(animated: true)
        
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return self.visibleViewController?.preferredStatusBarStyle ?? .lightContent
    }
}



extension YYNavigationController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count <= 1 {
            return false
        }
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension YYNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}



