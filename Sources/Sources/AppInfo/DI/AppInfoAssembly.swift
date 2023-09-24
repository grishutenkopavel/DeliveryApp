//
//  AppInfoAssembly.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import ArchComponents
import UIKit


struct AppInfoAssembly {
    weak var navigationDelegate: NavDelegate?
  
    init(navigationDelegate: NavDelegate) {
        self.navigationDelegate = navigationDelegate
    }

    private func buildAppInfoViewModel() -> AppInfoViewModel {
        return AppInfoViewModel()
    }
  
    func appInfoAssembly() -> AppInfoViewController? {
        let viewModel = buildAppInfoViewModel()
        guard let navigationDelegate else { return nil }
        return AppInfoViewController(viewModel: viewModel, navigationDelegate: navigationDelegate)
    }
}
