//
//  HomeViewModel.swift
//  UFoundation
//
//  Created by dong on 6.5.21.
//

import UIKit
 
class HomeViewModel: NSObject {

    var id: String?
    
    var name: String?
    
    
    @objc func sendMessage(_ message: String) {
        NSLog("发送的消息是 = %@", message)
    
    }
    
    override init() {

    }
}


class AFPersonRequest: LCRequest {
        
    typealias LGResponse = LGPersonArray
    
    var params: [String : Any]?
    
    var path: String {
        return "portal/sys/sysMenu/v1/getCurrentUserMenu?menuAlias=mobile_menu"
    }
    
    var method: LCHTTPMethod = .GET
    
    var httpHeaders: [String : Any]?
        
}
