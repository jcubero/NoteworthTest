//
//  MainEntity.swift
//  RedditClient
//
//  Created by Joaquin Cubero on 5/8/21.
//

import Foundation

struct Reddit : Decodable {
    let kind: String
    var data: ListingData
}

struct ListingData: Decodable {
    var children: [Child]
    let dist: Int
    let after: String
}

struct ChildData : Decodable {
    let id: String
    let title: String
    let author: String
    let thumbnail: String?
    let created: Int
    let numComments: Int
}
struct Child: Decodable {
    let data: ChildData
    let kind: String?
    
}
