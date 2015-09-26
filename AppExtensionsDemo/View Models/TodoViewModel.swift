//
//  TodoViewModel.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 11/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit
import TodoKit

struct TodoViewModel: TodoViewModelType, DataProviderType {
    
    var items: [ShoppingItem] {
        return store.items()
    }
    
    let store: ShoppingStoreType
    
    init(store: ShoppingStoreType = ShoppingItemStore()) {
        self.store = store
    }
    
    func dataForRow(row: Int) -> TodoCellDataType {
        return TodoCellData(title: titleForRow(row), checked: statusForRow(row))
    }
}