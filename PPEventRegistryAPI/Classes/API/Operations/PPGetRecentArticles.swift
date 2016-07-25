//
//  PPGetRecentActivity.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/22/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

final class PPGetRecentArticles: PPAsyncOperation {
    init(completionHandler: ((events: [PPArticle], error: NSError?) -> Void)?) {
        let parameters: [String: AnyObject] = ["action": "getRecentActivity",
                                               "addEvents": false,
                                               "addActivity": false,
                                               "addArticles": true,
                                               "recentActivityArticlesMaxArticleCount": 5,
                                               "recentActivityArticlesMaxMinsBack": 10 * 60,
                                               "recentActivityArticlesMandatorySourceLocation": false,
                                               "recentActivityArticlesLastActivityId": 0]

        super.init(controller: "overview", httpMethod: "GET", parameters: parameters)

        self.completionHandler = { response, error -> Void in
            var events: [PPArticle] = []

            if let response = response {
                events = self.modelMapper.mapDataToModelObjects(response)
            }

            DispatchQueue.main.async {
                completionHandler?(events: events, error: error)
            }
        }
    }
}
