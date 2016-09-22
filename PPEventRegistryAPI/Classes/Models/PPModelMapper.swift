//
//  PPModelMapper.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/26/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

class PPModelMapper: NSObject { }

// MARK: PPArticle

extension PPModelMapper {
    func mapDataToModelObject(_ data: [String: Any]) -> PPArticle {
        let title = data["title"] as? String ?? ""
        let body  = data["body"]  as? String ?? ""
        let date  = data["date"]  as? String ?? ""
        let time  = data["time"]  as? String ?? ""
        let uri   = data["uri"]   as? String ?? ""
        let url   = URL(string: data["url"] as? String ?? "")
        let image = URL(string: data["image"] as? String ?? "")

        return PPArticle(title: title, body: body, date: date, time: time, uri: uri, url: url, image: image)
    }

    func mapDataToModelObjects(_ data: [String: Any]) -> [PPArticle] {
        var articles: [PPArticle] = []
        if let recentActivity = data["recentActivity"] as? [String: Any] {
            if let articlesData = recentActivity["articles"] as? [String: Any] {
                if let activity = articlesData["activity"] as? [[String: Any]] {
                    articles = activity.flatMap { mapDataToModelObject($0) }
                }
            }
        }
        return articles
    }
}

// MARK: PPEvent

extension PPModelMapper {
    func mapDataToModelObject(_ data: [String: Any]) -> PPEvent {
        let eventInfo = data["info"] as? [String: Any] ?? [:]
        let lang = "eng"

        let title     = (eventInfo["title"]    as? [String: String] ?? [:])[lang] ?? ""
        let summary   = (eventInfo["summary"]  as? [String: String] ?? [:])[lang] ?? ""
        let eventDate = eventInfo["eventDate"] as? String   ?? ""
        let images    = eventInfo["images"]    as? [String] ?? []
        let image     = URL(string: images.first ?? "")
        let locationLabel = (eventInfo["location"] as? [String: Any] ?? [:])["label"] as? [String: String] ?? [:]
        let location = locationLabel[lang] ?? ""

        return PPEvent(title: title, summary: summary, eventDate: eventDate, location: location, image: image)
    }

    func mapDataToModelObjects(_ data: [String: Any]) -> [PPEvent] {
        var events: [PPEvent] = []
        if let data = data as? [String: [String: Any]] {
            events = data.flatMap { mapDataToModelObject($1) }
        }
        return events
    }
}
