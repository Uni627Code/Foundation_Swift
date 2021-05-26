//
//  FlutterViewController.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit
import Flutter
import flutter_boost

class FlutterViewController: FBFlutterViewContainer {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setName("ShopList", uniqueId: "main", params: ["animated": true])

    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
