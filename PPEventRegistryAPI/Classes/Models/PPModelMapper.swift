//
//  PPModelMapper.swift
//  PPEventRegistryAPI
//
//  Created by Pavel Pantus on 6/26/16.
//  Copyright © 2016 Pavel Pantus. All rights reserved.
//

import Foundation

/// Converts data received from the network to model structs.
class PPModelMapper { }

// MARK: PPArticle

extension PPModelMapper {
    /**
     Converts data received from network.
     - Parameters:
        - data: Data received from network.
     - Returns: An instance of PPArticle.
     */
    func mapDataToModelObject(_ data: [String: Any]) -> PPArticle {
        let title = data["title"] as? String ?? ""
        let body  = data["body"]  as? String ?? ""
        let date  = data["date"]  as? String ?? ""
        let time  = data["time"]  as? String ?? ""
        let uri   = data["uri"]   as? String ?? ""
        let url   = URL(string: data["url"] as? String ?? "")
        let image = URL(string: data["image"] as? String ?? "")
        let concepts: [PPConcept] = mapDataToModelObjects(data["concepts"] as? [Any] ?? [])

        return PPArticle(title: title, body: body, date: date, time: time, uri: uri, url: url, image: image, concepts: concepts)
    }

    /**
     Converts data received from network.
     - Parameters:
        - data: Data received from network.
     - Returns: An array of PPArticles.
     */
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
    /**
     Converts data received from network.
     - Parameters:
        - data: Data received from network.
     - Returns: An instance of PPEvent.
     */
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
        let concepts: [PPConcept] = mapDataToModelObjects(eventInfo["concepts"] as? [Any] ?? [])

        return PPEvent(title: title, summary: summary, eventDate: eventDate, location: location, image: image, concepts: concepts)
    }

    /**
     Converts data received from network.
     - Parameters:
        - data: Data received from network.
     - Returns: An array of PPEvents.
     */
    func mapDataToModelObjects(_ data: [String: Any]) -> [PPEvent] {
        var events: [PPEvent] = []
        if let data = data as? [String: [String: Any]] {
            events = data.flatMap { mapDataToModelObject($1) }
        }
        return events
    }
}

// MARK: PPConcept

extension PPModelMapper {
    /**
     Converts data received from network.
     - Parameters:
        - data: Data received from network.
     - Returns: An instance of PPConcept.
     */
    func mapDataToModelObject(_ data: [String: Any]) -> PPConcept {
        let identifier  = data["id"] as? String ?? ""
        let description = data["description"] as? String ?? ""
        let uri         = URL(string: data["uri"] as? String ?? "")
        let image       = URL(string: data["image"] as? String ?? "")
        let score       = data["score"] as? Int ?? 0
        return PPConcept(identifier: identifier, description: description, uri: uri, image: image, score: score)
    }

    /**
     Converts data received from network.
     - Parameters:
        - data: Data received from network.
     - Returns: An array of PPConcepts.
     */
    func mapDataToModelObjects(_ data: [Any]) -> [PPConcept] {
        var concepts: [PPConcept] = []
        concepts = data.flatMap { mapDataToModelObject($0 as? [String: Any] ?? [:]) }
        return concepts
    }
}
