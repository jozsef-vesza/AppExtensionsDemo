//
//  TodoCellDataType.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 26/09/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import Foundation

/// Protocol description for view data instances, which populate Todo table cells.
public protocol TodoCellDataType {
    /// The title of the item to display.
    var title: String { get }
    /// The checked status of the item to display.
    var checked: Bool { get }
}