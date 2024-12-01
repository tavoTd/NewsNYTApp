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
    var showErrorService: Observable<String> = Observable(initialValue: "")
    
    public init() {
    }
    
    func fetchNewsMostViewed() {
        Task {
            do {
                let service = NewsMostViewedService()
                let response = try await service.fetchNewsMostViewed()
                self.buildNewsList(response)

            } catch {
                self.showErrorService.value = "\(error.localizedDescription)"
                print("El error que ocurrio es este \(error)")
            }
        }
    }
    
    private func buildNewsList(_ response: [NewsMostViewedData]) {
        Task {
            self.model.newsList.removeAll()
            var updatedNewsList: [News] = []
            
            for element in response {
                let news = News(data: element)
                await news.getNewsImageInfo(media: element.media?.first)
                updatedNewsList.append(news)
            }
            
            self.model.newsList = updatedNewsList
            self.showNewsListObservable.value = true
        }
    }
}
