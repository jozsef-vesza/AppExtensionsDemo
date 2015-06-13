//
//  ShoppingItemStore.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 11/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit

private let appGroupId = "group.hu.jozsefvesza.appextensionsdemo"
private let savedDataKey = "savedItems"

public enum StoreTypes {
    case UserDefaults
}

public struct ShoppingItemStore: ShoppingStoreType {
    
    private let defaultItems = [
        ShoppingItem(name: "Coffee"),
        ShoppingItem(name: "Banana"),
    ]
    
    private let defaults = NSUserDefaults(suiteName: appGroupId)
    
    public init() {}
    
    public func items() -> [ShoppingItem] {
        
        if let loaded = loadItems() {
            return loaded
        }
        
        return defaultItems
    }
    
    public func toggleItem(item: ShoppingItem) {
        
        let initial = items()
        
        let updated = initial.map { original -> ShoppingItem in
            return original == item ?
                ShoppingItem(name: original.name, status: !original.status) : original
        }
        
        saveItems(updated)
    }
    
    private func saveItems(items: [ShoppingItem]) {
        
        let boxedItems = items.map { item -> [String : Bool] in
            return [item.name : item.status]
        }
        
        defaults?.setValue(boxedItems, forKey: savedDataKey)
        defaults?.synchronize()
    }
    
    private func loadItems() -> [ShoppingItem]? {
        
        if let loaded = defaults?.valueForKey(savedDataKey) as? [[String : Bool]] {
            
            let unboxed = loaded.map { dict -> ShoppingItem in
                
                return ShoppingItem(name: dict.keys.first!, status: dict.values.first!)
            }
            
            return unboxed
        }
        
        return nil
    }
}