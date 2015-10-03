//
//  SessionManagerType.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 03/10/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import Foundation

public protocol SessionManagerType {
    
    var store: ShoppingStoreType? { get set }
    
    func updateApplicationContext(applicationContext: [String : AnyObject]) throws
}