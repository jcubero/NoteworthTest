//
//  MainRouter.swift
//  RedditClient
//
//  Created by Joaquin Cubero on 5/8/21.
//

import Foundation
import UIKit

typealias EntryPoint = MainView & UIViewController
protocol MainRouter {
    var entry: EntryPoint? { get }
    static func start() -> MainRouter
}

class RedditRouter: MainRouter{

    var entry: EntryPoint?
    
    static func start() -> MainRouter {
        let router = RedditRouter()
        var view: MainView = RedditViewController()
        var presenter: MainPresenter = RedditPresenter()
        var interactor: MainInteractor = RedditInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
