//
//  CoreService.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import Foundation

public class CoreService {
    
    public static var shared: CoreService = CoreService()
    public var baseURL: String = "https://api.nytimes.com"
    
    private init() { }
    
    func makeRequest<T: Codable>(_ request: DataRequest<T>) async -> Result<T, Error> {
        do {
            let data = try await makeTask(request)
            return .success(try JSONDecoder().decode(T.self, from: data))

        } catch {
            return .failure(error)
        }
    }
    
    private func makeTask<T: Codable>(_ request: DataRequest<T>) async throws -> Data {
        guard var urlComponents = URLComponents(string: request.baseURL) else {
            throw ServiceError.badURL
        }
        
        urlComponents.path = request.endPoint
        urlComponents.queryItems = request.queryItems
        
        guard let url = urlComponents.url else {
            throw ServiceError.badURL
        }
        
        var urlRequest = URLRequest(url: url, timeoutInterval: 30)
        urlRequest.httpMethod = request.method.rawValue
        //Aqui se agregan los headers
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = request.body, request.method != .GET {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        //manejo de statusCode
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...201).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
}
