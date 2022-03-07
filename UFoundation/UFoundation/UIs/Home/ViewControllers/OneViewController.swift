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
           
        let request = AFPersonRequest()
        
        AlamofireManager.share.send(request) { array in
            if let model = array.list.first {
                print(model)
            }
            
        } failure: { error in
            
            
        }

    }

   
}





extension OneViewController: Routable {
    
    /// 获取路由的参数返回且赋值
    /// - Parameter params: 参数
    /// - Returns: 返回控制器
    static func initWithParams(_ params: RouterParam?) -> UIViewController? {
        let model = HomeViewModel()
        if let params = params {
            if let id = params["id"] as? String, let name = params["name"] as? String {
                model.id = id
                model.name = name
            }
        }
        var vc = OneViewController()
        vc.bind(to: model)
        return vc
        
    }
    
    static var routableKey: String {
        return "OneViewController"
    }
    
    
    
}
