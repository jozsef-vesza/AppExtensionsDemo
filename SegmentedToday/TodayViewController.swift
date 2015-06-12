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
    
    private var currentViewModel: TodayViewModelType = NotDoneViewModel() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        preferredContentSize = CGSize(width: preferredContentSize.width, height: CGFloat(currentViewModel.count()) * rowHeight)
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    @IBAction private func segmentChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentViewModel = NotDoneViewModel()
        default:
            currentViewModel = DoneViewModel()
        }
    }
}

/// MARK: - Table view data source

extension TodayViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentViewModel.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(todayCellId) as! UITableViewCell
        
        cell.textLabel?.text = currentViewModel.titleForRow(indexPath.row)
        cell.textLabel?.textColor = UIColor.lightTextColor()
        
        return cell
    }
}

/// MARK: - Table view delegate

extension TodayViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentViewModel.toggleStatusForRow(indexPath.row)
        tableView.reloadData()
    }
}