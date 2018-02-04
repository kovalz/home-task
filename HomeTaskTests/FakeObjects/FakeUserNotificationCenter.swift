//
//  FakeUserNotificationCenter.swift
//  HomeTaskTests
//
//  Created by Zhenya Koval on 2/5/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

class FakeUserNotificationCenter: UserNotificationCenter {
    
    private (set) var didNotify = false
    private (set) var didNotifyAboutError = false

    func notify(about error: Error) {
        didNotifyAboutError = true
    }
    
    func notify(title: String, message: String) {
        didNotify = true
    }
    
}
