//
//  ShoppingItemStore.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 11/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit

public class ShoppingItemStore: ItemStoreType {
    
    public static let sharedInstance = ShoppingItemStore()
    public private(set) var items = [ShoppingItem]() {
        didSet {
            storeItemState(items)
        }
    }
    
    private let defaultItems = [
        ShoppingItem(name: "Coffee"),
        ShoppingItem(name: "Banana"),
    ]
    
    public init() {
        if let savedItems = loadItems() {
            items = savedItems
        } else {
            items = defaultItems
        }
    }
    
    public func toggle(item: ShoppingItem) {
        
        items = items.map { original -> ShoppingItem in
            
            return original == item ?
                ShoppingItem(name: original.name, status: !original.status) : original
        }
    }
}

extension ShoppingItemStore: ItemPersisterType {
    
    internal func storeItemState(items: [ShoppingItem]) {
        /// TODO: - save to shared store
    }
    
    internal func loadItems() -> [ShoppingItem]? {
        return nil
    }
}