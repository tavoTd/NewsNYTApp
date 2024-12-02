//
//  UIImage+Extension.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import UIKit

extension UIImage {

    public static func getDataImage(from url: String) async -> Data? {
        guard let bundleURL = URL(string: url) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: bundleURL)
            return data

        } catch {
            return nil
        }
    }
}
