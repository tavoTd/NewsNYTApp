//
//  NewsDetailViewController.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 01/12/24.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    lazy var navigationView: NavigationView = {
        let navigation = NavigationView()
        navigation.translatesAutoresizingMaskIntoConstraints = false

        return navigation
    }()
    
    lazy var labelNewsSection: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.backgroundColor = UIColor.orange
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var imageNews: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var labelNewsTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.adjustsFontSizeToFitWidth =  true
        label.minimumScaleFactor = 0.6
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var labelNewsAuthor: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.adjustsFontSizeToFitWidth =  true
        label.minimumScaleFactor = 0.6
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var labelNewsPublished: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var labelNewsLastUpdated: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var labelNewsAbstract: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 10.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let viewModel: NewsDetailViewModel
    
    init(viewModel: NewsDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buildUIComponents()
        self.buildConstraints()
        self.configNewsDetail()
    }
    
    func configNewsDetail() {
        let news = viewModel.newsDetail
        
        imageNews.image = news.image.large
        labelNewsTitle.text = news.title
        labelNewsSection.text = news.section
        labelNewsAuthor.text = news.byline
        labelNewsPublished.text = "Publised: \(news.publishedDate)"
        labelNewsLastUpdated.text = "Last update: \(news.updated)"
        labelNewsAbstract.text = news.abstract
    }
}
