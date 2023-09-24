//
//  AppInfoViewController.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import ArchComponents
import UIKit


final class AppInfoViewController: ViewController {
    private let customView = UIView()
    private var viewModel: AppInfoViewModel
    
    init(viewModel: AppInfoViewModel, navigationDelegate: NavDelegate) {
        self.viewModel = viewModel
        super.init(navigationDelegate: navigationDelegate)
    }
      
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = customView
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        view.backgroundColor = .red
    }
    
    private func bind() {}
}
