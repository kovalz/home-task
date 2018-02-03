//
//  Dynamic.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

class Dynamic<T> {
    
    var bind: (_ oldValue: T, _ newValue: T) -> () = { _, _ in }
    
    var value: T {
        didSet {
            bind(oldValue, value)
        }
    }
    
    init(_ v : T) {
        value = v
    }
    
}
