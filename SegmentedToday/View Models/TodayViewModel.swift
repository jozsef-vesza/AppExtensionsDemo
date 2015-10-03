//
//  TodayViewModel.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 12/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit
import TodoKit

private let appGroupId = "group.hu.jozsefvesza.appextensionsdemo"
let selectedIndexKey = "selectedIndex"

struct TodayViewModel {
    
    var selectedIndex: Int = 0 {
        didSet {
            NSUserDefaults.standardUserDefaults().setInteger(selectedIndex, forKey: selectedIndexKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    init() {
        if let savedIndex = loadSegmentIndex() {
            selectedIndex = savedIndex
        }
    }
    
    func viewModelForSegmentIndex(index: Int) -> TodoViewModelType {
        
        let sessionManager = PhoneSessionManager.sharedManager
        sessionManager.startSession()
        
        switch index {
        case 0:
            return NotDoneViewModel(store: ShoppingItemStore(appGroupId: appGroupId, sessionManager: sessionManager))
        default:
            return DoneViewModel(store: ShoppingItemStore(appGroupId: appGroupId, sessionManager: sessionManager))
        }
    }
    
    private func loadSegmentIndex() -> Int? {
        
        if let loadedIndex = NSUserDefaults.standardUserDefaults().objectForKey(selectedIndexKey) as? Int {
            return loadedIndex
        }
        
        return nil
    }
}