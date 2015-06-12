//
//  DefaultTodoViewModel.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 12/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit

public struct DefaultTodoViewModel: TodayViewModelType {
    public let store: ShoppingItemStore
    public var items = [ShoppingItem]()
    
    public init(store: ShoppingItemStore = ShoppingItemStore.sharedInstance) {
        self.store = store
    }
    
    public func count() -> Int {
        return items.count
    }
    
    public func titleForRow(row: Int) -> String {
        return items[row].name
    }
    
    public func statusForRow(row: Int) -> Bool {
        return items[row].status
    }
    
    public func toggleStatusForRow(row: Int) {
        store.toggleAtIndex(row)
    }
}