//
//  UIView+ext.swift
//  
//
//  Created by Павел Гришутенко on 20.05.2023.
//

import Foundation
import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
