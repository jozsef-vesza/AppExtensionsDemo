//
//  ShoppingItemStore.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 11/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit

public class ShoppingItemStore: NSObject {
    
    public static let sharedInstance = ShoppingItemStore()
    public private(set) var items: [ShoppingItem]
    
    private let defaultItems = [
        ShoppingItem(name: "Coffee"),
        ShoppingItem(name: "Banana"),
    ]
    
    public override init() {
        items = [ShoppingItem]()
        super.init()
        
        if let savedItems = loadItems() {
            items = savedItems
        } else {
            items = defaultItems
        }
    }
    
    public func toggle(item: ShoppingItem) {
        
        items = items.map { original -> ShoppingItem in
            
            if original.name == item.name {
                return ShoppingItem(name: original.name, status: !original.status)
            }
            
            return original
        }
    }
    
    private func loadItems() -> [ShoppingItem]? {
        return nil
    }
}