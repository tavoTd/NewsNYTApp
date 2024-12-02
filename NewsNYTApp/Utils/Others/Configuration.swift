//
//  Configuration.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 01/12/24.
//

import Foundation

public class Configuration {
    
    public var baseURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    }
    
    public var NYTApiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "KEY_NYT_API") as? String ?? ""
    }
    
    public static let shared: Configuration = Configuration()
    
    private init() {}
}
