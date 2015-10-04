//
//  WatchSessionManager.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 03/10/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import WatchKit
import WatchConnectivity

/// WatchConnectivity session manager for the watchOS app.
public class WatchSessionManager: NSObject, WCSessionDelegate {
    
    /// Access to the shared instance.
    public static let sharedManager = WatchSessionManager()
    /// The store that the session manager should interact with.
    public weak var store: ShoppingStoreType?
    
    private override init() {
        super.init()
    }
    
    private let session: WCSession = WCSession.defaultSession()
}

// MARK: - SessionManagerType confomance

extension WatchSessionManager: SessionManagerType {
    
    public func startSession() {
        session.delegate = self
        session.activateSession()
    }
    
    public func updateApplicationContext(applicationContext: [String : AnyObject]) throws {
        
        print("Sending payload from watch!")
        
        do {
            try session.updateApplicationContext(applicationContext)
        } catch let error {
            throw error
        }
        
    }
}

/// MARK: - WCSessionDelegate conformance.

public extension WatchSessionManager {
    
    public func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        
        print("Did receive payload: \(applicationContext)")
        
        guard let store = store else {
            print("No Store")
            return
        }
        
        store.handleApplicationContextPayload(applicationContext)
    }
}

