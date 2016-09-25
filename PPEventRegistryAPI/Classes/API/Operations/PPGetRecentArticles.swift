//
//  PPGetRecentActivity.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/22/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

final class PPGetRecentArticles: PPAsyncOperation {
    init(marker: PPFetchMarker?, completionHandler: @escaping (_ marker: PPFetchMarker?, _ events: [PPArticle], _ error: NSError?) -> Void) {
        let parameters: [String: Any] = ["action": "getRecentActivity",
                                         "addEvents": false,
                                         "addArticles": true,
                                         "recentActivityArticlesMaxArticleCount": 1,
                                         "recentActivityArticlesMaxMinsBack": 7 * 24 * 60 * 60,
                                         "recentActivityArticlesMandatorySourceLocation": false,
                                         "recentActivityArticlesLastActivityId": marker?.id ?? "0"]

        super.init(controller: "overview", httpMethod: "GET", parameters: parameters)

        self.completionHandler = { response, error -> Void in
            let (events, marker) = self.modelMapper.mapDataToModelObjects(response ?? [:])
            DispatchQueue.main.async {
                completionHandler(marker, events, error)
            }
        }
    }
}
