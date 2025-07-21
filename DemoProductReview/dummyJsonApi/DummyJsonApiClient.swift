//
//  DummyJsonApiClient.swift
//  DemoProductReview
//
//  Created by Israel on 7/21/25.
//

import Foundation

class DummyJsonApiClient {
    static let shared = DummyJsonApiClient()
    private let baseUrl = "https://dummyjson.com"
    private let session = URLSession.shared
    
    func fetchProducts(completion: @escaping (Result<ProductsResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/products") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil))) }
                return
            }
            do {
                let decoder = JSONDecoder()
                let productsResponse = try decoder.decode(ProductsResponse.self, from: data)
                DispatchQueue.main.async { completion(.success(productsResponse)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
        task.resume()
    }
}

