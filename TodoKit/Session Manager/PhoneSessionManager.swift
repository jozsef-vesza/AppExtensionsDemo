//
//  PhoneSessionManager.swift
//  AppExtensionsDemo
//
//  Created by József Vesza on 03/10/15.
//  Copyright © 2015 József Vesza. All rights reserved.
//

import UIKit
import WatchConnectivity

public class PhoneSessionManager: NSObject, WCSessionDelegate {

    public static let sharedManager = PhoneSessionManager()
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
    
    public func startSession() {
        session?.delegate = self
        session?.activateSession()
    }
}

extension PhoneSessionManager: SessionManagerType {

    public func updateApplicationContext(applicationContext: [String : AnyObject]) throws {
        if let session = validSession {
            do {
                try session.updateApplicationContext(applicationContext)
            } catch let error {
                throw error
            }
        }
    }
}