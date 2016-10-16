//
//  ExtensionDelegate.swift
//  PPEventRegistryTest watchOS Extension
//
//  Created by Pavel Pantus on 7/25/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import WatchKit
import PPEventRegistryAPI

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    let api = PPEventRegistryAPI()
    
    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        api.setTransferProtocol(.http)
        api.login("testeventregistry@gmail.com", password: "cDWTgGpJ4Ny") { error in
            print("login with error: \(error)")
            self.api.getEvent(withID: 5077276) { result in
                switch result {
                case .Success(let event):
                    print("get event: success \(event)")
                case .Failure(let error):
                    print("get event: error \(error)")
                }
            }
            self.api.getRecentArticles(count: 10) { result in
                switch result {
                case .Success(let articles):
                    print("get aricles: success \(articles)")
                case .Failure(let error):
                    print("get aricles: error \(error)")
                }
            }
        }
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    @available(watchOSApplicationExtension 3.0, *)
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        backgroundTasks.forEach { (task) in
            // Process the background task
            
            // Be sure to complete each task when finished processing.
            task.setTaskCompleted()
        }
    }

}
