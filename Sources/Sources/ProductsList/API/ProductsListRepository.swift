//
//  ProductsListRepository.swift
//  
//
//  Created by Павел Гришутенко on 22.09.2023.
//

import Combine
import Foundation
import Networking

protocol ProductsListRepositoryProtocol {
    func requestMenu() -> AnyPublisher<MenuResponse, NetworkError>
    func requestSubMenu(subMenuId: String) -> AnyPublisher<SubMenuResponse, NetworkError>
    func requestImage(path: String) -> AnyPublisher<Data, NetworkError>
}

final class ProductsListRepository: ProductsListRepositoryProtocol {
    let networkService = NetworkService.shared
    
    func requestMenu() -> AnyPublisher<MenuResponse, NetworkError> {
        networkService.makeRequest(ProductsListRequestConfig.getMenu).eraseToAnyPublisher()
    }
    
    func requestSubMenu(subMenuId: String) -> AnyPublisher<SubMenuResponse, NetworkError> {
        networkService.makeRequest(ProductsListRequestConfig.getSubMenu(subMenuId: subMenuId)).eraseToAnyPublisher()
    }
    
    func requestImage(path: String) -> AnyPublisher<Data, NetworkError> {
        networkService.makeRequest(ProductsListRequestConfig.getImage(path: path)).eraseToAnyPublisher()
    }
}
