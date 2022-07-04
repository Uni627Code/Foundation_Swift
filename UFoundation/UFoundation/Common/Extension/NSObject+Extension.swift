//
//  NSObject+Extension.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit


public extension NSObject {
    
    /// 返回类名
    var className: String {
        get {
            let name =  type(of: self).description()
            if name.contains("."){
                return name.components(separatedBy: ".")[1];
            } else {
                return name;
            }
        }
    }
    
    /// 查找顶层控制器、
    /// - Returns: 当前显示页面控制器
    func topViewController() -> (UIViewController?) {
        
        var window = UIApplication.shared.keyWindow
        //是否为当前显示的window
        if window?.windowLevel != UIWindow.Level.normal{
            
            let windows = UIApplication.shared.windows
            for windowTemp in windows{
                if windowTemp.windowLevel == UIWindow.Level.normal{
                    window = windowTemp
                    break
                }
            }
        }
        let viewController = window?.rootViewController
        return traverseViewController(withCurrentVC: viewController)
    }
    
}



extension NSObject {
    
    ///根据控制器获取 顶层控制器
    private func traverseViewController(withCurrentVC ViewController :UIViewController?) -> UIViewController? {

        if ViewController == nil {
            print("🌶： 找不到顶层控制器")
            return nil
        }
        
        if let presentVC = ViewController?.presentedViewController {
            //modal出来的 控制器
            return traverseViewController(withCurrentVC: presentVC)
            
        }else if let tabViewController = ViewController as? UITabBarController {
            // tabBar 的跟控制器
            if let selectViewController = tabViewController.selectedViewController {

                return traverseViewController(withCurrentVC: selectViewController)
            }
            return nil
        } else if let naiViewController = ViewController as? UINavigationController {
            // 控制器是 nav
            return traverseViewController(withCurrentVC:naiViewController.visibleViewController)
        } else {
            // 返回顶控制器
            return ViewController
        }
    }
}
