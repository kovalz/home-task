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
    
    @discardableResult func setImage(with url: URL, completion: ((_ success: Bool) -> ())? = nil) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion?(false)
                }
                return
            }
            
            guard let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion?(false)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
                completion?(true)
            }
        }
        
        task.resume()
        return task
    }
    
}
