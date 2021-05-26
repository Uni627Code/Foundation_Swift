//
//  RuntimeTool.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit

class RuntimeTool: NSObject {

    static func  getIvarName(cls: AnyClass?) {
        var count: UInt32 = 0
        if let ivars = class_copyIvarList(cls, &count) {
            for i in 0..<count {
                if let namePoint = ivar_getName(ivars[Int(i)]) {
                    let name = String(cString: namePoint)
                    PrintLog.info(name)
                }
            }
        }
    }

    static func getMethodName(cls: AnyClass?) {
        var count: UInt32 = 0
        let meths = class_copyMethodList(cls, &count)!
        for i in 0..<count {
            let namePoint = method_getName(meths[Int(i)])
            let name = String(cString: sel_getName(namePoint))
            PrintLog.info(name)
        }
    }

    // MARK:- Rumtime
    static func swizzleMethod(originalCls: AnyClass?, originalSelector: Selector, swizzledCls: AnyClass?, swizzledSelector: Selector) {
        guard let originalMethod = class_getInstanceMethod(originalCls, originalSelector) else { return }
        guard let swizzledMethod = class_getInstanceMethod(swizzledCls, swizzledSelector) else { return }

        let didAddMethod = class_addMethod(originalCls,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(originalCls,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
