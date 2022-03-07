//
//  LGCommonProtocol.swift
//  UFoundation
//
//  Created by dong on 4.3.22.
//  Copyright © 2022 Uni. All rights reserved.
//

import UIKit


enum LCHTTPMethod: String {
    case GET
    case POST
}

///1. 提供网络信息
protocol LCRequest {
    
    var path: String { get }
    
    var method: LCHTTPMethod { get }
    
    var params: [String: Any]? { get }
    
    //关联类型,方便后面 json 转模型，设置这个泛型类型是能够通用化
    associatedtype LGResponse: LGDecodable
    
    /// 设置请求头
    var httpHeaders: [String: Any]? { get }
        
}
