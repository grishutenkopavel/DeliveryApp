//
//  CoreCoordinator.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import ArchComponents
import UIKit

import ProductsList
import ShoppingCart
import AppInfo

public class CoreCoordinator: CoordinatorProtocol {
    public var parentCoordinator: CoordinatorProtocol?
  
    public var navigation: Navigation?

    let coreAssembly = CoreAssembly()
  
    public var childCoordinators: [CoordinatorProtocol] = [
        ProductsListCoordinator(),
        ShoppingCartCoordinator(),
        AppInfoCoordinator()
    ]
  
    public init() {}
  
    public func build() -> UIViewController {
        getStartController()
    }
  
    func getStartController() -> UIViewController {
        return coreAssembly.coreModuleAssembly(childCoordinators: childCoordinators)
    }
  
    public func `deinit`() {
        childCoordinators.removeAll()
    }
}
