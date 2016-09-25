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
        super.viewDidLoad()

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

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

