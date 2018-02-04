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
    
    func save(image: UIImage, completion: ((_ success: Bool, _ error: Error?) -> ())? = nil) {
        let save = {
            PHPhotoLibrary.shared().performChanges({
                PHAssetCreationRequest.creationRequestForAsset(from: image)
            }, completionHandler: { success, error in
                DispatchQueue.main.async {
                    completion?(success, error)
                }
            })
        }
        
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    save()
                } else {
                    DispatchQueue.main.async {
                        completion?(false, nil)
                    }
                }
            }
        } else {
            save()
        }
    }
    
}
