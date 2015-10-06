//
//  GlanceViewModel.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 07/10/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import WatchKit
import TodoKit

class GlanceViewModel: NSObject {

    let store: ShoppingStoreType
    
    var titleForStatusLabel: String {
        
        let doneCount = store.items().filter { $0.status != false }.count
        
        return "\(doneCount)/\(store.items().count)"
    }
    
    init(store: ShoppingStoreType = ShoppingItemStore()) {
        self.store = store
    }
}
