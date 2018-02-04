//
//  URL+Image.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/4/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

extension URL {
    
    var isValidImageURL: Bool {
        guard scheme != nil else {
            return false
        }
        
        let availablePathExtension = ["jpg", "png"]
        guard availablePathExtension.contains(pathExtension) else {
            return false
        }
        
        return true
    }
    
}
