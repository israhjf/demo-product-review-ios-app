//
//  HomeView.swift
//  DemoProductReview
//
//  Created by Israel on 7/21/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading products...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                        Button("Retry") {
                            viewModel.fetchProducts()
                        }
                        .padding(.top)
                    }
                } else {
                    List(viewModel.products) { product in
                        HStack(alignment: .top) {
                            if let urlString = product.thumbnail, let url = URL(string: urlString) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 80, height: 80)
                                .cornerRadius(8)
                            } else {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(8)
                            }
                            VStack(alignment: .leading, spacing: 6) {
                                Text(product.title)
                                    .font(.headline)
                                Text(product.description)
                                    .font(.subheadline)
                                    .lineLimit(2)
                                Text("$\(String(format: "%.2f", product.price))")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Products")
        }
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}

// Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

