//
//  LinksViewModelProtocol.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

struct LinkItem {
    let title: String
    let author: String
    let creationDate: Date
    let commentsCount: Int
    let thumbnailURL: URL?
    let sourceImageURL: URL?
}

protocol LinksViewModelProtocol {
    
    var isLoading: Dynamic<Bool> { get }
    var items: Dynamic<[LinkItem]> { get }
    
    func reloadItems()
    func loadMoreItems()
    
}
