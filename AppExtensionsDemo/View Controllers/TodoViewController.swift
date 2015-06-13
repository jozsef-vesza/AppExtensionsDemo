//
//  TodoViewController.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 11/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit
import ViewModelExtensions

let todoReuseId = "todoCell"
let statusbarHeight: CGFloat = 20
let defaultRowHeight: CGFloat = 44

class TodoViewController: UITableViewController {
    
    var viewModel: TodoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset.top = statusbarHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = defaultRowHeight
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserverForName(updateDataNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (_) -> Void in
            self.tableView.reloadData()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(todoReuseId) as! UITableViewCell
        
        cell.textLabel?.text = viewModel.titleForRow(indexPath.row)
        cell.accessoryType = viewModel.statusForRow(indexPath.row) ? .Checkmark : .None
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.toggleStatusForRow(indexPath.row)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
    }
}

// Mark: - View controller initialization extension

extension TodoViewController: ViewControllerInitializable {
    
    static func instanceWithViewModel(viewModel: TodoViewModel) -> TodoViewController? {
        
        if let instance = self.instance() as? TodoViewController {
            instance.viewModel = viewModel
            return instance
        }
        
        return nil
    }
}