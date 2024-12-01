//
//  NewsDetailViewController+UI.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 01/12/24.
//

import UIKit

extension NewsDetailViewController {
    
    func buildUIComponents() {
        self.view.backgroundColor = UIColor.white
        
        self.navigationView.configComponents(navigation: self.navigationController,
                                             title: "The News Most Viewed")
        
        stackView.addArrangedSubview(labelNewsTitle)
        stackView.addArrangedSubview(labelNewsAuthor)
        stackView.addArrangedSubview(labelNewsPublished)
        stackView.addArrangedSubview(labelNewsLastUpdated)
        
        self.view.addSubview(navigationView)
        self.view.addSubview(imageNews)
        self.view.addSubview(labelNewsSection)
        self.view.addSubview(stackView)
        self.view.addSubview(labelNewsAbstract)
    }
    
    func buildConstraints() {
    
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: self.view.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            imageNews.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            imageNews.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageNews.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
            imageNews.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            labelNewsSection.trailingAnchor.constraint(equalTo: imageNews.trailingAnchor, constant: -10.0),
            labelNewsSection.heightAnchor.constraint(equalToConstant: 30.0),
            labelNewsSection.widthAnchor.constraint(greaterThanOrEqualToConstant: 50.0),
            labelNewsSection.bottomAnchor.constraint(equalTo: imageNews.bottomAnchor, constant: -10.0),
            
            stackView.topAnchor.constraint(equalTo: imageNews.bottomAnchor, constant: 20.0),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            
            labelNewsAbstract.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20.0),
            labelNewsAbstract.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            labelNewsAbstract.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
        ])
    }
}
