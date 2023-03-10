//
//  NewsViewModel.swift
//  News
//
//  Created by Philip on 07.03.2023.
//

import Foundation

final class NewsViewModel {
    
    var newsCount: Int {
        news?.results.count ?? 0
    }
    
   var dates: [String] {
       news?.results.map { Date.getFormatDate($0.publishedDate) } ?? []
   }
    
    var titles: [String] {
        news?.results.map { $0.title } ?? []
    }
    
    var newsImages: [String] {
        news?.results.compactMap { $0.media.first?.mediaMetadata.first?.url } ?? []
    }
      
    private var news: News?

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
