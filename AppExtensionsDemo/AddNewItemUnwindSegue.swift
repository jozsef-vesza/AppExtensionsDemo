//
//  AddNewItemUnwindSegue.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 26/09/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import UIKit

class AddNewItemUnwindSegue: UIStoryboardSegue {
    var itemTitle: String {
        return addNewItemViewController.itemTitle
    }
    
    var addNewItemViewController: AddNewItemViewController {
        return sourceViewController as! AddNewItemViewController
    }
}
