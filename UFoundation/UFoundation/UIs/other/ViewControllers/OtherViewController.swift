//
//  OtherViewController.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit
import flutter_boost

class OtherViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .custom)
        button.setTitle("flutter跳转", for: .normal)
        button.setTitleColor(Color.beautifyGreen, for: .normal)
        button.addTarget(self, action: #selector(skip), for: .touchUpInside)
        view.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func skip() {
        FlutterBoost.instance()?.open("FirstRouteWidget", arguments: ["animated": true], completion: { (bool) in
            
        })
    }

}
