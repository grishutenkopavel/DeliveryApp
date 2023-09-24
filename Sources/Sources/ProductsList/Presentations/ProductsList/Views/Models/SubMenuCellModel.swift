//
//  SubMenuCellModel.swift
//  
//
//  Created by Павел Гришутенко on 24.09.2023.
//

import Foundation
import UIKit


struct SubMenuCellModel: Hashable {
    let id: String?
    let name: String?
    let composition: String?
    let price: String?
    let weight: String?
    let isSpacy: Bool?
    let imagePath: String?
    var image: UIImage?
    
    init(_ response: SubMenuItem) {
        self.id = response.id
        self.name = response.name
        self.composition = response.content
        self.price = response.price
        self.weight = response.weight
        self.isSpacy = response.spicy != nil
        self.imagePath = response.image
        self.image = nil
    }
    
    init(_ model: SubMenuCellModel, image: UIImage? = nil) {
        self.id = model.id
        self.name = model.name
        self.composition = model.composition
        self.price = model.price
        self.weight = model.weight
        self.isSpacy = model.isSpacy
        self.imagePath = model.imagePath
        self.image = image ?? model.image
    }
}
