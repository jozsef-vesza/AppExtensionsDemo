//
//  ShoppingItem.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 11/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

import UIKit

public struct ShoppingItem {
    public let name: String
    public var status: Bool
    
    public init(name: String, status: Bool = false) {
        self.name = name
        self.status = status
    }
    
    public mutating func toggle() {
        status = !status
    }
}