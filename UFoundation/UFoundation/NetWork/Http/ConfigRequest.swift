//
//  ConfigRequest.swift
//  UFoundation
//
//  Created by dong on 4.3.22.
//  Copyright © 2022 Uni. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public typealias successBlock = (JSON) -> Void
public typealias failBlock = (ErrorModel) -> Void

class ConfigRequest: NSObject {
    
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
