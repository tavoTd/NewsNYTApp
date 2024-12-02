//
//  DataRequest.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import Foundation

public struct DataRequest<Response: Codable> {
    let method: HttpMethod
    let baseURL: String
    let endPoint: String
    let queryItems : [URLQueryItem]?
    let headers: [String: String]?
    let body: Codable?
    
    public init(method: HttpMethod,
                baseURL: String,
                endPoint: String,
                queryItems: [URLQueryItem]?,
                headers: [String : String]? = [:],
                body: Codable? = nil) {
        self.method = method
        self.baseURL = baseURL
        self.endPoint = endPoint
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
    }
}
