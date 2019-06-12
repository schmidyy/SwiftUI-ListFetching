//
//  Models.swift
//  Products
//
//  Created by Mat Schmid on 2019-06-10.
//  Copyright © 2019 Shopify. All rights reserved.
//

import SwiftUI

typealias UINetworkModel = Decodable & Identifiable

struct Root: Decodable {    
    var products: [Product]
}

struct Product: UINetworkModel {
    var id: Int
    
    let title, body_html, vendor: String
    let variants: [Variant]
    let image: ProductImage
}

struct Variant: UINetworkModel {
    var id: Int
    
    let title, price: String
}

struct ProductImage: UINetworkModel {
    var id: Int

    let src: String
}
