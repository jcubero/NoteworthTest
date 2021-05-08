//
//  MainInteractor.swift
//  RedditClient
//
//  Created by Joaquin Cubero on 5/8/21.
//

import Foundation

protocol MainInteractor {
    var presenter: MainPresenter? { get set }
    func getReddits(after: String?)
}

class RedditInteractor: MainInteractor {
    
    func getReddits(after: String?) {

        guard let url = URL(string: "https://www.reddit.com/r/all/top/.json?t=all&limit=50&after=\(after ?? "")") else { return }
        
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchReddits(with: .failure(FetchError.failed))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let entities = try decoder.decode(Reddit.self, from: data)
                self?.presenter?.interactorDidFetchReddits(with: .success(entities))
            }
            catch {
                self?.presenter?.interactorDidFetchReddits(with: .failure(error))
            }
        }
        task.resume()
    }
    
    var presenter: MainPresenter?
    
    
}
