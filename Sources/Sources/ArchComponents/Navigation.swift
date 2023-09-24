//
//  Navigation.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import UIKit

public protocol Navigation: AnyObject {
    var controller: UINavigationController? { get }
    func open(_ viewController: UIViewController)
    func openModaly(_ viewController: UIViewController)
    
    /// for custom animation in push/pop transition
    func setDelegate(delegate: UINavigationControllerDelegate)
}

extension UINavigationController: Navigation {
    public var controller: UINavigationController? {
        self
    }
  
    public func open(_ viewController: UIViewController) {
        pushViewController(viewController, animated: true)
    }
  
    public func openModaly(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
  
    public func setDelegate(delegate: UINavigationControllerDelegate) {
        self.delegate = delegate
    }
}
