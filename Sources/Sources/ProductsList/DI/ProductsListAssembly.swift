//
//  ProductsListAssembly.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import ArchComponents
import UIKit


struct ProductsListAssembly {
    weak var navigationDelegate: NavDelegate?
  
    init(navigationDelegate: NavDelegate) {
        self.navigationDelegate = navigationDelegate
    }

    private func buildProductsListViewModel() -> ProductsListViewModel {
        let productsListRepository = ProductsListRepository()
        return ProductsListViewModel(requester: productsListRepository)
    }
  
    func productsListAssembly() -> ProductsListViewController? {
        let viewModel = buildProductsListViewModel()
        guard let navigationDelegate else { return nil }
        return ProductsListViewController(viewModel: viewModel, navigationDelegate: navigationDelegate)
    }
}

