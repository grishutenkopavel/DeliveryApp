//
//  ProductsListViewModel.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import ArchComponents
import Combine
import UIKit

enum ProductsListError: Error {
    case empty
}

final class ProductsListViewModel: ViewModel {
    var cancellable = Set<AnyCancellable>()
    var state = CurrentValueSubject<State, ProductsListError>(State())
    
    private let requester: ProductsListRepositoryProtocol
    
    struct State {
        var munuCells: [MenuCellModel] = []
        var subMenuCells: [SubMenuCellModel] = []
        var subMenuTitle: String = ""
        var isLoading = false
      }
      
    enum Actions {
        case fetchMenu
        case fetchImage(id: String, imagePath: String)
        case selectMenuItem(id: String)
      }
      
    enum Mutations {
        case updateMenuList([MenuCellModel])
        case updateSubMenuList([SubMenuCellModel])
        case updateImage(cellId: String, imagePath: String, image: UIImage?)
        case updateSubMenuHeader(String)
        case setLoading(Bool)
    }
    
    
    init(requester: ProductsListRepositoryProtocol) {
        self.requester = requester
    }
        
    func reduce(_ action: Actions) -> AnyPublisher<Mutations, ProductsListError> {
        switch action {
        case .fetchMenu:
            return Publishers.Merge(
                Just(Mutations.setLoading(true))
                    .mapError { _ in ProductsListError.empty }.eraseToAnyPublisher(),
                requestMenu()
            ).eraseToAnyPublisher()
        case let .fetchImage(id, path):
            return fetchImage(cellId: id, imagePath: path)
        case .selectMenuItem(let id):
            let models = currentState.munuCells.map { MenuCellModel($0, isSelected: $0.id == id) }
            let name = models.first(where: {$0.id == id})?.name ?? ""
            return Publishers.Merge4(
                Just(Mutations.setLoading(false))
                    .mapError { _ in ProductsListError.empty }.eraseToAnyPublisher(),
                Just(Mutations.updateMenuList(models))
                    .mapError { _ in ProductsListError.empty }.eraseToAnyPublisher(),
                requestSubMenu(subMenuId: id),
                Just(Mutations.updateSubMenuHeader(name))
                    .mapError { _ in ProductsListError.empty }.eraseToAnyPublisher()
            ).eraseToAnyPublisher()
        }
    }

    func mutate(_ state: State, _ mutation: Mutations) -> State {
        var newState = state
        switch mutation {
        case .updateMenuList(let munuCells):
            newState.munuCells = munuCells
        case .updateSubMenuList(let subMenuCells):
            newState.subMenuCells = subMenuCells
        case let .updateImage(cellId, path, image):
            if let modelIndex = currentState.munuCells.firstIndex(where: { $0.id == cellId && $0.imagePath == path }) {
                newState.munuCells = currentState.munuCells
                newState.munuCells[modelIndex] = .init(newState.munuCells[modelIndex], image: image)
            } else if let modelIndex = currentState.subMenuCells.firstIndex(where: { $0.id == cellId && $0.imagePath == path }) {
                newState.subMenuCells = currentState.subMenuCells
                newState.subMenuCells[modelIndex] = .init(newState.subMenuCells[modelIndex], image: image)
            }
        case .updateSubMenuHeader(let header):
            newState.subMenuTitle = header
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
    
    private func requestMenu() -> AnyPublisher<Mutations, ProductsListError> {
        return requester.requestMenu()
            .mapError { error -> ProductsListError in
                return .empty
            }
            .map { model -> Mutations in
                let cellModels = model.menuList?.map { MenuCellModel($0) }
                return .updateMenuList(cellModels ?? [])
            }.eraseToAnyPublisher()
    }
    
    private func requestSubMenu(subMenuId: String) -> AnyPublisher<Mutations, ProductsListError> {
        return requester.requestSubMenu(subMenuId: subMenuId)
            .mapError { error -> ProductsListError in
                return .empty
            }
            .map { model -> Mutations in
                let cellModels = model.menuList.map { SubMenuCellModel($0) }
                return .updateSubMenuList(cellModels)
            }.eraseToAnyPublisher()
    }
    
    private func fetchImage(cellId: String, imagePath: String) -> AnyPublisher<Mutations, ProductsListError> {
        return requester.requestImage(path: imagePath)
            .mapError { error -> ProductsListError in
                return .empty
            }
            .map { data -> Mutations in
                return .updateImage(cellId: cellId, imagePath: imagePath, image: UIImage(data: data))
            }.eraseToAnyPublisher()
    }
}
