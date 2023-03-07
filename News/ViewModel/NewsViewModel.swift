//
//  NewsViewModel.swift
//  News
//
//  Created by Philip on 07.03.2023.
//

import Foundation

class NewsViewModel {

    var news: News?
    
    var newsCount: Int {
        news?.results.count ?? 0
    }
    
    var title: [Results] {
        news?.results ?? []
    }
        
    func getData( completion: @escaping () -> ()) {
        NetworkManager.shared.makeRequest { result in
            switch result {
            case .success(let data):
                self.news = data
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
       
}
