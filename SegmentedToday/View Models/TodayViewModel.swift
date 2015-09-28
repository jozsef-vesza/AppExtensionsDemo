//
//  TodayViewModel.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 12/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit
import TodoKit

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
        switch index {
        case 0:
            return NotDoneViewModel()
        default:
            return DoneViewModel()
        }
    }
    
    private func loadSegmentIndex() -> Int? {
        
        if let loadedIndex = NSUserDefaults.standardUserDefaults().objectForKey(selectedIndexKey) as? Int {
            return loadedIndex
        }
        
        return nil
    }
}