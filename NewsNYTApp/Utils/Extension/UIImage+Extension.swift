//
//  UIImage+Extension.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import UIKit

extension UIImage {
    public static func getImage(from url: String) async -> UIImage? {
        guard let bundleURL = URL(string: url) else {
            return UIImage(named: "img_noAvailable")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: bundleURL)
            return UIImage(data: data)

        } catch {
            return UIImage(named: "img_noAvailable")
        }
    }
}
