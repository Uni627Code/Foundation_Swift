//
//  PrintLog.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit

struct PrintLog {

    static func info<T>(_ message: T,
                     file: String = #file,
                     method: String = #function,
                     line: Int = #line)
    {
        #if Dev || AdHoc
        print("\u{1f600}\u{1f600}\u{1f600}\((file as NSString).lastPathComponent)[\(line)], \(method): \n\u{1f42c}\u{1f42c}\n\(message)\n\u{1f433}\u{1f433}")
        #endif
    }


    static func warning<T>(_ message: T,
                        file: String = #file,
                        method: String = #function,
                        line: Int = #line)
    {
        #if Dev || AdHoc
        print("\u{1f635}\u{1f635}\u{1f635}\((file as NSString).lastPathComponent)[\(line)], \(method): \n\u{1f42c}\u{1f42c}\n\(message)\n\u{1f433}\u{1f433}")
        #endif
    }

    static func error<T>(_ message: T,
                           file: String = #file,
                           method: String = #function,
                           line: Int = #line)
    {
        #if Dev || AdHoc
        print("\u{2620}\u{2620}\u{2620}\((file as NSString).lastPathComponent)[\(line)], \(method): \n\u{1f42c}\u{1f42c}\n\(message)\n\u{1f433}\u{1f433}")
        #endif
    }
}
