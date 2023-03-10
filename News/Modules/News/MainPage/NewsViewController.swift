//
//  NewsViewController.swift
//  News
//
//  Created by Philip on 07.03.2023.
//

import UIKit

final class NewsViewController: UIViewController {
    
    var newsViewModel = NewsViewModel()
    
    private lazy var newsTableView: UITableView = {
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
            UIAction(title: "Most viewed", image: UIImage(systemName: Icon.mostViewed.rawValue), handler: { _ in
                self.fetchData(endpoint: .viewed)
            }),
            
            UIAction(title: "Most emailed", image: UIImage(systemName: Icon.mostEmailed.rawValue), handler: { _ in
                self.fetchData(endpoint: .emailed)
            }),
            
            UIAction(title: "Most shared", image: UIImage(systemName: Icon.mostShared.rawValue), handler: { _ in
                self.fetchData(endpoint: .shared)
            })
        ]
        
        return UIMenu(options:  [.singleSelection], children: actions)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData(endpoint: .viewed)
        setupNavigationBar()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: Table view
    
    private func fetchData(endpoint: Endpoint) {
        newsViewModel.getData(endpoint) {
            DispatchQueue.main.async {
                self.updateTableView()
            }
        }
    }
    
    private func updateTableView() {
        UIView.transition(with: newsTableView, duration: 0.5, options: .showHideTransitionViews) {
            self.newsTableView.reloadData()
        } completion: { _ in
            self.scrollToTop()
        }
    }
    
    private func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        newsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    // MARK: Cell
    
    private func handleMarkAsFavourite() {
        print("Marked")
    }
    
    // MARK: Navigation bar
        
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Icon.more.rawValue), menu: sourceMenu)
    }
    
    // MARK: Constraints
    
    private func setupSubviews() {
        view.addSubview(newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.newsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsViewCell.cellIdentifier, for: indexPath) as? NewsViewCell else { return UITableViewCell() }
        cell.configure(with: newsViewModel, at: indexPath.row)

        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // TODO: check if I can add twice or more
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favouriteAction = UIContextualAction(style: .normal, title: "Favourite") { [weak self] (action, view, completionHandler) in
            self?.handleMarkAsFavourite()
            completionHandler(true)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [favouriteAction])
        
        favouriteAction.backgroundColor = .systemBlue
        favouriteAction.image = UIImage(systemName: Icon.favourite.rawValue)
        
        return swipeActions
    }
}
