//
//  TodoItemsViewModel.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 27/09/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import Foundation
import TodoKit

struct TodoItemsViewModel: TodoViewModelType, DataProviderType {
    
    var items: [ShoppingItem] {
        return store.items().filter { $0.status == false }
    }
    
    let store: ShoppingStoreType
    
    init(store: ShoppingStoreType = ShoppingItemStore(sessionManager: WatchSessionManager.sharedManager)) {
        self.store = store
    }
    
    func dataForRow(row: Int) -> TodoCellDataType {
        return TodoWatchRowData(title: titleForRow(row), checked: statusForRow(row))
    }
    
}