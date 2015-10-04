//
//  PhoneSessionManager.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 03/10/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import UIKit
import WatchConnectivity

/// WatchConnectivity session manager for the iPhone app.
public class PhoneSessionManager: NSObject, WCSessionDelegate {

    /// Access to the shared instance.
    public static let sharedManager = PhoneSessionManager()
    /// The store that the session manager should interact with.
    public weak var store: ShoppingStoreType?
    
    private let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
    
    private var validSession: WCSession? {
        
        if let session = session where session.paired && session.watchAppInstalled {
            return session
        }
        
        return nil
    }
    
    private override init() {
        super.init()
    }
}

extension PhoneSessionManager: SessionManagerType {

    public func startSession() {
        print("Session Started \(self)")
        session?.delegate = self
        session?.activateSession()
    }
    
    public func updateApplicationContext(applicationContext: [String : AnyObject]) throws {

        guard let session = validSession else {
            
            print("Session: \(self.session) was invalid\n", "paired: \(self.session?.paired)\n", "watch app installed: \(self.session?.watchAppInstalled)")
            
            return
        }
        
        print("Session is valid: \(session), moving on!")
        
        do {
            try session.updateApplicationContext(applicationContext)
        } catch let error {
            throw error
        }
    }
}

/// MARK: - WCSessionDelegate conformance.

public extension PhoneSessionManager {
    
    public func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        
        print("Did receive payload: \(applicationContext)")
        
        guard let store = store else {
            print("No Store")
            return
        }
        
        store.handleApplicationContextPayload(applicationContext)
    }
}