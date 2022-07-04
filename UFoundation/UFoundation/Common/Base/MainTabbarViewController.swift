//
//  MainTabbarViewController.swift
//  Community_c
//
//  Created by uni on 2020/2/3.
//  Copyright © 2020 uni. All rights reserved.
//

import UIKit
import flutter_boost

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = CGMutablePath()
        path.addRect(self.tabBar.bounds)
        self.tabBar.layer.shadowPath = path
        path.closeSubpath()
        self.tabBar.layer.shadowColor = Color.mainBackground.cgColor
        self.tabBar.layer.shadowOffset = CGSize.init(width: 0, height: -5)
        self.tabBar.layer.shadowRadius = 5
        self.tabBar.layer.shadowOpacity = 0.8
        self.tabBar.clipsToBounds = true
        
//        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
       
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))

            appearance.backgroundImage = UIImage()
            self.tabBar.scrollEdgeAppearance = appearance;
        }

        
        setupUI()
    }
    
    func setupUI() {
                
//        setCustomtabbar()

        let vc1 = addChildVC(childVC: HomeViewController(), childTitle: "基础", imageName: "tabBar_Home", selectedImageName: "tabBar_Home_select")
        
        let vc2 = addChildVC(childVC: FlutterViewController(), childTitle: "Flutter", imageName: "tabBar_Home", selectedImageName: "tabBar_Home_select")

        let vc3 = addChildVC(childVC: VueViewController(), childTitle: "Vue", imageName: "tabBar_Home", selectedImageName: "tabBar_Home_select")

        let vc4 = addChildVC(childVC: OtherViewController(), childTitle: "其他", imageName: "tabBar_Home", selectedImageName: "tabBar_Home_select")
  
        viewControllers = [vc1,vc2,vc3,vc4]
        
                
        
        selectedIndex = 0
        
    }
    
    
    private func addChildVC(childVC: UIViewController, childTitle: String, imageName: String, selectedImageName:String) -> YYNavigationController {
        
        //创建导航控制器
        let nav = YYNavigationController(rootViewController: childVC)
        //        nav.title = childTitle
        //        nav.tabBarItem.image = UIImage(named: imageName)
        //        nav.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        
        //1.创建tabbarItem
        let barItem = UITabBarItem.init(title: childTitle, image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal))
        
        //2.更改字体颜色
        //        barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.blue], for: .normal)
        //        barItem.setTitleTextAttributes([NSAttributedString.Key.font:UIColor.orange], for: .selected)
        
        //设置根控制器
        childVC.tabBarItem = barItem
        
        childVC.tabBarItem.title = childTitle
        
        return nav
    }

    
    func setCustomtabbar() {
        let tabbar = ETabBar()
        self.setValue(tabbar, forKey: "tabBar")
        
        tabbar.centerBtn.addTarget(self, action: #selector(centerBtnClick), for: .touchUpInside)
    }
    
    @objc func centerBtnClick() {
        PrintLog.info("点击了中间")
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        selectedIndex = self.selectedIndex
    }


}



