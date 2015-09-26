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
let defaultRowHeight: CGFloat = 44

class TodoViewController: UITableViewController {
    
    private(set) var viewModel: TodoViewModel!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(todoReuseId, forIndexPath: indexPath) as! TodoCell
        cell.todoItem = viewModel.dataForRow(indexPath.row)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.toggleStatusForRow(indexPath.row)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
    }
    
    // MARK: - Segue management
    
    @IBAction override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
        guard let unwindSegue = unwindSegue as? AddNewItemUnwindSegue else {
            return
        }
        
        viewModel.addItemWithTitle(unwindSegue.itemTitle)
        
        dispatch_async(dispatch_get_main_queue()) { 
            self.tableView.reloadData()
        }
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