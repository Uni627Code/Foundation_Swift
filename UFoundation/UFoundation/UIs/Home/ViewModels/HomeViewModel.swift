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
    
    
}

