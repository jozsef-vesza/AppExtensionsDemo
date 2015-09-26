//
//  ShoppingStoreType.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 13/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit

public protocol ShoppingStoreType {
    
    func items() -> [ShoppingItem]
    func toggleItem(item: ShoppingItem)
    func addNewItemWithTitle(title: String)
}