//
//  AppDelegate.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit
import SnapKit
import Flutter
import flutter_boost

@main
class AppDelegate: FlutterAppDelegate {

//    var window: UIWindow?

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //初始化
        if let flutterBoost = FlutterBoost.instance() {
            let router = PlatformRouter()
            flutterBoost.setup(application, delegate: router, callback: { (engine) in
                PrintLog.info("#######  flutterEngine  #########")
            })        
        }
       
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let vc = MainTabbarViewController()
        UIApplication.shared.delegate?.window??.rootViewController = vc
        RouterManager.share.initRouter(vc)
        window?.makeKeyAndVisible()
        
        
        return true
    }


}

