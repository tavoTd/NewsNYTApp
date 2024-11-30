//
//  NewsListViewModel.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import UIKit

class NewsListViewModel {
    
    var model = NewsListModel()
    var showNewsListObservable: Observable<Bool> = Observable(initialValue: false)
    
    public init() {
    }
    
    func getNewsList() {
        let service = NewsMostViewedService()
        
        Task {
            do {
                let response = try await service.getNewsList()
                print("lo que recibo es esto \(response)")
                
            } catch {
                print("El error que ocurrio es este \(error)")
            }
        }
    }
}
