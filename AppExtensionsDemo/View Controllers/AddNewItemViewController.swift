//
//  AddNewItemViewController.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 26/09/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import UIKit

class AddNewItemViewController: UIViewController {

    @IBOutlet private weak var itemTextField: UITextField!
    
    var itemTitle: String {
        return itemTextField.text!
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        itemTextField.becomeFirstResponder()
    }
}
