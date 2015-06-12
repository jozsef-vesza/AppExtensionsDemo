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

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var mainViewModel = TodayViewModel() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var subViewModel: TodayViewModelType  {
        return mainViewModel.viewModelForSegmentIndex(mainViewModel.selectedIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = rowHeight
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    @IBAction private func segmentChanged(sender: UISegmentedControl) {
        mainViewModel.selectedIndex = sender.selectedSegmentIndex
    }
    
    @IBAction private func goToAppButtonPressed(sender: UIButton) {
        
        if let appUrl = NSURL(string: "appExtensionsDemo://") {
            extensionContext?.openURL(appUrl, completionHandler: nil)
        }
    }
}

/// MARK: - Table view data source

extension TodayViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subViewModel.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(todayCellId) as! UITableViewCell
        
        cell.textLabel?.text = subViewModel.titleForRow(indexPath.row)
        cell.textLabel?.textColor = UIColor.lightTextColor()
        
        return cell
    }
}

/// MARK: - Table view delegate

extension TodayViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        subViewModel.toggleStatusForRow(indexPath.row)
        tableView.reloadData()
    }
}