//
//  ShoppingItem.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 11/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

/// Representation of a shopping item.
public struct ShoppingItem {
    
    /// The name of the item.
    public let name: String
    /// The purchased status of the item.
    public let status: Bool
    
    ///
    /// Initialize a shopping item with a given name, and status.
    ///
    /// - parameter name: The name of the item.
    /// - parameter status: The purchased status (default is `false`)
    ///
    public init(name: String, status: Bool = false) {
        self.name = name
        self.status = status
    }
}

extension ShoppingItem: Equatable {}

public func ==(lhs: ShoppingItem, rhs: ShoppingItem) -> Bool {
    return lhs.name == rhs.name
}