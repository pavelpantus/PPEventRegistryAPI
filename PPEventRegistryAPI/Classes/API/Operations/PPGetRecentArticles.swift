//
//  PPGetRecentActivity.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/22/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

final class PPGetRecentArticles: PPAsyncOperation {
    init(count: Int = 5, completionHandler: @escaping (_ events: [PPArticle], _ error: NSError?) -> Void) {
        let parameters: [String: Any] = ["action": "getRecentActivity",
                                         "addEvents": false,
                                         "addActivity": false,
                                         "addArticles": true,
                                         "recentActivityArticlesMaxArticleCount": 1 ... 100 ~= count ? count : 5,
                                         "recentActivityArticlesMaxMinsBack": 10 * 60,
                                         "recentActivityArticlesMandatorySourceLocation": false,
                                         "recentActivityArticlesLastActivityId": 0]

        super.init(controller: .Overview, method: .Get, parameters: parameters as [String : Any])

        self.completionHandler = { response, error -> Void in
            var events: [PPArticle] = []

            if let response = response {
                events = self.modelMapper.mapDataToModelObjects(response)
            }

            DispatchQueue.main.async {
                completionHandler(events, error)
            }
        }
    }
}
