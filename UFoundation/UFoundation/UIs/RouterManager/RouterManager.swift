//
//  RouterManager.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit

class RouterManager: NSObject, UITabBarControllerDelegate {

    static let share = RouterManager()

    func initRouter(_ tabBarController: MainTabbarViewController)  {

        tabBarController.delegate = self

        guard let navs = tabBarController.viewControllers, let nav = navs[0] as? UINavigationController else {
            return
        }

        let router = Router.sharedInstance
        router.navigationController = nav
        router.map(OneViewController.routableKey, className: OneViewController.description())

//        configureVC()
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let nav = viewController as? YYNavigationController {
            Router.sharedInstance.navigationController = nav
        }
    }
    
    //注册
    func configureVC() {
        let router = Router.sharedInstance
        router.map(OneViewController.routableKey, className: OneViewController.description())
//        router.map(RouterViewController.routableKey, className: RouterViewController.description())
//        router.map(DynamicViewController.routableKey, className: DynamicViewController.description())
    }
}
