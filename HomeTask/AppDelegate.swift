//
//  AppDelegate.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        guard
            let navigationController = window?.rootViewController as? UINavigationController,
            let viewController = navigationController.viewControllers.first as? FeedViewController
        else {
            fatalError("AppDelegate: invalid rootViewController.")
        }
        
        let reddit = RedditService()
        let alertNotificationCenter = AlertNotificationCenter(rootViewController: viewController)
        let viewModel = FeedViewModel(dataSource: reddit, userNotificationCenter: alertNotificationCenter)
        viewController.viewModel = viewModel
        
        return true
    }

    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }


}

