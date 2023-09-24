//
//  ProductsListRequestConfig.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import Foundation
import Networking

public enum ProductsListRequestConfig: RequestConfigProtocol {
  
    case getMenu
    case getSubMenu(subMenuId: String)
    case getImage(path: String)
    
    public var requestUrl: String {
        switch self {
        case .getMenu:
            return "https://vkus-sovet.ru/api/getMenu.php"
         case .getSubMenu(let subMenuId):
            return "https://vkus-sovet.ru/api/getSubMenu.php?menuID=" + subMenuId
        case .getImage(let path):
            return "https://vkus-sovet.ru" + path
        }
    }
  
    public var httpMethod: HttpMethod {
        switch self {
        case .getImage:
            return .get
        case .getMenu, .getSubMenu:
            return .post
        }
    }
    
    public var bodyParams: [String: Any] {
        [:]
    }
    
    public var cachePolicy: NSURLRequest.CachePolicy {
        switch self {
        case .getImage:
            return .returnCacheDataElseLoad
        default:
            return .reloadIgnoringLocalCacheData
        }
    }
}
