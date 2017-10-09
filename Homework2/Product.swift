//
//  Product.swift
//  Homework2
//
//  Created by Ayyanchira, Akshay Murari on 10/9/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import Foundation

class Product: NSObject {
    var category:String
    var price:Float
    var title:String
    var author:String
    var releaseDate:String
    var thumbnailURl:URL
    var otherImageURL:URL?
    var productDescription:String?
    
    
    init(category :String, price: Float, title: String, author:String, releaseDate:String, thumbnailURL:URL, otherImageURL:URL?, productDescription:String?) {
        self.category = category
        self.price = price
        self.title = title
        self.author = author
        self.releaseDate = releaseDate
        self.thumbnailURl = thumbnailURL
        if let url = otherImageURL {
            self.otherImageURL = url
        }
        if let descriptionNonNull = productDescription {
            self.productDescription = descriptionNonNull
        }
    }
}

