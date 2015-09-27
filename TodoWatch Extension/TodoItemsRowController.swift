//
//  TodoItemsRowController.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 27/09/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import WatchKit
import TodoKit

class TodoItemsRowController: NSObject {

    @IBOutlet private weak var titleLabel: WKInterfaceLabel!
    
    var todoItem: TodoCellDataType? {
        didSet {
            guard let todoItem = todoItem else {
                return
            }
            
            titleLabel.setText(todoItem.title)
        }
    }
}
