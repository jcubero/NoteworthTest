//
//  MainPresenter.swift
//  RedditClient
//
//  Created by Joaquin Cubero on 5/8/21.
//

import Foundation
import UIKit

enum FetchError : Error{
    case failed
}

protocol MainPresenter {
    var router: MainRouter? { get set }
    var interactor: MainInteractor? { get set }
    var view: MainView? { get set }
    func interactorDidFetchReddits(with result: Result<Reddit, Error>)
    func dismissItem(with item: ChildData)
    func openImage(with item: ChildData)
    func openDetail(with item: ChildData)
    func loadMore(with after: String)
}
class RedditPresenter: MainPresenter {
    var view: MainView?

    
    func loadMore(with after: String) {
        interactor?.getReddits(after: after)
    }

    func openImage(with item: ChildData) {
        if let url = URL(string: (item.thumbnail)!) {
            UIApplication.shared.open(url)
        }
    }

    var interactor: MainInteractor? {
        didSet {
            interactor?.getReddits(after: nil)
        }
    }
    
    func openDetail(with item: ChildData) {
        let redditDetailRouter = RedditDetailRouter.start()
        let mainVC = view as! RedditViewController
        let detailVC = (redditDetailRouter.entry)!
        mainVC.present(detailVC, animated: true, completion: nil)
        detailVC.update(with: item)
    }

    func interactorDidFetchReddits(with result: Result<Reddit, Error>) {
        switch result {
        case .success(let reddits):
            view?.update(with: reddits)
        case .failure:
            view?.update(with: "Error")
        }
    }
    
    func dismissItem(with item: ChildData) {
        view?.dismiss(with: item)
    }
    
    var router: MainRouter?
    

}
