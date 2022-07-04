//
//  HttpManager.swift
//  UFoundation
//  基础使用：https://www.jianshu.com/p/b7174ed30901
//  面向协议:https://www.jianshu.com/p/743a8d5f1dea
//  moya 和rxswift https://juejin.cn/post/6844903935149342727
//  Created by 陆小懒 on 2022/4/15.
//  Copyright © 2022 Uni. All rights reserved.
//


import Alamofire
import SwiftyJSON


///1.需要一个单独的类型负责发送请求。根据POP协议，定义以下协议
protocol AFDataClient {
    
    var host: String { get }
        
    func send<T:HttpOptions>(_ r: T, success: @escaping (T.LGResponse) -> Void, failure: @escaping failBlock)
}

class HttpManager: ConfigRequest, AFDataClient {
    
    static let share = HttpManager()
    
    /// 配置域名
    var host: String {
        return config.host
    }
        
    /// 网络请求
    func send<T>(_ r: T, success: @escaping (T.LGResponse) -> Void, failure: @escaping failBlock) where T : HttpOptions {
            
        let url = self.host + r.path
        
        let headers: HTTPHeaders = defaultHeader(r.httpHeaders)
        
#if DEBUG
        print("RequsetURL:\(url)")
        if let param = r.params {
            print("RequsetData:\(param)")
        }
#endif
        let method = HTTPMethod(rawValue: r.method.rawValue)
        
        //示例
        AF.request(url, method: method, parameters: r.params, encoding: JSONEncoding.default, headers: headers).responseData { response in
            
            let result = self.handleResponse(response)
            
            if let error = result.1 {
                failure(error)
            } else {
                if let data = result.0 {
                    guard let responseJson = try? JSON(data: data) else {
                        return failure(ErrorModel.custom("json解析出错"))
                    }
                    guard let  res = T.LGResponse.parse(json: responseJson) else {
                        return failure(ErrorModel.custom("生成model出错"))
                    }
                    success(res)
                } else {
                    failure(ErrorModel.custom("null"))
                }
            }
        }
    }
}


extension HttpManager {
    
    
    
    
}
