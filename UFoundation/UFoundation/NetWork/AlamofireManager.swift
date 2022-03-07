//
//  AlamofireNet.swift
//  UFoundation
//  基础使用：https://www.jianshu.com/p/b7174ed30901
// 面向协议:https://www.jianshu.com/p/743a8d5f1dea
//  Created by dong on 3.3.22.
//  Copyright © 2022 Uni. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


/// 提供信息
protocol AFRequest {
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var params: [String: Any]? { get }
    
    //关联类型(为了保证所有的Response都能解析数据，我们需要对Response实现LGDecodable协议)
    associatedtype AFResponse: LGDecodable
    
}

///1.需要一个单独的类型负责发送请求。根据POP协议，定义以下协议
protocol AFDataClient {
    
    var host: String { get }
    
//    func send<T: AFRequest>(_ r: T, handle: @escaping (T.AFResponse) -> Void)
    
    func send<T:AFRequest>(_ r: T, success: @escaping (T.AFResponse) -> Void, failure: @escaping failBlock)
}

class AlamofireManager: AFDataClient {
    
    static let share = AlamofireManager()
    
    var host: String {
        return config.host
    }
    
    func send<T>(_ r: T, success: @escaping (T.AFResponse) -> Void, failure: @escaping failBlock) where T : AFRequest {
            
        let url = self.host + r.path
        
        let headers: HTTPHeaders = defaultHeader(nil)
        
#if DEBUG
        print("RequsetURL:\(url)")
        if let param = r.params {
            print("RequsetData:\(param)")
        }
#endif
        
        //示例
        AF.request(url, method: r.method, parameters: r.params, encoding: JSONEncoding.default, headers: headers).responseData { response in
            
            let result = self.handleResponse(response)
            
            if let error = result.1 {
                failure(error)
            } else {
                if let data = result.0 {
                    guard let responseJson = try? JSON(data: data) else { return failure(ErrorModel.custom("接口返回数据出错"))
                    }
                    let  res = T.AFResponse.parse(data: responseJson)
                    success(res!)
                } else {
                    failure(ErrorModel.custom("null"))
                }
            }
        }
    }
}

extension AlamofireManager {
    
    /// 添加请求头
    /// - Parameter header: header description
    /// - Returns: description
    func defaultHeader(_ header: [String: Any]? = nil) -> HTTPHeaders {
        var httpHeader: HTTPHeaders  = [:]
        httpHeader["Content-Type"] = "application/json;charset=UTF-8"
        httpHeader["api-response-handler"] = "true"
        httpHeader["tenant-id"] = "b70abd2d-ae49-4f50-87b4-27dd7c030a26"
        httpHeader["Authorization"] = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ6bHkuYjcwYWJkMmQtYWU0OS00ZjUwLTg3YjQtMjdkZDdjMDMwYTI2IiwidGVuYW50SWQiOiJiNzBhYmQyZC1hZTQ5LTRmNTAtODdiNC0yN2RkN2MwMzBhMjYiLCJleHAiOjE2NDY0MTM2NTcsImlhdCI6MTY0NjMyNzI1N30.HqagotnbuLRffA-0x6OMyK7v2rYdK79Tel9TZtq3Sg5r0GnjExPr_xPtl9UewfowRtIqBhzZfoJYNLQniqEWBA"
        
        if let header = header {
            for key in header.keys {
                if let value = header[key] as? String {
                    httpHeader[key] = value
                }
            }
        }
        return httpHeader
    }
    
    /// 处理返回数据
    /// - Parameter response: response description
    /// - Returns: description
    func handleResponse(_ response: AFDataResponse<Data>) -> (Data?, ErrorModel?)
    {
        
        var error: ErrorModel?
        
        if let resError = response.error {
            error = ErrorModel.custom(resError.localizedDescription)
#if DEBUG
            print("request fail:" + resError.localizedDescription)
#endif
        } else {
#if DEBUG
            print("ResponseData:\(JSON(response.data!))")
#endif
            
            if let code = response.response?.statusCode {
                
                if code == 200 {
                    let json = JSON(response.data!)
                    if let state = json["state"].bool {
                        if state == false{
                            error = ErrorModel.custom(json["msg"].string ?? "未知错误")
                        } else {
                            let state = json["data"]["state"].bool
                            if state == false {
                                let code = json["data"]["code"].intValue
                                error = ErrorModel.custom(self.getErrorDescription(by: code))

                            }
                        }
                    }
                } else {
                    error = ErrorModel.custom(self.getErrorDescription(by: 500))
                }
            }
        }
        
        return (response.data, error)
    }
    
    // MARK: 暂时只支持中文
    func getErrorDescription(by errorCode: Int) -> String {
        switch errorCode {
        case 400:
            return "请求无效：url出错"
        case 401, 403:
            return "鉴权出错"
        case 404:
            return "找不到指定页面"
        case 409:
            return "系统忙"
        case 500:
            return "获取数据异常（500）"
        default:
            return "未知错误"
        }
    }
}
