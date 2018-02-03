//
//  LinksDataSource.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

struct Paging {
    static let defaultLimit = 25
    
    let after: String
    let limit: Int
    
    init(after: String, limit: Int = Paging.defaultLimit) {
        self.after = after
        self.limit = limit
    }
}

protocol LinksDataSource {
    
    func loadLinks(paging: Paging?,
                   success: @escaping (_ links: LinksList) -> (),
                   failure: @escaping (_ error: Error) -> ())
    
}
