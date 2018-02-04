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
    
    @discardableResult func setImage(with url: URL) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            
            guard let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                 self.image = image
            }
        }
        
        task.resume()
        return task
    }
    
}
