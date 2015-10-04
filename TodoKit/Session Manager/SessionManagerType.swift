//
//  SessionManagerType.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 03/10/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import Foundation

/// Protocol definition for WatchConnectivity session managers.
public protocol SessionManagerType {
    /// The store to interact with.
    var store: ShoppingStoreType? { get set }
    ///
    /// Send the updated application context payload to the counterpart app.
    ///
    /// - parameter applicationContext: The fresh application context payload.
    ///
    func updateApplicationContext(applicationContext: [String : AnyObject]) throws
    /// Start the WatchConnectivity session.
    ///
    /// Call this method after initialization to send/receive payload between the counterparts.
    ///
    func startSession()
}