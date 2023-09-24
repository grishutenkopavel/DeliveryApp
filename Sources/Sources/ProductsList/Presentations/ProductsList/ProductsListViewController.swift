//
//  ProductsListViewController.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import ArchComponents
import Combine
import UIKit
import UIComponents

final class ProductsListViewController: ViewController {
    private let customView = ProductsListView()
    private var viewModel: ProductsListViewModel
    private var menuDataSourceProvider = MenuDataSourceProvider()
    private var subMenuDataSourceProvider = SubMenuDataSourceProvider()

    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: ProductsListViewModel, navigationDelegate: NavDelegate) {
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
        prepareNavigationBar()
        bind()
        viewModel.action(.fetchMenu)
    }
    
    private func prepareNavigationBar() {
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        let image = UIImage(systemName: "phone")
        let button = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = button
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: LogoView())
    }

    private func bind() {
        subMenuDataSourceProvider.setDataSource(for: customView.subMenuList)
        subMenuDataSourceProvider.update(items: viewModel.currentState.subMenuCells, in: customView.subMenuList)
        subMenuDataSourceProvider.setSupplimentaryProvider(customView.supplementaryProvider, for: customView.subMenuList)
        
        customView.headerCollectionShown
            .first()
            .sink { [weak self] in
                guard let self else { return }
                self.menuDataSourceProvider.setDataSource(for: self.customView.menuList)
                self.menuDataSourceProvider.update(items: self.viewModel.currentState.munuCells, in: self.customView.menuList)
                self.bindUI()
            }
            .store(in: &subscriptions)

        viewModel.state.map(\.isLoading)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] isLoading in
                    self?.customView.showLoading(isLoading)
            })
            .store(in: &subscriptions)
        
        viewModel.state.map(\.munuCells)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] cellModels in
                    guard let self else { return }
                    if !cellModels.isEmpty,
                       let id = cellModels.first?.id,
                       cellModels.first(where: { $0.isSelected }) == nil {
                        self.viewModel.action(.selectMenuItem(id: id))
                    }
                    self.menuDataSourceProvider.update(items: cellModels, in: self.customView.menuList)
            })
            .store(in: &subscriptions)
        
        viewModel.state.map(\.subMenuCells)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] cellModels in
                    guard let self else { return }
                    self.subMenuDataSourceProvider.update(items: cellModels, in: self.customView.menuList)
            })
            .store(in: &subscriptions)
        
        viewModel.state.map(\.subMenuTitle)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] title in
                    self?.customView.headerTitle?.text = title
            })
            .store(in: &subscriptions)
    }
    
    private func bindUI() {
        customView.menuList
            .getItemAtModel(sectionModel: Int.self, itemModel: MenuCellModel.self)
            .sink { [weak self] selectedModel, event in
                switch event {
                case .cellDidSelected:
                    guard let selectedId = selectedModel.id else { return }
                    self?.viewModel.action(.selectMenuItem(id: selectedId))
                case .cellWillAppear:
                    guard
                        let appearedId = selectedModel.id,
                        let appearedImagePath = selectedModel.imagePath,
                        selectedModel.image == nil
                    else { return }
                    self?.viewModel.action(.fetchImage(id: appearedId, imagePath: appearedImagePath))
                }
            }
            .store(in: &subscriptions)
        
        customView.subMenuList
            .getItemAtModel(sectionModel: Int.self, itemModel: SubMenuCellModel.self)
            .sink { [weak self] selectedModel, event in
                switch event {
                case .cellWillAppear:
                    guard
                        let appearedId = selectedModel.id,
                        let appearedImagePath = selectedModel.imagePath,
                        selectedModel.image == nil
                    else { return }
                    self?.viewModel.action(.fetchImage(id: appearedId, imagePath: appearedImagePath))
                default:
                    break
                }
            }
            .store(in: &subscriptions)
    }
}
