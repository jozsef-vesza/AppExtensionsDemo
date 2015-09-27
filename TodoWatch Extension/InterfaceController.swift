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

class InterfaceController: WKInterfaceController {

    @IBOutlet private weak var itemsTable: WKInterfaceTable!

    var viewModel: TodoItemsViewModel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}