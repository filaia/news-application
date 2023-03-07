//
//  ViewController.swift
//  News
//
//  Created by Philip on 07.03.2023.
//

import UIKit

private enum Constants: String {
    case cellIdentifier = "PopularCellId"
}

final class ViewController: UIViewController {
    
    var newsViewModel = NewsViewModel()
    
    private lazy var mostViewedTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier.rawValue)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        newsViewModel.getData {
            DispatchQueue.main.async {
                self.mostViewedTableView.reloadData()
            }
        }
          
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(mostViewedTableView)
    }
    
    private func setupConstraints() {
        mostViewedTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mostViewedTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mostViewedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mostViewedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mostViewedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.newsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier.rawValue, for: indexPath)
        cell.textLabel?.text = newsViewModel.title[indexPath.row].title
        return cell
    }
}
