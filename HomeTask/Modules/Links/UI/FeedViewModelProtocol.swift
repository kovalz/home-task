//
//  FeedViewModelProtocol.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

struct FeedItem {
    let title: String
    let author: String
    let creationDate: Date
    let commentsCount: Int
    let thumbnailURL: URL?
    let sourceImageURL: URL?
}

protocol FeedViewModelProtocol {
    
    var isLoading: Dynamic<Bool> { get }
    var items: Dynamic<[FeedItem]> { get }
    
    func reloadItems()
    func loadMoreItems()
    
}
