//
//  TodoCellDataType.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 26/09/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import Foundation

public protocol TodoCellDataType {
    var title: String { get }
    var checked: Bool { get }
}