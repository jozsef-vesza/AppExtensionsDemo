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
            
            switch todoItem.checked {
                
            case true:
                titleLabel.setAttributedText(NSAttributedString(string: todoItem.title, attributes: strikethroughCellTextAttributes))
                
            case false:
                titleLabel.setAttributedText(NSAttributedString(string: todoItem.title, attributes: cellTextAttributes))
            }
        }
    }
    
    private var cellTextAttributes: [String: AnyObject] {
        return [
            NSFontAttributeName: UIFont.systemFontOfSize(16),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
    }
    
    private var strikethroughCellTextAttributes: [String: AnyObject] {
        return [
            NSFontAttributeName: UIFont.systemFontOfSize(16),
            NSForegroundColorAttributeName: UIColor.lightGrayColor(),
            NSStrikethroughStyleAttributeName:
                NSUnderlineStyle.StyleSingle.rawValue
        ]
    }
}
