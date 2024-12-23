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
            
            if element.format == ImageFormat.standar.rawValue {
                self.image.smallData = imageData
                
            } else if element.format == ImageFormat.medium210.rawValue {
                self.image.normalData = imageData
                
            } else if element.format == ImageFormat.medium440.rawValue {
                self.image.largeData = imageData
                
            }
        }
    }
}

class NewsImage {
    var type: String
    var caption: String
    var copyright: String
    var smallData: Data?
    var normalData: Data?
    var largeData: Data?

    var small: UIImage? {
        return createImage(data: self.smallData)
    }
    
    var normal: UIImage? {
        return createImage(data: self.normalData)
    }
    
    var large: UIImage? {
        return createImage(data: self.largeData)
    }
    
    init(type: String = "",
         caption: String = "",
         copyright: String = "",
         smallData: Data? = nil,
         normalData: Data? = nil,
         largeData: Data? = nil) {

        self.type = type
        self.caption = caption
        self.copyright = copyright
        self.smallData = smallData
        self.normalData = normalData
        self.largeData = largeData
    }
    
    private func createImage(data: Data?) -> UIImage? {
        guard let imageData = data else {
            return UIImage(named: "img_noAvailable")
        }
        
        return UIImage(data: imageData)
    }
}
