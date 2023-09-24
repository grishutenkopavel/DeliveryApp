//
//  MenuCellModel.swift
//  
//
//  Created by Павел Гришутенко on 24.09.2023.
//

import Foundation
import UIKit


struct MenuCellModel: Hashable {
    let id: String?
    let name: String?
    let count: Int?
    let imagePath: String?
    let image: UIImage?
    let isSelected: Bool
    
    init(_ response: MenuItem) {
        self.id = response.menuID
        self.name = response.name
        self.count = response.subMenuCount
        self.imagePath = response.image
        self.isSelected = false
        self.image = nil
    }
    
    init(_ model: MenuCellModel, isSelected: Bool? = nil, image: UIImage? = nil) {
        self.id = model.id
        self.name = model.name
        self.count = model.count
        self.imagePath = model.imagePath
        self.isSelected = isSelected ?? model.isSelected
        self.image = image ?? model.image
    }
}
