//
//  HomeViewController.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit

class HomeViewController: BaseViewController, BindableType {
        
    var viewModel: HomeViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = HomeViewModel()
        // Do any additional setup after loading the view.

        let button = UIButton(type: .custom)
        button.setTitle("跳转", for: .normal)
        button.setTitleColor(Color.beautifyGreen, for: .normal)
        button.addTarget(self, action: #selector(skip), for: .touchUpInside)
        view.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
    @objc func skip() {
        var params = RouterParam()
        params["id"] = "id"
        params["name"] = "name"
        Router.sharedInstance.open("OneViewController", params: params)
    }
    
    

    func bindViewModel() {
        
    }

}


