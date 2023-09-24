//
//  AppInfoCoordinator.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import ArchComponents
import UIKit


public final class AppInfoCoordinator: Coordinator {
    private lazy var appInfoAssembly = AppInfoAssembly(navigationDelegate: self)
    
    public override func build() -> UIViewController {
        return getAppInfoController() ?? UIViewController()
    }
    
    func getAppInfoController() -> UIViewController? {
        let controller = appInfoAssembly.appInfoAssembly()
        return controller
    }
}
