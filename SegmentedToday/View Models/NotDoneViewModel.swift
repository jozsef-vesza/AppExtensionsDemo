//
//  NotDoneViewModel.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 12/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit
import TodoKit

struct NotDoneViewModel: TodoViewModelType, DataProviderType {
    
    let store: ShoppingStoreType
    
    var items: [ShoppingItem] {
        return store.items().filter { $0.status == false }
    }
    
    init(store: ShoppingStoreType = ShoppingItemStore()) {
        self.store = store
    }
    
    func dataForRow(row: Int) -> TodoCellDataType {
        return TodayCellData(title: titleForRow(row), checked: statusForRow(row))
    }
}