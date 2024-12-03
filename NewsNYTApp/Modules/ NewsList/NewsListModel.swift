//
//  NewsListModel.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import Foundation

class NewsListModel {
    var newsList: [News] = []
    var isConnected: Bool = false
    
    public init() {
        self.checkInternetConnection()
    }
    
    func saveNewsListBackup() {

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            RealmManager.shared.delete(object: NewsRealmModel.self)

            for news in newsList {
                let newsRealmModel = NewsRealmModel()
                newsRealmModel.fillInfo(with: news)
                RealmManager.shared.insert(object: newsRealmModel)
            }
        }
    }
    
    func fetchNewsListBackup() {
        guard let newsArray = RealmManager.shared.getAll(objects: NewsRealmModel.self) else {
            print("No se obtuvo la información de realmSwift")
            return
        }
        
        var updatedNewsList: [News] = []
        for element in newsArray {
            let news = News(data: element)
            updatedNewsList.append(news)
        }
        
        self.newsList.removeAll()
        self.newsList = updatedNewsList
    }

    private func checkInternetConnection() {
        NetworkMonitor.shared.onStatusChange = { [weak self] isConnected in
            guard let self else { return }
            self.isConnected = isConnected
        }
    }
}
