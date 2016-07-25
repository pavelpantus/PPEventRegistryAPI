//
//  PPModelMapper.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/26/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

class PPModelMapper: NSObject {

    func mapDataToModelObject(_ data: [String: AnyObject]) -> PPModelType? {
        return nil;
    }

    func mapDataToModelObjects(_ data: [String: AnyObject]) -> [PPModelType] {
        let models: [PPModelType] = []
        return models;
    }

}

// MARK: PPArticle

extension PPModelMapper {
    func mapDataToModelObject(_ data: [String: AnyObject]) -> PPArticle {
        let title = data["title"] as? String ?? ""
        let body  = data["body"]  as? String ?? ""
        let date  = data["date"]  as? String ?? ""
        let time  = data["time"]  as? String ?? ""
        let uri   = data["uri"]   as? String ?? ""
        let url   = URL(string: data["url"] as? String ?? "")
        let image = URL(string: data["image"] as? String ?? "")

        return PPArticle(title: title, body: body, date: date, time: time, uri: uri, url: url, image: image)
    }

    func mapDataToModelObjects(_ data: [String: AnyObject]) -> [PPArticle] {
        var articles: [PPArticle] = []
        if let recentActivity = data["recentActivity"] as? [String: AnyObject] {
            if let articlesData = recentActivity["articles"] as? [String: AnyObject] {
                if let activity = articlesData["activity"] as? [[String: AnyObject]] {
                    activity.forEach { articles.append(mapDataToModelObject($0)) }
                }
            }
        }
        return articles
    }
}

// MARK: PPEvent

extension PPModelMapper {
    func mapDataToModelObject(_ data: [String: AnyObject]) -> PPEvent {
        let eventInfo = data["info"] as? [String: AnyObject] ?? [:]
        let lang = "eng"

        let title     = eventInfo["title"]?[lang]   as? String   ?? ""
        let summary   = eventInfo["summary"]?[lang] as? String   ?? ""
        let eventDate = eventInfo["eventDate"]      as? String   ?? ""
        let images    = eventInfo["images"]         as? [String] ?? []
        let image     = URL(string: images.first ?? "")
        let location  = eventInfo["location"]?["label"]??[lang] as? String ?? ""

        return PPEvent(title: title, summary: summary, eventDate: eventDate, location: location, image: image)
    }

    func mapDataToModelObjects(_ data: [String: AnyObject]) -> [PPEvent] {
        var events: [PPEvent] = []
        data.forEach { events.append(mapDataToModelObject($1 as? [String : AnyObject] ?? [:])) }
        return events
    }
}
