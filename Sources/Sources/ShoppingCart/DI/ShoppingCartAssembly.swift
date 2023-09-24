//
//  ShoppingCartAssembly.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import ArchComponents
import UIKit


struct ShoppingCartAssembly {
    weak var navigationDelegate: NavDelegate?
  
    init(navigationDelegate: NavDelegate) {
        self.navigationDelegate = navigationDelegate
    }

    private func buildShoppingCartViewModel() -> ShoppingCartViewModel {
        return ShoppingCartViewModel()
    }
  
    func shoppingCartAssembly() -> ShoppingCartViewController? {
        let viewModel = buildShoppingCartViewModel()
        guard let navigationDelegate else { return nil }
        return ShoppingCartViewController(viewModel: viewModel, navigationDelegate: navigationDelegate)
    }
}
