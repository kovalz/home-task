//
//  AlertNotificationCenter.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/4/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation
import UIKit

class AlertNotificationCenter: UserNotificationCenter {
    
    weak private (set) var rootViewController: UIViewController?
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    func notify(about error: Error) {
        showAlert(title: "Oops!", message: error.localizedDescription)
    }
    
    func notify(title: String, message: String) {
        showAlert(title: title, message: message)
    }
    
    private func showAlert(title: String, message: String) {
        guard let rootViewController = rootViewController, rootViewController.presentedViewController == nil else {
            return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(ok)
        rootViewController.present(alertController, animated: true, completion: nil)
    }
    
}
