//
//  CoreAssembly.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//


import ArchComponents
import UIKit

public struct CoreAssembly {
  
    var tabController = CoreController()

    public init() {}

    public func coreModuleAssembly(childCoordinators: [CoordinatorProtocol]) -> UITabBarController {
    
        var controllers: [UIViewController] = []
    
        for (tab, controller) in compileTabs(childCoordinators: childCoordinators).sorted(by: { $0.key.rawValue < $1.key.rawValue }) {
            controller.tabBarItem = tab.getTabItem()
            controllers.append(controller)
        }
        tabController.viewControllers = controllers
        return tabController
    }
  
    private func compileTabs(childCoordinators: [CoordinatorProtocol]) -> [AppTabs: UIViewController] {
        let productsList = prepareChildCoordinator(childCoordinators[0])
        let shoppingCart = prepareChildCoordinator(childCoordinators[1])
        let appInfo = prepareChildCoordinator(childCoordinators[2])
        return [
          .productsList: productsList,
          .shoppingCart: shoppingCart,
          .appInfo: appInfo
        ]
  }
  
  private func prepareChildCoordinator(_ childCoordinator: CoordinatorProtocol?) -> UIViewController {
      let navigationController = CoreNavigationController(rootViewController: childCoordinator?.build() ?? CoreNavigationController())
      childCoordinator?.navigation = navigationController
      return navigationController
  }
}
