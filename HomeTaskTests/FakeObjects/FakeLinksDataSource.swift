//
//  FakeLinksDataSource.swift
//  HomeTaskTests
//
//  Created by Zhenya Koval on 2/5/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

class FakeLinksDataSource: LinksDataSource {
    
    var isLoading = Dynamic(false)
    
    private (set) var paging: Paging?
    private (set) var success: ((LinksList) -> ())?
    private (set) var failure: ((Error) -> ())?

    func loadLinks(paging: Paging?, success: ((LinksList) -> ())?, failure: ((Error) -> ())?) {
        self.paging = paging
        self.success = success
        self.failure = failure
    }
    
}

