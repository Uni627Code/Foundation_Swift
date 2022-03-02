//
//  PlatformRouter.swift
//  Community
//
//  Created by uni on 2021/1/6.
//  Copyright © 2021 EinYun. All rights reserved.
//  参考：https://www.jianshu.com/p/370aee5b7b25

import Foundation
import flutter_boost
import FlutterPluginRegistrant
import Flutter

class PlatformRouter: NSObject {
    
    
    ///用来存返回flutter侧返回结果的表
    var resultTable:Dictionary<String,([AnyHashable:Any]?)->Void> = [:];
    
    func openNative(_ url: String,
                    urlParams: [AnyHashable : Any],
                    exts: [AnyHashable : Any],
                    animated: Bool,
                    completion: @escaping (Bool) -> Void) {
        
        let prefix = "nativebus://"
        guard url.hasPrefix(prefix) else {
            completion(false)
            return
        }
        
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let viewControllerName = String(url.dropFirst(prefix.count))
        guard let cls: AnyClass = NSClassFromString(namespace + "." + viewControllerName),
              let clsType = cls as? UIViewController.Type else {
            completion(false)
            return
        }
        let targetViewController = clsType.init()
        targetViewController.urlParams = urlParams
        //可以用参数来控制是push还是pop
        let isPresent = exts["isPresent"] as? Bool ?? false
        let isAnimated = exts["isAnimated"] as? Bool ?? true
        if(isPresent){
            navigationController().present(targetViewController, animated: isAnimated, completion: nil)
        }else{
            navigationController().pushViewController(targetViewController, animated: isAnimated)
        }
    }
    
    /// 打开flutter
    /// - Parameters:
    ///   - url: flutter 对应页面
    ///   - urlParams: 参数
    ///   - exts: 跳转类型等其他不需要传的参数
    ///   - completion: completion description
    func open(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        var animated = false
        if exts["animated"] != nil {
            animated = exts["animated"] as! Bool
        }
                
        if let vc = GAFlutterRooterViewController() {
            vc.setName(url, uniqueId: "333", params: urlParams)
            navigationController().pushViewController(vc, animated: animated)
        }
        completion(true)
    }
    
    
    /// present 跳转
    /// - Parameters:
    ///   - url: flutter name
    ///   - urlParams: 传入flutter的参数
    ///   - exts: 跳转类型
    ///   - completion: completion description
    func present(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any], completion: @escaping (Bool) -> Void) {
        
        if let vc = FBFlutterViewContainer() {
            var animated = false
            if exts["animated"] != nil {
                animated = exts["animated"] as! Bool
            }
            vc.setName(url, uniqueId: "222", params: urlParams)
            navigationController().present(vc, animated: animated) {
                completion(true)
            }
        }
    }
    
    
    /// 关闭flutter 页面
    /// - Parameters:
    ///   - uid: uid description
    ///   - result: result description
    ///   - exts: exts description
    ///   - completion: completion description
    func close(_ uid: String, result: [AnyHashable : Any], exts: [AnyHashable : Any],
               completion: @escaping (Bool) -> Void) {
        var animated = false
        if exts["animated"] != nil {
            animated = exts["animated"] as! Bool
        }
        let presentedVC = navigationController().presentedViewController
        let vc = presentedVC as? FBFlutterViewContainer
        if vc?.uniqueIDString() == uid {
            vc?.dismiss(animated: animated, completion: {
                completion(true)
            })
        } else {
            navigationController().popViewController(animated: animated)
        }
    }
    
    func navigationController() -> UINavigationController {
        
        guard let navigationController = topViewController()?.navigationController else {
            return UINavigationController()
        }
        return navigationController
    }
    
}


extension PlatformRouter: FlutterBoostDelegate {
    
    func pushNativeRoute(_ pageName: String!, arguments: [AnyHashable : Any]!) {
        
        
    }
    
    func pushFlutterRoute(_ pageName: String!, uniqueId: String!, arguments: [AnyHashable : Any]!, completion: ((Bool) -> Void)!) {
        
        let engine = FlutterBoost.instance()?.engine()
        engine?.viewController = nil
        
        if let vc = GAFlutterRooterViewController() {
            vc.setName(pageName, uniqueId: uniqueId, params: arguments)
            
            let animated = arguments["animated"] as? Bool ?? true
            let present = arguments["present"] as? Bool ?? false
            
            if present {
                navigationController().present(vc, animated: animated, completion: nil)
            } else {
                navigationController().pushViewController(vc, animated: true)
            }
        }
    }
    
    func popRoute(_ uniqueId: String!) {
        if uniqueId == "333" {
            self.navigationController().popViewController(animated: true)
        } else {
            self.navigationController().popViewController(animated: true)
        }
        
    }
    
    
}
