//
//  AppDelegate.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 11/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        if
            let mainViewController = TodoViewController.instanceWithViewModel(TodoViewModel()),
            let window = self.window {
                window.rootViewController = mainViewController
                window.makeKeyAndVisible()
        }
        
        return true
    }

}