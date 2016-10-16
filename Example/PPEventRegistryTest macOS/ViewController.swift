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

    let api = PPEventRegistryAPI()

    override func viewDidLoad() {
        if #available(OSX 10.10, *) {
            super.viewDidLoad()
        } else {
            // Fallback on earlier versions
        }
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

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

