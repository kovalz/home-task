//
//  RedditLinksServerResponse.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

struct RedditLinksServerResponse: Decodable {
    
    struct Data: Decodable {
        
        struct Child: Decodable {
            
            struct Data: Decodable {
                let title: String
                let author: String
                let created: TimeInterval
                let num_comments: Int
                let thumbnail: String?
            }
            
            let data: Data
            
        }
        
        let after: String
        let children: [Child]
        
    }

    let data: Data
    
}


