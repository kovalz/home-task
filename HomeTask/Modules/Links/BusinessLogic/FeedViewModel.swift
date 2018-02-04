//
//  FeedViewModel.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

class FeedViewModel {
    
    // MARK: - Public properties -
    
    let dataSource: LinksDataSource
    let userNotificationCenter: UserNotificationCenter
    
    // MARK: FeedViewModelProtocol

    var isLoading: Dynamic<Bool> {
        return dataSource.isLoading
    }

    let items = Dynamic([FeedItem]())

    // MARK: - Private properties -
    
    var paging = Paging()
    
    // MARK: - Lifecycle -
    
    init(dataSource: LinksDataSource, userNotificationCenter: UserNotificationCenter) {
        self.dataSource = dataSource
        self.userNotificationCenter = userNotificationCenter
    }
    
}

// MARK: - FeedViewModelProtocol -

extension FeedViewModel: FeedViewModelProtocol {
    
    func reloadItems() {
        let success: ((LinksList) -> ()) = { [weak self] linksList in
            self?.paging = Paging(after: linksList.paging.after)
            self?.items.value = linksList.links.map {
                return FeedItem(link: $0)
            }
        }
        
        let failure: ((Error) -> ()) = { [weak self] error in
            self?.userNotificationCenter.notify(about: error)
        }
        
        paging = Paging()
        dataSource.loadLinks(paging: paging, success: success, failure: failure)
    }
    
    func loadMoreItems() {
        let success: ((LinksList) -> ()) = { [weak self] linksList in
            guard let strongSelf = self else {
                return
            }
            
            let oldItems = strongSelf.items.value
            let newItems = linksList.links.map {
                return FeedItem(link: $0)
            }
            
            strongSelf.paging = Paging(after: linksList.paging.after)
            strongSelf.items.value = oldItems + newItems
        }
        
        dataSource.loadLinks(paging: paging, success: success, failure: nil)
    }
    
}

// MARK: - FeedItem -

extension FeedItem {
    
    init(link: Link) {
        title = link.title
        author = link.author
        creationDate = link.creationDate
        commentsCount = link.commentsCount
        
        if let thumbnailURL = link.thumbnailURL, thumbnailURL.isValidImageURL {
            self.thumbnailURL = thumbnailURL
        } else {
            thumbnailURL = nil
        }
        
        if let previewSourceURL = link.previewSourceURL, previewSourceURL.isValidImageURL {
            sourceImageURL = previewSourceURL
        } else {
            sourceImageURL = nil
        }
    }
    
}
