//
//  DataProviderType.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 26/09/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

/// Protocol definition for types, which interact directly with a store instance.
public protocol DataProviderType {
    /// The items found in the store.
    var items: [ShoppingItem] { get }
    /// The store instance to interact with.
    var store: ShoppingStoreType { get }
}