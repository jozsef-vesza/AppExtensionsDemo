//
//  ShoppingItemStoreType.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 13/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit

public protocol ItemStoreType {
    
    typealias Item
    
    var items: [Item] { get }
    
    func toggle(item: Item)
}

internal protocol ItemPersisterType {
    
    typealias Item
    
    func storeItemState(items: [Item])
    func loadItems() -> [Item]?
}

