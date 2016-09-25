//
//  InterfaceController.swift
//  PPEventRegistryTest watchOS Extension
//
//  Created by Pavel Pantus on 7/25/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import WatchKit
import Foundation
import PPEventRegistryAPI

class InterfaceController: WKInterfaceController {

    let api = PPEventRegistryAPI()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        api.login("", password: "") { error in
            print("login with error: \(error)")
            self.api.getEvent(withID: 44808701) { event, error in
                print("get event \(event), error \(error)")
            }
            self.api.getRecentArticles(marker: nil) { marker, aricles, error in
                print("articles, request1 \(marker): \(aricles), error \(error)")

                if let marker = marker {
                    self.api.getRecentArticles(marker: marker) { marker, aricles, error in
                        print("articles, request2 \(marker): \(aricles), error \(error)")
                    }
                }
            }
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
