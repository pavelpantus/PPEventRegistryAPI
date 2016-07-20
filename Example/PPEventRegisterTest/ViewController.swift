//
//  ViewController.swift
//  PPEventRegisterTest
//
//  Created by Pavel Pantus on 6/19/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import UIKit
import PPEventRegistryAPI

class ViewController: UIViewController {
    let eventRegistryAPI = PPEventRegistryAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

