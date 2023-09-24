//
//  String+ext.swift
//  
//
//  Created by Павел Гришутенко on 24.09.2023.
//

import Foundation

public extension String {
    func localized(bundle: Bundle) -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: self, comment: "")
    }
}
