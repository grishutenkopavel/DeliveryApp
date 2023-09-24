//
//  SubMenuResponse.swift
//  
//
//  Created by Павел Гришутенко on 22.09.2023.
//

import Foundation



struct SubMenuResponse: Decodable {
    let status: Bool?
    let menuList: [SubMenuItem]
}

struct SubMenuItem: Decodable {
    let id: String?
    let image: String?
    let name: String?
    let content: String?
    let price: String?
    let weight: String?
    let spicy: String?
}
