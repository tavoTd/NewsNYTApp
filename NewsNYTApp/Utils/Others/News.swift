//
//  News.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import UIKit

class News {
    var id: Int
    var url: String
    var publishedDate: String
    var updated: String
    var section: String
    var subsection: String
    var byline: String
    var type: String
    var title: String
    var abstract: String
    var image: NewsImage
    
    init(data: NewsMostViewedData) {
        self.id = data.id ?? 0
        self.url = data.url ?? ""
        self.publishedDate = data.publishedDate ?? ""
        self.updated = data.updated ?? ""
        self.section = data.section ?? ""
        self.subsection = data.subsection ?? ""
        self.byline = data.byline ?? ""
        self.type = data.type ?? ""
        self.title = data.title ?? ""
        self.abstract = data.abstract ?? ""
        self.image = NewsImage()
    }
    
    func getNewsImageInfo(media: Media?) async {
        guard let media = media else {
            return
        }
        
        self.image.caption = media.caption ?? ""
        self.image.type = media.type ?? ""
        self.image.copyright = media.copyright ?? ""
        
        guard let metaData = media.mediaMetadata else {
            return
        }
        
        for element in metaData {
            let image = await UIImage.getImage(from: element.url ?? "")
            
            if element.format == "Standard Thumbnail" {
                self.image.smallSize = image
            } else if element.format == "mediumThreeByTwo210" {
                self.image.normalSize = image
            } else if element.format == "mediumThreeByTwo440" {
                self.image.largeSize = image
            }
        }
    }
}

class NewsImage {
    var type: String
    var caption: String
    var copyright: String
    var smallSize: UIImage?
    var normalSize: UIImage?
    var largeSize: UIImage?
    
    init(type: String = "",
         caption: String = "",
         copyright: String = "",
         smallSize: UIImage? = UIImage(named: "img_noAvailable"),
         normalSize: UIImage? = UIImage(named: "img_noAvailable"),
         largeSize: UIImage? = UIImage(named: "img_noAvailable")) {
        self.type = type
        self.caption = caption
        self.copyright = copyright
        self.smallSize = smallSize
        self.normalSize = normalSize
        self.largeSize = largeSize
    }
}
