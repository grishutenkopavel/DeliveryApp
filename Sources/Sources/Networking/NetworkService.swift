//
//  NetworkService.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import Combine
import Foundation


public class NetworkService {
  
    public static let shared = NetworkService()
  
    private func makeRequest<C: RequestConfigProtocol, T: Decodable>(config: C, _ request: @escaping (C) async throws -> T) -> Future<T, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let model = try await request(config)
                    promise(.success(model))
                }
                catch {
                    promise(.failure((error as? NetworkError) ?? .errorUndefined))
                }
            }
        }
    }
  
    public func makeRequest<T: Decodable>(_ config: RequestConfigProtocol) -> Future<T, NetworkError>  {
        makeRequest(config: config) { config in
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            guard let url = URL(string: config.requestUrl)
            else {
                throw NetworkError.urlNotConfiguredFailure
            }
            var request = URLRequest(url: url, cachePolicy: config.cachePolicy)
            request.httpMethod = config.httpMethod.rawValue
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
           
            if config.httpMethod != .get {
                guard let httpBody = try? JSONSerialization.data(withJSONObject: config.bodyParams, options: [])
                else {
                    throw NetworkError.requestBodySerializationFailure
                }
                request.httpBody = httpBody
            }
            
            let (data, _) = try await session.data(for: request)
            
            if let rawData = data as? T {
                return rawData
            }
            
            let decoder = JSONDecoder()
            let response = try decoder.decode(T.self, from: data)
            return response
        }
    }
}

public enum NetworkError: Error {
    case requestBodySerializationFailure
    case urlNotConfiguredFailure
    case responeFailure(statusCode: Int)
    case errorUndefined
}
