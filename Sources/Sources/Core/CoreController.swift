//
//  CoreController.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import UIKit
import Combine
import UIComponents

class CoreController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .backgroundColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.selectedTabColor]
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.selected.iconColor = .selectedTabColor
        tabBar.scrollEdgeAppearance = appearance
        tabBar.standardAppearance = appearance
    }
}

class CoreNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .backgroundColor
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.standardAppearance = appearance
        navigationBar.tintColor = .white
    }
}
