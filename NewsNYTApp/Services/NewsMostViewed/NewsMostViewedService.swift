//
//  NewsMostViewedService.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import Foundation

class NewsMostViewedService {
    
    func fetchNewsMostViewed(in timeRange: TimeRange) async throws -> [NewsMostViewedData] {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api-key", value: Configuration.shared.NYTApiKey)
        ]
        
        let endpoint = "/svc/mostpopular/v2/viewed/\(timeRange.rawValue).json"
        let request = DataRequest<NewsMostViewedResponse>(method: .GET,
                                                          baseURL: Configuration.shared.baseURL,
                                                          endPoint: endpoint,
                                                          queryItems: queryItems)
        
        let result = await CoreService.shared.makeRequest(request)
        
        switch result {
        case .success(let response):
            guard let newsListData: [NewsMostViewedData] = response.data else {
                throw ServiceError.dataNotFound
            }
            return newsListData
            
        case .failure(let error):
            throw error
        }
        
    }
}
