//
//  NewsListViewModel.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import UIKit

class NewsListViewModel {
    
    private let model: NewsListModel
    var showNewsListObservable: Observable<Bool> = Observable(initialValue: false)
    var showErrorService: Observable<String> = Observable(initialValue: "")
    
    var newsListSize: Int {
        return model.newsList.count
    }
    
    init(model: NewsListModel) {
        self.model = model
    }
    
    func fetchNewsMostViewed() {
        Task {
            do {
                let service = NewsMostViewedService()
                let response = try await service.fetchNewsMostViewed(in: .day)
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
            self.model.saveNewsListBackup()
            self.showNewsListObservable.value = true
        }
    }
    
    func getNews(from index: Int) -> News {
        return model.newsList[index]
    }
}
