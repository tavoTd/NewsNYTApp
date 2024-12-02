//
//  ServiceError.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import Foundation

public enum ServiceError: Error {
    case badURL
    case networkUnavailable
    case serverError(statusCode: Int)
    case decodingError(Error)
    case unauthorizedRequest
    case limitRequestReached
    case dataNotFound
    case unknownError
}
