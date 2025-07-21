//
//  ProductModels.swift
//  DemoProductReview
//
//  Created by Israel on 7/21/25.
//

import Foundation

struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
}

struct ProductsResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

