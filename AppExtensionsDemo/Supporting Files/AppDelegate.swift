//
//  AppDelegate.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 11/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit

let updateDataNotification = "updateData"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var navigationController: UINavigationController? = {
        return self.window?.rootViewController as? UINavigationController
        }()
    
    lazy var mainViewController: TodoViewController? = {
        
        let storyboardId = NSStringFromClass(TodoViewController)
        
        
        guard
            let strippedId = storyboardId.componentsSeparatedByCharactersInSet(NSCharacterSet.punctuationCharacterSet()).last,
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(strippedId) as? TodoViewController else {
            return nil
        }
        
        viewController.viewModel = TodoViewModel()
        
        return viewController
        }()
    
    func applicationDidFinishLaunching(application: UIApplication) {
        
        guard let mainViewController = mainViewController,
            navigationController = navigationController else {
                return
        }
        
        navigationController.viewControllers = [mainViewController]
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        NSNotificationCenter.defaultCenter().postNotificationName(updateDataNotification, object: nil)
    }
}