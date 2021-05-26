//
//  SecondViewController.swift
//  Community
//
//  Created by uni on 2021/1/6.
//  Copyright © 2021 EinYun. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Second Page"

         var count = 0
         if let params = urlParams as? [String: Any], let counter = params["finalCount"] as? Int {
             count = counter
         }

         let label = UILabel(frame: CGRect(x: 80, y: 100, width: 200, height: 40))
         label.text = "最终计数为\(count)"
         label.backgroundColor = .blue
         label.textColor = .white
         view.addSubview(label)
    }
}

private struct AssociatedKey {
    static var urlParams = "urlParams"
}

extension UIViewController {

    var urlParams: [AnyHashable : Any]? {
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKey.urlParams,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            var result: [AnyHashable : Any]?
            if let params = objc_getAssociatedObject(self, &AssociatedKey.urlParams) as? [AnyHashable : Any] {
                result = params
            }
            return result
        }
    }
}
