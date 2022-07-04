//
//  HttpOptions.swift
//  UFoundation
//
//  Created by 陆小懒 on 2022/4/15.
//  Copyright © 2022 Uni. All rights reserved.
//

import Foundation

enum LCHTTPMethod: String {
    case GET
    case POST
}

///1. 提供网络信息
protocol HttpOptions {
    
    var path: String { get }
    
    var method: LCHTTPMethod { get }
    
    var params: [String: Any]? { get }
    
    //关联类型,方便后面 json 转模型，设置这个泛型类型是能够通用化
    associatedtype LGResponse: HttpDecodable
    
    /// 设置请求头
    var httpHeaders: [String: Any]? { get }
        
}
