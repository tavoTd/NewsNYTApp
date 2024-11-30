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
    
    let viewModel = NewsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buildUIComponents()
        self.buildConstraints()
        self.setupObservers()
    }
}

extension NewsListViewController {

    func setupObservers() {
        viewModel.showNewsListObservable.observe { value in
        }
    }
}

extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier, for: indexPath) as? NewsListTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
