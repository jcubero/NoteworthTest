//
//  DetailView.swift
//  RedditClient
//
//  Created by Joaquin Cubero on 5/8/21.
//

import Foundation
import UIKit

protocol DetailView{
    var presenter: DetailPresenter? { get set}
    func update(with reddit: ChildData)
}

class RedditDetailViewController : UIViewController, DetailView {
    var presenter: DetailPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(self.titleLabel)
        view.addSubview(redditImage)
        view.addSubview(contentLabel)
        titleLabel.textAlignment = .center
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: view.frame.size.width , height: 0, enableInsets: false)
        redditImage.anchor(top: titleLabel.topAnchor, left: redditImage.leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: view.frame.size.width , height: 0, enableInsets: false)
        contentLabel.anchor(top: redditImage.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 150, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: view.frame.size.width , height: 0, enableInsets: false)
    }
    
    func update(with reddit: ChildData) {
        titleLabel.text = reddit.author
        redditImage.imageFromServerURL(urlString: (reddit.thumbnail)!)
        contentLabel.text = reddit.title
    }
    private let redditImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
     }()
    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.textAlignment = .left
        lbl.sizeToFit()
        return lbl
     }()
    private let contentLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        return lbl
     }()
}
