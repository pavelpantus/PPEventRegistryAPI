//
//  PPModelMapper.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/26/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation
import SwiftyJSON

class PPModelMapper: NSObject {

    func mapDataToModelObject(_ json: JSON) -> PPModelType? {
        return nil;
    }

    func mapDataToModelObjects(_ json: JSON) -> [PPModelType] {
        let models: [PPModelType] = []
        return models;
    }

}

// MARK: PPArticle

extension PPModelMapper {
    func mapDataToModelObject(_ json: JSON) -> PPArticle {
        let title = json["title"].stringValue
        let body = json["body"].stringValue
        let date = json["date"].stringValue
        let time = json["time"].stringValue
        let uri = json["uri"].intValue
        let url = json["url"].URL
        let image = json["image"].URL

        return PPArticle(title: title, body: body, date: date, time: time, uri: uri, url: url, image: image)
    }

    func mapDataToModelObjects(_ json: JSON) -> [PPArticle] {
        var articles: [PPArticle] = []
        if let eventsInfo = json["recentActivity"]["articles"]["activity"].array {
            eventsInfo.forEach { articles.append(mapDataToModelObject($0)) }
        }
        return articles
    }
}

// MARK: PPEvent

extension PPModelMapper {
    func mapDataToModelObject(_ json: JSON) -> PPEvent {
        let eventInfo = json["info"]
        let lang = "eng"

        let title = eventInfo["title"][lang].stringValue
        let summary = eventInfo["summary"][lang].stringValue
        let eventDate = eventInfo["eventDate"].stringValue
        let location = eventInfo["location"]["label"][lang].stringValue
        let image = eventInfo["images"][0].URL

        return PPEvent(title: title, summary: summary, eventDate: eventDate, location: location, image: image)
    }

    func mapDataToModelObjects(_ json: JSON) -> [PPEvent] {
        var events: [PPEvent] = []
        json.forEach { events.append(mapDataToModelObject($1)) }
        return events
    }
}
