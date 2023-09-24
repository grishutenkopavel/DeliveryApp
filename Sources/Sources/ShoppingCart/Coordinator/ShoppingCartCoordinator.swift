//
//  ShoppingCartCoordinator.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import ArchComponents
import UIKit


public final class ShoppingCartCoordinator: Coordinator {
    private lazy var shoppingCartAssembly = ShoppingCartAssembly(navigationDelegate: self)
    
    public override func build() -> UIViewController {
        return getShoppingCartController() ?? UIViewController()
    }
    
    func getShoppingCartController() -> UIViewController? {
        let controller = shoppingCartAssembly.shoppingCartAssembly()
        return controller
    }
}
