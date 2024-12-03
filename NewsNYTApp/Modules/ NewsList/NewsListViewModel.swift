//
//  NewsListViewModel.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import UIKit
import Network

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
    
    func getNews(from index: Int) -> News {
        return model.newsList[index]
    }
    
    func getNewsMostViewed() {
        if self.model.isConnected {
            self.fetchNewsMostViewed()

        } else {
            self.fetchNewsMostViewedBackup()
        }
    }
    
    private func fetchNewsMostViewed() {
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
            var updatedNewsList: [News] = []
            
            for element in response {
                let news = News(data: element)
                await news.getNewsImageInfo(media: element.media?.first)
                updatedNewsList.append(news)
            }
            
            self.model.newsList.removeAll()
            self.model.newsList = updatedNewsList
            self.model.saveNewsListBackup()
            self.showNewsListObservable.value = true
        }
    }
    
    private func fetchNewsMostViewedBackup() {
        self.model.fetchNewsListBackup()
        
        if self.model.newsList.isEmpty {
            self.showErrorService.value = "Error de conexion a internet"
            
        } else {
            self.showNewsListObservable.value = true
        }
    }
}
