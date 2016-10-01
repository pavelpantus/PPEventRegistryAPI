//
//  ViewController.swift
//  PPEventRegistryTest macOS
//
//  Created by Pavel Pantus on 7/25/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Cocoa
import PPEventRegistryAPI

class ViewController: NSViewController {

    let eventRegistryAPI = PPEventRegistryAPI()

    override func viewDidLoad() {
        super.viewDidLoad()

        eventRegistryAPI.login("", password: "") { (error) in
            print("login with error: \(error)")
            self.eventRegistryAPI.getEvent(withID: 4480838701, completionHandler: { (event, error) in
                print("get event error \(event)")
            })
            self.eventRegistryAPI.getRecentArticles({ (aricles, error) in
                print("articles \(aricles), error \(error)")
            })
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

