//
//  NewsListCoordinator.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 28/11/24.
//

import UIKit

class NewsListCoordinator: Coordinator {

    func start() {
        let viewController = NewsListViewController()
        navigation?.pushViewController(viewController, animated: true)
    }
}
