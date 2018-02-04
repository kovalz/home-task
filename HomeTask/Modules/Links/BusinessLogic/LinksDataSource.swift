//
//  LinksDataSource.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

struct Paging {    
    let after: String?
    let limit: Int?
    
    init(after: String? = nil, limit: Int? = nil) {
        self.after = after
        self.limit = limit
    }
}

protocol LinksDataSource {
    
    var isLoading: Dynamic<Bool> { get }

    func loadLinks(paging: Paging?,
                   success: @escaping (_ links: LinksList) -> (),
                   failure: @escaping (_ error: Error) -> ())
    
}
