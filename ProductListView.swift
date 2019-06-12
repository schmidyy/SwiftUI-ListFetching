//
//  ProductListView.swift
//  Products
//
//  Created by Mat Schmid on 2019-06-10.
//  Copyright © 2019 Shopify. All rights reserved.
//

import SwiftUI

struct ProductListView : View {
    @ObjectBinding var productFetcher = ProductFetcher()
    
    private var stateContent: AnyView {
        switch productFetcher.state {
        case .loading:
            return AnyView(
                ActivityIndicator(style: .medium)
            )
        case .fetched(let result):
            switch result {
            case .failure(let error):
                return AnyView(
                    Text(error.localizedDescription)
                )
            case .success(let root):
                return AnyView(
                    List(root.products) { product in
                        NavigationButton(destination: ProductDetailsView(product: product)) {
                            ProductRow(product: product)
                        }
                    }
                )
            }
        }
    }
    
    var body: some View {
        NavigationView {
            stateContent
            .navigationBarTitle(Text("Products"))
        }
    }
}
