//
//  ViewController.swift
//  News
//
//  Created by Philip on 07.03.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    var newsViewModel = MainViewModel()
    
    private lazy var mostViewedTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.register(NewsViewCell.self, forCellReuseIdentifier: NewsViewCell.cellIdentifier)
        
        return tableView
    }()
    
    private lazy var sourceMenu: UIMenu = {
        var actions = [
            UIAction(title: "Most viewed", image: UIImage(systemName: "flame"), handler: { _ in
                self.fetchData(endpoint: .viewed)
            }),
            
            UIAction(title: "Most emailed", image: UIImage(systemName: "envelope.badge"), handler: { _ in
                self.fetchData(endpoint: .emailed)
            }),
            
            UIAction(title: "Most shared", image: UIImage(systemName: "person.3"), handler: { _ in
                self.fetchData(endpoint: .shared)
            })
        ]
        
        return UIMenu(options:  [.singleSelection], children: actions)
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        fetchData(endpoint: .viewed)
        setupNavigationBar()
        setupSubviews()
        setupConstraints()
    }
    
    private func fetchData(endpoint: Endpoint) {
        newsViewModel.getData(endpoint) {
            DispatchQueue.main.async {
                UIView.transition(with: self.mostViewedTableView, duration: 0.5, options: .transitionCrossDissolve) {
                    self.mostViewedTableView.reloadData()
                }
            }
        }
    }
    
    private func setupNavigationBar() {
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), menu: sourceMenu)
    }
    
    private func setupSubviews() {
        view.addSubview(mostViewedTableView)
        mostViewedTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mostViewedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mostViewedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mostViewedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mostViewedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.newsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsViewCell.cellIdentifier, for: indexPath) as! NewsViewCell
       
        cell.titleLabel.text = newsViewModel.title[indexPath.row]
        cell.createdDateLabel.text = newsViewModel.date[indexPath.row]

        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
