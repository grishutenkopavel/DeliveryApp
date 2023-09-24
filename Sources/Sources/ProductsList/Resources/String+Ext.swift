//
//  String+Ext.swift
//  
//
//  Created by Павел Гришутенко on 24.09.2023.
//

import Foundation

extension String {

    enum PluralRuleType: String {
        case foodCount
    }

    static func pluralString(format: PluralRuleType, _ value: Int) -> String {
        guard let path = Bundle.module.path(forResource: "ru", ofType: "lproj"),
              let bundle = Bundle(path: path) else { return " " }
        let formatString = NSLocalizedString(format.rawValue, tableName: nil, bundle: bundle, value: "", comment: "")
        return String(format: formatString, locale: Locale(identifier: "ru_RU"), arguments: [value])
    }
}

