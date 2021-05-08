//
//  DetailRouter.swift
//  RedditClient
//
//  Created by Joaquin Cubero on 5/8/21.
//

import Foundation
import UIKit

typealias EntryDetailPoint = DetailView & UIViewController

protocol DetailRouter {
    var entry: EntryDetailPoint? { get }
    static func start() -> DetailRouter
}

class RedditDetailRouter: DetailRouter{

    var entry: EntryDetailPoint?
    
    static func start() -> DetailRouter {
        let router = RedditDetailRouter()
        var view: DetailView = RedditDetailViewController()
        var presenter: DetailPresenter = RedditDetailPresenter()
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        
        router.entry = view as? EntryDetailPoint
        
        return router
    }
}
