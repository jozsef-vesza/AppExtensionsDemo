//
//  TodayViewModel.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 12/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit
import TodoKit
import ViewModelExtensions

struct TodayViewModel: ViewModelType {
    
    var selectedIndex: Int {
        didSet {
            /// TODO: Implement save
        }
    }
    
    init() {
        
        selectedIndex = 0
        
        if let savedIndex = loadSegmentIndex() {
            selectedIndex = savedIndex
        }
    }
    
    func viewModelForSegmentIndex(index: Int) -> TodayViewModelType {
        switch index {
        case 0:
            return NotDoneViewModel()
        default:
            return DoneViewModel()
        }
    }
    
    private func loadSegmentIndex() -> Int? {
        /// TODO: Implement load
        return nil
    }
}