//
//  NetworkManager.swift
//  News
//
//  Created by Philip on 07.03.2023.
//

import Foundation

final class NetworkManager {
    
    static var shared = NetworkManager()
    
    private init() { }
    
    private var request = URLRequest(url: URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=tTdTQtektAzD4l2MeSMJx5g0YeUDsnTW")!)
    
    func makeRequest(completion: @escaping (Result<News, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure("Error" as! Error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let news = try decoder.decode(News.self, from: data)
                completion(.success(news))
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
}
