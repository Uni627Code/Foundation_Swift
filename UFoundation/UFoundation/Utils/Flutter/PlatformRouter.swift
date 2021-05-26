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
        self.navigationController().pushViewController(targetViewController, animated: animated)
    }

    func open(_ url: String,
              urlParams: [AnyHashable : Any],
              exts: [AnyHashable : Any],
              completion: @escaping (Bool) -> Void) {
        var animated = false
        if exts["animated"] != nil {
            animated = exts["animated"] as! Bool
        }

        guard url.hasPrefix("flutterbus://") else {
            //处理 nativebus: 页面
            openNative(url, urlParams: urlParams, exts: exts, animated: animated, completion: completion)
            return
        }

        if let vc = FBFlutterViewContainer() {
            vc.setName(url, uniqueId: "1", params: urlParams)
            navigationController().pushViewController(vc, animated: animated)
        }
        completion(true)
    }

    func present(_ url: String, urlParams: [AnyHashable : Any], exts: [AnyHashable : Any],
                 completion: @escaping (Bool) -> Void) {
 
        if let vc = FBFlutterViewContainer() {
            var animated = false
            if exts["animated"] != nil {
                animated = exts["animated"] as! Bool
            }
            vc.setName(url, uniqueId: "", params: urlParams)
            navigationController().present(vc, animated: animated) {
                completion(true)
            }
        }
    }

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
        if let vc = FBFlutterViewContainer() {
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
        
    }
    
    
}
