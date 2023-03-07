//
//  NewsViewModel.swift
//  News
//
//  Created by Philip on 07.03.2023.
//

import Foundation

class MainViewModel {

    var news: News?
    
    var newsCount: Int {
        news?.results.count ?? 0
    }
    
    var title: [String] {
        news?.results.map { $0.title } ?? []
    }
    
    var date: [String] {
        news?.results.map { $0.publishedDate } ?? []
    }
    
    // TODO: title for navbar that changes depending on endpoint
        
    // TODO: weak self?
    func getData(_ endpoint: Endpoint, completion: @escaping () -> ()) {
        NetworkService.shared.fetch(endpoint: endpoint) { (result: Result<News, Error>) in
            switch result {
            case .success(let news):
                self.news = news
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
}
