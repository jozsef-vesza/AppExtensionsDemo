//
//  DoneViewModel.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 12/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit
import TodoKit

struct DoneViewModel: TodoViewModelType {
    
    let store: ShoppingStoreType
    
    var items: [ShoppingItem] {
        return store.items().filter { $0.status != false }
    }
    
    init(store: ShoppingStoreType = ShoppingItemStore()) {
        self.store = store
    }
    
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
    
    func dataForRow(row: Int) -> TodoCellDataType {
        return TodayCellData(title: titleForRow(row), checked: statusForRow(row))
    }
}