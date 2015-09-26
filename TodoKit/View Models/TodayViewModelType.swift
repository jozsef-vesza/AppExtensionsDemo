//
//  TodayViewModelType.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 12/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import ViewModelExtensions

public protocol TodoViewModelType: ViewModelType {
    
    func count() -> Int
    func toggleStatusForRow(row: Int)
    func titleForRow(row: Int) -> String
    func statusForRow(row: Int) -> Bool
    func dataForRow(row: Int) -> TodoCellDataType
}

public extension TodoViewModelType where Self: DataProviderType {
    
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
}