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
                                             title: "The News Most Viewed",
                                             iconLeftButton: nil)
        self.setupRefreshControl()
        
        self.containerView.addSubview(imageErrorService)
        self.containerView.addSubview(labelErrorService)
        self.containerView.addSubview(buttonReTry)
        
        self.view.addSubview(navigationView)
        self.view.addSubview(containerView)
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
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            
            imageErrorService.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            imageErrorService.heightAnchor.constraint(equalToConstant: 150.0),
            imageErrorService.widthAnchor.constraint(equalToConstant: 150.0),
            imageErrorService.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageErrorService.bottomAnchor.constraint(equalTo: labelErrorService.topAnchor, constant: -10.0),
            
            labelErrorService.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            labelErrorService.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            labelErrorService.bottomAnchor.constraint(equalTo: buttonReTry.topAnchor, constant: -30.0),
            
            buttonReTry.widthAnchor.constraint(equalToConstant: 100.0),
            buttonReTry.heightAnchor.constraint(equalToConstant: 40.0),
            buttonReTry.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonReTry.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshNewsList), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}
