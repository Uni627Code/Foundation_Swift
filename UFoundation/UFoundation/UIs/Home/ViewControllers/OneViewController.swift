//
//  OneViewController.swift
//  UFoundation
//
//  Created by dong on 6.5.21.
//

import UIKit

class OneViewController: UIViewController, BindableType {
    
    var viewModel: HomeViewModel!
    
    var dataArray: [Product] = []
    
    
    @objc dynamic var name: String?
    
    var ob: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func bindViewModel() {
        self.name = "栗子"
        self.pp_addObserver(self, forKey: "name") { ob, keyname, old, new in
            
        }
        
//        self.ob = observe(\.self.name, options: [.old, .new], changeHandler: { _ , new in
//
//        })
        self.name = "栗子1"

//        viewModel.name = "栗子"
//        viewModel.addObserver(self, forKeyPath: "name", options: [.new, .old], context: nil)
//        viewModel.name = "栗子1"
        let request = AFPersonRequest()
        
        HttpManager.share.send(request) { array in
            if let model = array.list.first {
                print(model)
            }
            
        } failure: { error in
            
        }

    }

//    // 重写响应方法
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//       print(keyPath) // name
//      if let old = change?[NSKeyValueChangeKey.oldKey] {
//        print(old) //
//      }
//
//      if let new = change?[NSKeyValueChangeKey.newKey] {
//        print(new) // Albert
//      }
//    }
    
    deinit {
//        viewModel.removeObserver(self, forKeyPath: "name")
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
