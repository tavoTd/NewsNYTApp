//
//  NewsListViewController+UI.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 28/11/24.
//

import UIKit

extension NewsListViewController {
    
    func buildUIComponents() {
        self.view.backgroundColor = UIColor.lightCyan
        self.tableView.backgroundColor = UIColor.lightCyan
        
        self.navigationView.configComponents(navigation: self.navigationController,
                                             title: "The Most Viewed",
                                             iconLeftButton: nil)
        
        self.view.addSubview(navigationView)
        self.view.addSubview(tableView)
    }
    
    func buildConstraints() {
    
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: self.view.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: self.navigationView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
