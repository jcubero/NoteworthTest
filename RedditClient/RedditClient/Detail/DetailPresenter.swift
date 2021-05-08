//
//  DetailPresenter.swift
//  RedditClient
//
//  Created by Joaquin Cubero on 5/8/21.
//

import Foundation
protocol DetailPresenter {
    var router: DetailRouter? { get set }
    var view: DetailView? { get set }
    func displayData(with result:ChildData)
}

class RedditDetailPresenter: DetailPresenter {

    var view: DetailView?
    var router: DetailRouter?
    
    func displayData(with result: ChildData) {
        view?.update(with: result)
    }
}
