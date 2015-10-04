//
//  TodayViewModelType.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 12/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

/// Protocol definition for instances, which act as view models, managing Todo items.
public protocol TodoViewModelType {
    ///
    /// The number of items in the store.
    ///
    func count() -> Int
    ///
    /// Change the purchased status for the item at a given index.
    ///
    /// - parameter row: The index of the item.
    ///
    func toggleStatusForRow(row: Int)
    ///
    /// Get the title of the item at a given index.
    ///
    /// - parameter row: The index of the item.
    ///
    /// - returns: The title of the item.
    ///
    func titleForRow(row: Int) -> String
    ///
    /// Get the purchased of the item at a given index.
    ///
    /// - parameter row: The index of the item.
    ///
    /// - returns: The purchased status of the item.
    ///
    func statusForRow(row: Int) -> Bool
    ///
    /// Get the view data instance for the item at a given index.
    ///
    /// - parameter row: The index of the item.
    ///
    /// - returns: The configured view data for the item.
    ///
    func dataForRow(row: Int) -> TodoCellDataType
    ///
    /// Store a new item with the given title.
    ///
    /// - parameter title: The title for the new item.
    ///
    func addItemWithTitle(title: String)
    ///
    /// Delete all done items.
    ///
    func clearAllDone()
}

/// Default behavior for view models, which interact directly with a store instance.
public extension TodoViewModelType where Self: DataProviderType {
    
    func count() -> Int {
        return items.count
    }
    
    func titleForRow(row: Int) -> String {
        return items[row].name
    }
    
    func statusForRow(row: Int) -> Bool {
        return items[row].status
    }
    
    func toggleStatusForRow(row: Int) {
        store.toggleItem(items[row])
    }
    
    func addItemWithTitle(title: String) {
        store.addNewItemWithTitle(title)
    }
    
    func clearAllDone() {
        store.clearAllDone()
    }
}