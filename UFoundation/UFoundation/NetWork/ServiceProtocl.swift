//
//  ServiceProtocl.swift
//  UFoundation
//
//  Created by dong on 2.3.22.
//  Copyright © 2022 Uni. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON


protocol ClientProtocol {
    
    var host: String { get }
    
    func send<T: LCRequest>(_ r: T, handler: @escaping (T.LGResponse?) -> Void)
    
}


/// 提供一个网络管理类 LGClient
class LGClient:ConfigRequest, ClientProtocol {
    
    static let manager = LGClient()
    
    var host: String = config.host
    
    func send<T>(_ r: T, handler: @escaping (T.LGResponse?) -> Void) where T : LCRequest {
        
        guard let url = URL(string: host.appending(r.path)) else {
            
            handler(nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = r.method.rawValue
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = defaultHeader(r.httpHeaders).dictionary
        config.timeoutIntervalForRequest = 30
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: config)
                
        let task = session.dataTask(with: request) {
            data, response, error in
            
            
            let json = try! JSON(data: data ?? Data())
            
            
            if let _ = data, let res = T.LGResponse.parse(json: json) {
                                
                DispatchQueue.main.async {
                    handler(res)
                }
            } else {
                DispatchQueue.main.async { handler(nil) }
            }
        }
        task.resume()
    }
    
}




