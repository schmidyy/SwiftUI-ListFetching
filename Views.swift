//
//  Views.swift
//  Products
//
//  Created by Mat Schmid on 2019-06-10.
//  Copyright © 2019 Shopify. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}

struct LoadableImageView: View {
    @ObjectBinding var imageFetcher: ImageFetcher
    
    init(with urlString: String) {
        imageFetcher = ImageFetcher(url: urlString)
    }
    
    var body: some View {
        if let image = UIImage(data: imageFetcher.data) {
            return AnyView(
                Image(uiImage: image).resizable()
            )
        } else {
            return AnyView(
                ActivityIndicator(style: .medium)
            )
        }
    }
}
