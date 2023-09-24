//
//  Coordinator.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import UIKit

public protocol NavDelegate: AnyObject {
    func `deinit`()
}

public protocol CoordinatorProtocol: NavDelegate {
    var parentCoordinator: CoordinatorProtocol? { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigation: Navigation? { get set }
    func build() -> UIViewController
    func dismiss(_ coordinator: CoordinatorProtocol)
    func dismissAll()
}

public extension CoordinatorProtocol {
    func dismiss(_ coordinator: CoordinatorProtocol) {
        guard let index = childCoordinators.firstIndex(where: { $0 === coordinator}) else { return }
        childCoordinators.remove(at: index)
    }
  
    func dismissAll() {
        childCoordinators.removeAll()
    }
  
    func `deinit`() {
        childCoordinators.removeAll()
        parentCoordinator?.dismiss(self)
    }
}

open class Coordinator: CoordinatorProtocol {
    open weak var parentCoordinator: CoordinatorProtocol?
    open weak var navigation: Navigation?
    open var childCoordinators: [CoordinatorProtocol] = []
  
    public init(parentCoordinator: CoordinatorProtocol? = nil, navigation: Navigation? = nil) {
        self.parentCoordinator = parentCoordinator
        self.navigation = navigation
    }
  
    open func build() -> UIViewController {
        return UIViewController()
    }
}
