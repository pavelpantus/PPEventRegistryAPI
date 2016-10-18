//
//  PPGetRecentActivity.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/22/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

/// Operation to request most recent articles.
final class PPRecentArticlesOperation: PPAsyncOperation {

    /**
     Operation initializer.
     - Parameters:
        - count: Count of articles to request.
        - completionHandler: Completion handler that is executed upon operation completion.
        - result: Result of the operation (see PPResult).
     */
    init(count: Int = 5, completionHandler: @escaping (_ result: PPResult<[PPArticle], PPError>) -> ()) {
        let parameters: [String: Any] = ["action": "getRecentActivity",
                                         "addEvents": false,
                                         "addActivity": false,
                                         "addArticles": true,
                                         "recentActivityArticlesMaxArticleCount": 1 ... 100 ~= count ? count : 5,
                                         "recentActivityArticlesMaxMinsBack": 10 * 60,
                                         "recentActivityArticlesMandatorySourceLocation": false,
                                         "recentActivityArticlesLastActivityId": 0]

        super.init(controller: .Overview, method: .Get, parameters: parameters as [String : Any])

        self.completionHandler = { result in
            switch result {
            case let .Success(response):
                let events: [PPArticle] = self.modelMapper.mapDataToModelObjects(response)
                DispatchQueue.main.async {
                    completionHandler(.Success(events))
                }
            case let .Failure(error):
                DispatchQueue.main.async {
                    completionHandler(.Failure(error))
                }
            }
        }
    }
}
