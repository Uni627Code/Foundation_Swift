//
//  OneViewController.swift
//  UFoundation
//
//  Created by dong on 6.5.21.
//

import UIKit

class OneViewController: UIViewController, BindableType {
    
    var viewModel: HomeViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func bindViewModel() {
        
    }

}


extension OneViewController: Routable {
    
    /// 获取路由的参数返回且赋值
    /// - Parameter params: 参数
    /// - Returns: 返回控制器
    static func initWithParams(_ params: RouterParam?) -> UIViewController? {
        var vc = OneViewController()
        vc.bind(to: HomeViewModel())
        return vc
    }
    
    static var routableKey: String {
        return "OneViewController"
    }
    
    
    
}
