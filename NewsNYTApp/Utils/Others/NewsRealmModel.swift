//
//  NewsRealmModel.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 01/12/24.
//

import Foundation
import RealmSwift

class NewsRealmModel: Object {
    @Persisted var id: Int
    @Persisted var url: String
    @Persisted var publishedDate: String
    @Persisted var updated: String
    @Persisted var section: String
    @Persisted var subsection: String
    @Persisted var byline: String
    @Persisted var type: String
    @Persisted var title: String
    @Persisted var abstract: String
    @Persisted var imageType: String
    @Persisted var imageCaption: String
    @Persisted var imageCopyright: String
    @Persisted var dataImageSmall: Data?
    @Persisted var dataImageNormal: Data?
    @Persisted var dataImageLarge: Data?
    
    func fillInfo(with news: News) {
        self.id = news.id
        self.url = news.url
        self.publishedDate = news.publishedDate
        self.updated = news.updated
        self.section =  news.section
        self.subsection = news.subsection
        self.byline = news.byline
        self.type = news.type
        self.title = news.title
        self.abstract = news.abstract
        self.imageType = news.image.type
        self.imageCaption = news.image.caption
        self.imageCopyright = news.image.copyright
        self.dataImageSmall = news.image.smallData
        self.dataImageNormal = news.image.normalData
        self.dataImageLarge = news.image.largeData
    }
}
