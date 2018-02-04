//
//  UserNotificationCenter.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/4/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

protocol UserNotificationCenter {
    
    func notify(about error: Error)
    func notify(title: String, message: String)

}
