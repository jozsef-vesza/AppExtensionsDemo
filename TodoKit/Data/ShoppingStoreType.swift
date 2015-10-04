//
//  ShoppingStoreType.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 13/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

/// Protocol description for instances managing the data store.
public protocol ShoppingStoreType: NSObjectProtocol {
    /// 
    /// Return the items from the store.
    ///
    /// - returns: An array of `ShoppingItem`s found in the data store.
    ///
    func items() -> [ShoppingItem]
    ///
    /// Toggle the purchase status for a given item.
    ///
    /// - parameter item: The item to change.
    ///
    func toggleItem(item: ShoppingItem)
    ///
    /// Add a new item with a given name to the store.
    ///
    /// - parameter title: the name of the item.
    ///
    func addNewItemWithTitle(title: String)
    ///
    /// Handle payload received through `WatchConnectivity`.
    ///
    /// - parameter payload: The application context dictionary received from the counterpart app.
    ///
    func handleApplicationContextPayload(payload:[String: AnyObject])
    ///
    /// Remove all done items from the store.
    ///
    func clearAllDone()
}