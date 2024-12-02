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
    
    init(data: NewsRealmModel) {
        let imageInfo = NewsImage()
        imageInfo.type = data.imageType
        imageInfo.caption = data.imageCaption
        imageInfo.copyright = data.imageCopyright
        imageInfo.smallData = data.dataImageSmall
        imageInfo.normalData = data.dataImageNormal
        imageInfo.largeData = data.dataImageLarge
        
        self.id = data.id
        self.url = data.url
        self.publishedDate = data.publishedDate
        self.updated = data.updated
        self.section = data.section
        self.subsection = data.subsection
        self.byline = data.byline
        self.type = data.type
        self.title = data.title
        self.abstract = data.abstract
        self.image = imageInfo
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
            let data = await UIImage.getDataImage(from: element.url ?? "")
            
            guard let imageData = data else {
                return
            }
            
            if element.format == "Standard Thumbnail" {
                self.image.smallData = imageData
                self.image.smallSize = UIImage(data: imageData)
                
            } else if element.format == "mediumThreeByTwo210" {
                self.image.normalData = imageData
                self.image.normalSize = UIImage(data: imageData)
                
            } else if element.format == "mediumThreeByTwo440" {
                self.image.largeData = imageData
                self.image.largeSize = UIImage(data: imageData)
                
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
    var smallData: Data?
    var normalData: Data?
    var largeData: Data?
    
    init(type: String = "",
         caption: String = "",
         copyright: String = "",
         smallSize: UIImage? = UIImage(named: "img_noAvailable"),
         normalSize: UIImage? = UIImage(named: "img_noAvailable"),
         largeSize: UIImage? = UIImage(named: "img_noAvailable"),
         smallData: Data? = nil,
         normalData: Data? = nil,
         largeData: Data? = nil) {

        self.type = type
        self.caption = caption
        self.copyright = copyright
        self.smallSize = smallSize
        self.smallData = smallData
        self.normalSize = normalSize
        self.normalData = normalData
        self.largeSize = largeSize
        self.largeData = largeData
    }
}
