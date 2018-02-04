//
//  GalleryService.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/4/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation
import UIKit
import Photos

class GalleryService {
    
    func save(image: UIImage, completion: ((_ error: Error?) -> ())? = nil) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetCreationRequest.creationRequestForAsset(from: image)
        }, completionHandler: { success, error in
            DispatchQueue.main.async {
                completion?(error)
            }
        })
    }
    
}
