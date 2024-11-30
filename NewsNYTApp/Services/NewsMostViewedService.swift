//
//  NewsMostViewedService.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import Foundation

class NewsMostViewedService {
    let apiKey: String = "qTl6HA9lEk9bHwEMNSrdjRAceMnSqQEZ"
    
    func getNewsList() async throws -> [NewsMostViewedData] {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api-key", value: self.apiKey)
        ]
        
        let endpoint = "/svc/mostpopular/v2/viewed/1.json"
        let request = DataRequest<NewsMostViewedResponse>(method: .GET,
                                                         endPoint: endpoint,
                                                         queryItems: queryItems)
        
        let result = await CoreService.shared.makeRequest(request)
        
        switch result {
        case .success(let response):
            guard let newsListData: [NewsMostViewedData] = response.data else {
                throw ServiceError.badURL
            }
            return newsListData

        case .failure(let error):
            throw error
        }
        
    }
}
