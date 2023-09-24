//
//  RequestConfigProtocol.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import Foundation


public protocol RequestConfigProtocol {
    var requestUrl: String { get }
    var httpMethod: HttpMethod { get }
    var bodyParams: [String: Any] { get }
    var cachePolicy: NSURLRequest.CachePolicy { get }
}

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}
