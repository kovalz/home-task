//
//  FakeLinks.swift
//  HomeTaskTests
//
//  Created by Zhenya Koval on 2/5/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

class FakeLinks {
    
    class func createSingleLinkList(title: String = "",
                                    after: String = "") -> LinksList
    {
        let link = Link(title: title,
                        author: "",
                        creationDate: Date(),
                        commentsCount: 0,
                        thumbnailURL: nil,
                        previewSourceURL: nil)
        
        let paging = LinksList.Paging(after: after)
        
        return LinksList(links: [link], paging: paging)
    }
    
}
