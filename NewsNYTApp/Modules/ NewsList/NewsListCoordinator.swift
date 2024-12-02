//
//  NewsListCoordinator.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 28/11/24.
//

import UIKit

class NewsListCoordinator: Coordinator {

    func start() {
        let model = NewsListModel()
        let viewModel = NewsListViewModel(model: model)
        let viewController = NewsListViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        navigation?.pushViewController(viewController, animated: true)
    }
    
    func showDetail(of news: News) {
        let model = NewsDetailModel(news: news)
        let viewModel = NewsDetailViewModel(model: model)
        let viewController = NewsDetailViewController(viewModel: viewModel)
        
        navigation?.pushViewController(viewController, animated: true)
    }
}
