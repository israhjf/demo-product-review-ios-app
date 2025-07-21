//
//  HomeDao.swift
//  DemoProductReview
//
//  Created by Israel on 7/21/25.
//

import Foundation

class HomeDao {
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        DummyJsonApiClient.shared.fetchProducts { result in
            switch result {
            case .success(let response):
                completion(.success(response.products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

