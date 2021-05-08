//
//  MainView.swift
//  RedditClient
//
//  Created by Joaquin Cubero on 5/8/21.
//

import Foundation
import UIKit
protocol MainView{
    var presenter: MainPresenter? { get set}
    func update(with reddits: Reddit)
    func updateMoreItems(with reddits: Reddit)
    func update(with error: String)
    func dismiss(with item: ChildData)
}

class RedditViewController: UIViewController, MainView, UITableViewDelegate, UITableViewDataSource{

    var reddit: Reddit?
    var presenter: MainPresenter?

    func update(with reddit: Reddit) {
        print("success")
        DispatchQueue.main.async {
            self.reddit = reddit
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    func updateMoreItems(with reddits: Reddit) {
        DispatchQueue.main.async {
            self.reddit?.data.children.append(contentsOf: reddits.data.children)
            self.tableView.reloadData()
        }
    }
    func update(with error: String) {
        print(error)
    }
    
    func dismiss(with item: ChildData) {
        if let index = reddit?.data.children.firstIndex(where: { $0.data.id == item.id }) {
            reddit?.data.children.remove(at: index)
        }
        tableView.reloadData()
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(RedditCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RedditCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // Table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    // table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reddit != nil ? reddit!.data.children.count : 0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textAlignment = .center
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
       return "Reddit Posts"
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == reddit!.data.children.count - 1 {
            presenter?.loadMore(with: reddit?.data.after ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.openDetail(with: reddit!.data.children[indexPath.row].data)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RedditCell
        cell.presenter = presenter
        let currentItem = reddit!.data.children[indexPath.row].data
        cell.reddit = currentItem
        
        return cell
    }
}
