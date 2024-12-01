//
//  News.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import UIKit

class News {
    let id: Int
    let url: String
    let publishedDate: String
    let updated: String
    let section: String
    let subsection: String
    let byline: String
    let type: String
    let title: String
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
                self.image.small = image
            } else if element.format == "mediumThreeByTwo210" {
                self.image.normal = image
            } else if element.format == "mediumThreeByTwo440" {
                self.image.large = image
            }
        }
    }
}

class NewsImage {
    var type: String
    var caption: String
    var copyright: String
    var small: UIImage?
    var normal: UIImage?
    var large: UIImage?
    
    init(type: String = "",
         caption: String = "",
         copyright: String = "",
         small: UIImage? = UIImage(named: "img_noAvailable"),
         normal: UIImage? = UIImage(named: "img_noAvailable"),
         large: UIImage? = UIImage(named: "img_noAvailable")) {
        self.type = type
        self.caption = caption
        self.copyright = copyright
        self.small = small
        self.normal = normal
        self.large = large
    }
}
