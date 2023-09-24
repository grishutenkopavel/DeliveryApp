//
//  ProductsListCoordinator.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import ArchComponents
import UIKit


public final class ProductsListCoordinator: Coordinator {
    private lazy var productsListAssembly = ProductsListAssembly(navigationDelegate: self)
    
    public override func build() -> UIViewController {
        return getProductsListController() ?? UIViewController()
    }
    
    func getProductsListController() -> UIViewController? {
        let controller = productsListAssembly.productsListAssembly()
        return controller
    }
}

