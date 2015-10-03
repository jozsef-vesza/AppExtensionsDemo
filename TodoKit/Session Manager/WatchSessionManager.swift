//
//  WatchSessionManager.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 03/10/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import WatchKit
import WatchConnectivity

public class WatchSessionManager: NSObject, WCSessionDelegate, SessionManagerType {
    
    public static let sharedManager = WatchSessionManager()
    public weak var store: ShoppingStoreType?
    
    private override init() {
        super.init()
    }
    
    private let session: WCSession = WCSession.defaultSession()
    
    public func startSession() {
        session.delegate = self
        session.activateSession()
    }

}

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

extension WatchSessionManager {
    
    public func updateApplicationContext(applicationContext: [String : AnyObject]) throws {
        
        print("Sending payload from watch!")
        
        do {
            try session.updateApplicationContext(applicationContext)
        } catch let error {
            throw error
        }
        
    }
}