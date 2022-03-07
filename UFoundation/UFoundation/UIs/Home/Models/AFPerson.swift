//
//  AFPerson.swift
//  UFoundation
//
//  Created by dong on 3.3.22.
//  Copyright © 2022 Uni. All rights reserved.
//

import UIKit
import SwiftyJSON

class AFPerson: NSObject {

    var name: String?
    
    //元类型 类类型 用 required
    required init(_ json: JSON) {
        
    }
}

extension AFPerson: LGDecodable {
    
    static func parse(json: Any) -> Self? {
        
        if let json = json as? JSON {
            return self.init(json)
        }
        return nil
    }
}



