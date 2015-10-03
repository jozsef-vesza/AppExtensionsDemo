//
//  InterfaceController.swift
//  TodoWatch Extension
//
//  Created by József Vesza on 27/09/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import WatchKit
import Foundation

let todoItemRowId = "TodoItemRow"
let updateDataNotification = "updateData"

class InterfaceController: WKInterfaceController {

    @IBOutlet private weak var itemsTable: WKInterfaceTable!

    var viewModel = TodoItemsViewModel()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        super.willActivate()
        updateTable()
        
        NSNotificationCenter.defaultCenter().addObserverForName(updateDataNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (_) -> Void in
            self.updateTable()
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        viewModel.toggleStatusForRow(rowIndex)
        updateTable()
    }
    
    private func updateTable() {
        
        itemsTable.setNumberOfRows(viewModel.count(), withRowType: todoItemRowId)
        
        for (index, _) in viewModel.items.enumerate() {
            
            let controller = itemsTable.rowControllerAtIndex(index) as! TodoItemsRowController
            controller.todoItem = viewModel.dataForRow(index)
        }
    }
}
