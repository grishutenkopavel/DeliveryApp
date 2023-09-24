//
//  AppTabs.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import UIKit

enum AppTabs: Int {
    case productsList = 0
    case shoppingCart = 1
    case appInfo = 2
  
    func getTabItem() -> UITabBarItem {
        switch self {
        case .productsList:
            return UITabBarItem.init(title: "", image: UIImage(systemName: "list.bullet"), tag: self.rawValue)
        case .shoppingCart:
            return UITabBarItem.init(title: "", image: UIImage(systemName: "bag"), tag: self.rawValue)
        case .appInfo:
            return UITabBarItem.init(title: "", image: UIImage(systemName: "info"), tag: self.rawValue)
        }
    }
}
