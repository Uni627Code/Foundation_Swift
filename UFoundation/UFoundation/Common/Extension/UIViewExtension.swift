//
//  UIViewExtension.swift
//  UFoundation
//
//  Created by dong on 26.5.21.
//

import UIKit

extension UIView {
    
//    // MARK: - 查找顶层控制器、
//    // 获取顶层控制器 根据window
//    func topViewController() -> (UIViewController?) {
//
//        var window = UIApplication.shared.keyWindow
//        //是否为当前显示的window
//        if window?.windowLevel != UIWindow.Level.normal{
//
//            let windows = UIApplication.shared.windows
//            for windowTemp in windows{
//                if windowTemp.windowLevel == UIWindow.Level.normal{
//                    window = windowTemp
//                    break
//                }
//            }
//        }
//        let viewController = window?.rootViewController
//        return traverseViewController(withCurrentVC: viewController)
//    }
//    ///根据控制器获取 顶层控制器
//    func traverseViewController(withCurrentVC ViewController :UIViewController?) -> UIViewController? {
//
//        if ViewController == nil {
//            print("🌶： 找不到顶层控制器")
//            return nil
//        }
//
//        if let presentVC = ViewController?.presentedViewController {
//            //modal出来的 控制器
//            return traverseViewController(withCurrentVC: presentVC)
//
//        }else if let tabViewController = ViewController as? UITabBarController {
//            // tabBar 的跟控制器
//            if let selectViewController = tabViewController.selectedViewController {
//
//                return traverseViewController(withCurrentVC: selectViewController)
//            }
//            return nil
//        } else if let naiViewController = ViewController as? UINavigationController {
//            // 控制器是 nav
//            return traverseViewController(withCurrentVC:naiViewController.visibleViewController)
//        } else {
//            // 返回顶控制器
//            return ViewController
//        }
//    }
}

extension NSObject {
    // MARK: - 查找顶层控制器、
    // 获取顶层控制器 根据window
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
    ///根据控制器获取 顶层控制器
    func traverseViewController(withCurrentVC ViewController :UIViewController?) -> UIViewController? {

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
