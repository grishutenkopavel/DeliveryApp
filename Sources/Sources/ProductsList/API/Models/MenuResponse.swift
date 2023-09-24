//
//  MenuResponse.swift
//  
//
//  Created by Павел Гришутенко on 22.09.2023.
//

import Foundation

struct MenuResponse: Decodable {
    let status: Bool?
    let menuList: [MenuItem]?
}

struct MenuItem: Decodable {
    let menuID: String?
    let image: String?
    let name: String?
    let subMenuCount: Int?
}
