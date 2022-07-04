//
//  Category.swift
//  UFoundation
//
//  Created by 陆小懒 on 2022/3/30.
//  Copyright © 2022 Uni. All rights reserved.
//

import UIKit

struct Category {
    var id: String = UUID().uuidString
    var imageURL: String
    var numberOfProducts: Int = 0
    var title: String
    var products: [Product]
    
    init(title: String, imageURL: String, products: [Product]) {
        self.title = title
        self.imageURL = imageURL
        self.products = products
        self.numberOfProducts = products.count
    }
}
