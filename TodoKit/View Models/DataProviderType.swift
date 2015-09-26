//
//  DataProviderType.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 26/09/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

public protocol DataProviderType {
    
    var items: [ShoppingItem] { get }
    var store: ShoppingStoreType { get }
}