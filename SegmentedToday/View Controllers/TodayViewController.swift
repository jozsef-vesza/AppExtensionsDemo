//
//  TodayViewController.swift
//  SegmentedToday
//
//  Created by Vesza Jozsef on 12/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit
import NotificationCenter
import TodoKit

let todayCellId = "todayCell"
let rowHeight: CGFloat = 44
let standardPadding: CGFloat = 8

class TodayViewController: UIViewController {
    
    @IBOutlet weak var openButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var segmentedControlHeight: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    private var mainViewModel = TodayViewModel() {
        didSet {
            handleContentChange()
        }
    }
    
    private var subViewModel: TodoViewModelType  {
        return mainViewModel.viewModelForSegmentIndex(selectedIndex)
    }
    
    private var selectedIndex: Int {
        return mainViewModel.selectedIndex
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = rowHeight
    }
    
    override func viewWillAppear(animated: Bool) {
        segmentedControl.selectedSegmentIndex = mainViewModel.selectedIndex
    }
    
    // MARK: - User interaction
    
    @IBAction private func segmentChanged(sender: UISegmentedControl) {
        mainViewModel.selectedIndex = sender.selectedSegmentIndex
    }
    
    @IBAction private func goToAppButtonPressed(sender: UIButton) {
        
        if let appUrl = NSURL(string: "appExtensionsDemo://") {
            extensionContext?.openURL(appUrl, completionHandler: nil)
        }
    }
    
    // MARK: - Private helpers
    
    private func handleContentChange() {
        
        let tableViewHeight = CGFloat(subViewModel.count()) * rowHeight
        
        let contentHeight = standardPadding + segmentedControlHeight.constant + standardPadding + tableViewHeight + standardPadding + openButtonHeight.constant + standardPadding
        
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
            self.preferredContentSize.height = contentHeight
        }
    }
}

// MARK: - NCWidgetProviding

extension TodayViewController: NCWidgetProviding {
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.NewData)
        handleContentChange()
    }
}

// MARK: - Table view data source

extension TodayViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subViewModel.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(todayCellId, forIndexPath: indexPath) as! TodayCell
        
        cell.todoItem = subViewModel.dataForRow(indexPath.row)
        
        return cell
    }
}

// MARK: - Table view delegate

extension TodayViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        subViewModel.toggleStatusForRow(indexPath.row)
        handleContentChange()
    }
}