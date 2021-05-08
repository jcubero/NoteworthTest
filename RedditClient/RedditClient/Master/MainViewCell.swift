//
//  MainViewCell.swift
//  RedditClient
//
//  Created by Joaquin Cubero on 5/8/21.
//

import Foundation

import UIKit
class RedditCell : UITableViewCell {
    var presenter: MainPresenter?
    var reddit : ChildData? {
        didSet {
            redditImage.imageFromServerURL(urlString: (reddit?.thumbnail)!)
            let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImage))
            redditImage.isUserInteractionEnabled = true
            redditImage.addGestureRecognizer(imageTap)
            
            authorNameLabel.text = reddit?.author
            if(reddit?.title.count ?? 0 < 100) {
                titleLabel.text = reddit?.title
            }
            else {
                titleLabel.text = "\(reddit?.title[0..<100] ?? "")..."
            }
            
            let ticks = reddit?.created ?? 0
            let seconds = TimeInterval(ticks) / 10_000_000
            let fmt = DateComponentsFormatter()
            fmt.allowedUnits = [.hour, .minute]
            timeAgoLabel.text = "\(fmt.string(from: seconds)!) hours ago"
            numOfCommentsLabel.text = "\(reddit?.numComments ?? 0) comments"
            dismissButton.addTarget(self, action: #selector(dismissItem), for: .touchUpInside)
            let labelTap = UITapGestureRecognizer(target: self, action: #selector(dismissItem))
            dismissLabel.isUserInteractionEnabled = true
            dismissLabel.addGestureRecognizer(labelTap)
        }
    }
     
    private let authorNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()

    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        return lbl
     }()
    
    private let timeAgoLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .right
        return lbl
     }()
    
    private let numOfCommentsLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .orange
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .right
        return lbl
     }()
    
    private let redditImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
     }()
    
    private let dismissButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "dismiss"), for: .normal)
        return button
    }()
    
    private let dismissLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .orange
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .right
        lbl.text = "Dismiss Post"
        return lbl
    }()
    
    @objc func dismissItem() {
        presenter?.dismissItem(with: reddit!)
    }
    
    @objc func openImage() {
        presenter?.openImage(with: reddit!)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
 
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        addSubviews()
        setConstrainsts()
    }
    
    func addSubviews() {
        addSubview(authorNameLabel)
        addSubview(timeAgoLabel)
        addSubview(redditImage)
        addSubview(titleLabel)
        addSubview(numOfCommentsLabel)
        addSubview(dismissButton)
        addSubview(dismissLabel)
    }
    
    func setConstrainsts() {
        authorNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)

        timeAgoLabel.anchor(top: authorNameLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 150, paddingBottom: 0, paddingRight: 20, width: frame.size.width / 2, height: 0, enableInsets: false)

        redditImage.anchor(top: topAnchor, left: authorNameLabel.leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        
        titleLabel.anchor(top: authorNameLabel.bottomAnchor, left: redditImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width - 50, height: 0, enableInsets: false)
        
        numOfCommentsLabel.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 50, paddingLeft: 10, paddingBottom: 5, paddingRight: 20, width: 500, height: 0, enableInsets: false)
        
        dismissButton.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 50, paddingLeft: 10, paddingBottom: 5, paddingRight: 20, width: 20, height: 20, enableInsets: false)
        
        dismissLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 50, paddingLeft: 25, paddingBottom: 5, paddingRight: 20, width: 100, height: 20, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
