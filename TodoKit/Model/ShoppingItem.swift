//
//  ShoppingItem.swift
//  AppExtensionsDemo
//
//  Created by Vesza Jozsef on 11/06/15.
//  Copyright (c) 2015 József Vesza. All rights reserved.
//

public struct ShoppingItem {
    
    public let name: String
    public let status: Bool
    
    public init(name: String, status: Bool = false) {
        self.name = name
        self.status = status
    }
}

extension ShoppingItem: Equatable {}

public func ==(lhs: ShoppingItem, rhs: ShoppingItem) -> Bool {
    return lhs.name == rhs.name
}