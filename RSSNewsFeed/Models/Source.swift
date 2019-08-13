//
//  Source.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 10/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation
import FeedKit

class Source {
    var name = ""
    var pictureURL: URL?
    var url: URL
    var rssFeed: RSSFeed?
    var feedItems: [RSSFeedItem]?
    var sourceID: UUID
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
        sourceID = UUID()
    }
    
    init(name: String, url: URL, sourceID: UUID) {
        self.name = name
        self.url = url
        self.sourceID = sourceID
    }
}
