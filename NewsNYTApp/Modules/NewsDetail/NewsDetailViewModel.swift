//
//  NewsDetailViewModel.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 01/12/24.
//

import Foundation

class NewsDetailViewModel {
    
    let model: NewsDetailModel
    
    var newsDetail: News {
        return self.model.news
    }
    
    init(model: NewsDetailModel) {
        self.model = model
    }
}
