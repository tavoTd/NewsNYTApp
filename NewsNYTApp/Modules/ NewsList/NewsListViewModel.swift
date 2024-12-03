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
    
    func getNews(from index: Int) -> News {
        return model.newsList[index]
    }
    
    func getNewsMostViewed() {
        if NetworkMonitor.shared.isConnected {
            self.fetchNewsMostViewed()

        } else {
            self.fetchNewsMostViewedBackup()
        }
    }
    
    private func fetchNewsMostViewedBackup(auxMessage: String = ErrorMessage.withoutInternetConnection) {
        self.model.fetchNewsListBackup()
        
        if self.model.newsList.isEmpty {
            self.showErrorService.value = auxMessage
            
        } else {
            self.showNewsListObservable.value = true
        }
    }
    
    private func fetchNewsMostViewed() {
        Task {
            do {
                let service = NewsMostViewedService()
                let response = try await service.fetchNewsMostViewed(in: .day)
                self.buildNewsList(response)

            } catch {
                self.validateError(error)
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
    
    private func validateError(_ error: Error) {
        if let serviceError = error as? ServiceError {
            switch serviceError {
            case .networkUnavailable:
                self.fetchNewsMostViewedBackup()
                
            case .serverError(let statusCode):
                if statusCode == 401 {
                    self.showErrorService.value = ErrorMessage.sessionExpired
                } else if statusCode == 429 {
                    self.fetchNewsMostViewedBackup(auxMessage: ErrorMessage.general)
                } else {
                    self.showErrorService.value = ErrorMessage.general
                }

            case .unauthorizedRequest:
                self.showErrorService.value = ErrorMessage.sessionExpired

            case .limitRequestReached:
                self.fetchNewsMostViewedBackup(auxMessage: ErrorMessage.general)

            default:
                self.showErrorService.value = ErrorMessage.general
            }

            return
        }
        
        if let urlError = error as? URLError,
           urlError.code == .notConnectedToInternet {
            self.fetchNewsMostViewedBackup()
            
            return
        }
        
        self.showErrorService.value = ErrorMessage.general
    }
}
