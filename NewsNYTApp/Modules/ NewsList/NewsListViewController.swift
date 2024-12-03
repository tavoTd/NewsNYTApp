//
//  NewsListViewController.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 28/11/24.
//

import UIKit

class NewsListViewController: UIViewController {
    
    lazy var navigationView: NavigationView = {
        let navigation = NavigationView()
        navigation.translatesAutoresizingMaskIntoConstraints = false

        return navigation
    }()
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: NewsListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightCyan
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    lazy var imageErrorService: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "img_errorService")
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    lazy var labelErrorService: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    lazy var buttonReTry: UIButton = {
        let button = UIButton()
        button.setTitle("Reintentar", for: .normal)
        button.backgroundColor = UIColor.orange
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(getNewsList), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    var refreshControl = UIRefreshControl()
    
    private let viewModel: NewsListViewModel
    var coordinator: NewsListCoordinator?
    
    init(viewModel: NewsListViewModel) {
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
        self.setupObservers()
        self.getNewsList()
    }
    
    @objc func refreshNewsList() {
        self.refreshControl.endRefreshing()
        self.getNewsList()
    }
    
    @objc func getNewsList() {
        containerView.isHidden = true
        Loader.shared.show(on: self)
        viewModel.getNewsMostViewed()
    }
}

extension NewsListViewController {

    func setupObservers() {
        viewModel.showNewsListObservable.observe { value in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self else { return }
                Loader.shared.dismiss()
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
        
        viewModel.showErrorService.observe { value in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self else { return }
                Loader.shared.dismiss()
                self.labelErrorService.text = value
                self.tableView.isHidden = true
                self.containerView.isHidden = false
            }
        }
    }
}

extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsListSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier, for: indexPath) as? NewsListTableViewCell else {
            return UITableViewCell()
        }
        
        let news = viewModel.getNews(from: indexPath.row)
        cell.configure(with: news)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.getNews(from: indexPath.row)
        coordinator?.showDetail(of: news)
    }
}
