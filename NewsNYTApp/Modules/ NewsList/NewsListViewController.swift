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
    
    func getNewsList() {
        Loader.shared.show(on: self)
        viewModel.fetchNewsMostViewed()
    }
}

extension NewsListViewController {

    func setupObservers() {
        viewModel.showNewsListObservable.observe { value in
            Loader.shared.dismiss()
            self.tableView.reloadData()
        }
        
        viewModel.showErrorService.observe { value in
            Loader.shared.dismiss()
            self.tableView.reloadData()
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
        coordinator?.showNewsDetail(of: news)
    }
}