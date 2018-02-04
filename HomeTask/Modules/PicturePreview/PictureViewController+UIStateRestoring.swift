//
//  PictureViewController+UIStateRestoring.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/4/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

extension PictureViewController {
    
    private enum Keys: String {
        case pictureURL
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        if let pictureURL = pictureURL {
            coder.encode(pictureURL, forKey: Keys.pictureURL.rawValue)
        }
        
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        pictureURL = coder.decodeObject(forKey: Keys.pictureURL.rawValue) as? URL
        super.decodeRestorableState(with: coder)
    }
    
}
