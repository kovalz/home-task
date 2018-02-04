//
//  UIImageView+URL.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    enum ErrorKind: Swift.Error {
        case unableToCreateImage
        case emptyResponseData
    }
    
    @discardableResult func setImage(with url: URL, completion: ((_ error: Error?) -> ())? = nil) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion?(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion?(ErrorKind.emptyResponseData)
                }
                return
            }
            
            guard let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion?(ErrorKind.unableToCreateImage)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
                completion?(nil)
            }
        }
        
        task.resume()
        return task
    }
    
}
