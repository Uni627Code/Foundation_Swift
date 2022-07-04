//
//  Product.swift
//  UFoundation
//
//  Created by 陆小懒 on 2022/3/30.
//  Copyright © 2022 Uni. All rights reserved.
//

import UIKit

struct Product {
    
    var id: String = UUID().uuidString
    var title: String
    var imageURL: String
    var descriptionText: String
    var price: Int
    var currency: String = "$"
    var numberOfReviews: Int
    var starRating: Int
    
    init(title: String, descriptionText: String, price: Int, imageURL: String, numberOfReviews: Int, starRating: Int) {
        self.title = title
        self.descriptionText = descriptionText
        self.price = price
        self.imageURL = imageURL
        self.numberOfReviews = numberOfReviews
        self.starRating = starRating
    }
}
