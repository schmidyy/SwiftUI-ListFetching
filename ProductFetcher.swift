//
//  ProductFetcher.swift
//  Products
//
//  Created by Mat Schmid on 2019-06-10.
//  Copyright © 2019 Shopify. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

enum LoadableState<T> {
    case loading
    case fetched(Result<T, FetchError>)
}

enum FetchError: Error {
    case error(String)
    
    var localizedDescription: String {
        switch self {
        case .error(let message):
            return message
        }
    }
}

class ProductFetcher: BindableObject {
    private static let apiUrlString = "https://gist.githubusercontent.com/schmidyy/02fdec9b9e05a71312a550fc50f948e6/raw/7fc2facbbf9c3aa526f35a32d0c7fe74a4fc29a1/products.json"
    var didChange = PassthroughSubject<ProductFetcher, Never>()
    
    var state: LoadableState<Root> = .loading {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        guard let apiUrl = URL(string: ProductFetcher.apiUrlString) else {
            state = .fetched(.failure(.error("Malformed API URL.")))
            return
        }
        
        URLSession.shared.dataTask(with: apiUrl) { [weak self] (data, _, error) in
            if let error = error {
                self?.state = .fetched(.failure(.error(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                self?.state = .fetched(.failure(.error("Malformed response data")))
                return
            }
            let root = try! JSONDecoder().decode(Root.self, from: data)
            
            DispatchQueue.main.async { [weak self] in
                self?.state = .fetched(.success(root))
            }
        }.resume()
    }
}

class ImageFetcher: BindableObject {
    var didChange = PassthroughSubject<Data, Never>()
    
    var data: Data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(url: String) {
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { (data, _, _) in
            guard let data = data else { return }
            DispatchQueue.main.async { [weak self] in
                self?.data = data
            }
        }.resume()
    }
}
