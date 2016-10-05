//
//  ViewController.swift
//  PPEventRegistryTest tvOS
//
//  Created by Pavel Pantus on 7/25/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import UIKit
import PPEventRegistryAPI

class ViewController: UIViewController {

    let api = PPEventRegistryAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        api.setTransferProtocol(.https)
        api.login("testeventregistry@gmail.com", password: "cDWTgGpJ4Ny") { error in
            print("login with error: \(error)")
            self.api.getEvent(withID: 5077276) { event, error in
                print("get event error \(event)")
            }
            self.api.getRecentArticles(count: 10) { aricles, error in
                print("articles \(aricles), error \(error)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

