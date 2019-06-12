//
//  ProductRow.swift
//  Products
//
//  Created by Mat Schmid on 2019-06-10.
//  Copyright © 2019 Shopify. All rights reserved.
//

import SwiftUI

struct ProductRow: View {
    var product: Product
    
    var body: some View {
        HStack {
            LoadableImageView(with: product.image.src).frame(width: 60, height: 60)
            VStack(alignment: .leading) {
                Text(product.title)
                Text(product.body_html).font(.caption)
            }
        }
    }
}
