//
//  TodoCell.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 26/09/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import UIKit
import TodoKit

class TodoCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    var todoItem: TodoCellDataType? {
        
        didSet {
            guard let todoItem = todoItem else {
                return
            }
            
            titleLabel.text = todoItem.title
            accessoryType = todoItem.checked ? .Checkmark : .None
        }
    }

}
