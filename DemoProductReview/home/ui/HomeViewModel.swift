//
//  HomeViewModel.swift
//  DemoProductReview
//
//  Created by Israel on 7/21/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let homeDao = HomeDao()
    
    func fetchProducts() {
        isLoading = true
        errorMessage = nil
        homeDao.getProducts { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

