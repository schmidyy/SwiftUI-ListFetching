//
//  ProductDetailsView.swift
//  Products
//
//  Created by Mat Schmid on 2019-06-10.
//  Copyright © 2019 Shopify. All rights reserved.
//

import SwiftUI

struct ProductDetailsView : View {
    var product: Product
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ProductRow(product: product)
                Text("Variants").font(.title).padding()
                List(product.variants) { variant in
                    VStack(alignment: .leading) {
                        Text(variant.title)
                        Text(variant.price)
                    }
                }
            }
            .navigationBarTitle(Text("Details"))
        }
        
    }
}
