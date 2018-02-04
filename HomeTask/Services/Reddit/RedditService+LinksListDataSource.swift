//
//  RedditService+LinksListDataSource.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

extension RedditService: LinksDataSource {
    
    func loadLinks(paging: Paging?,
                   success: ((LinksList) -> ())? = nil,
                   failure: ((Error) -> ())? = nil)
    {
        loadTopLinks(paging: paging, success: success, failure: failure)
    }
    
}
