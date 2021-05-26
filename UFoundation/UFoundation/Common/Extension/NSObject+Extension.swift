//
//  NSObject+Extension.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit


extension NSObject {
    // MARK: 返回类名
    var className: String {
        get {
            let name =  type(of: self).description()
            if name.contains("."){
                return name.components(separatedBy: ".")[1];
            } else {
                return name;
            }
        }
    }
}
