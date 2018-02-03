//
//  LinksList.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

struct LinksList {
    
    struct Paging {
        let after: String
    }

    let links: [Link]
    let paging: Paging
    
}
