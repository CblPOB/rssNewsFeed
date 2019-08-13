//
//  NetworkManager.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 10/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation
import FeedKit

class NetworkManager {
    func loadFeed(source: Source, completion: @escaping (_ loadedSource: Source?)->()) {
        let parser = FeedParser(URL: source.url)
        parser.parseAsync { (result) in
            guard result.isSuccess, let rssFeed = result.rssFeed else {
                completion(nil)
                return
            }
            source.rssFeed = rssFeed
            if let rssFeedItems = rssFeed.items {
                source.feedItems = rssFeedItems
            }
            if let sourceImageURLString = rssFeed.image?.url, let sourceImageURL = URL(string: sourceImageURLString) {
                source.pictureURL = sourceImageURL
            }
            
            completion(source)
        }
    }
    
    func updateFeed(source: Source, completion: @escaping (_ success: Bool)->()) {
        let parser = FeedParser(URL: source.url)
        parser.parseAsync { (result) in
            guard result.isSuccess, let rssFeed = result.rssFeed else {
                completion(false)
                return
            }
            
            source.rssFeed = rssFeed
            if let rssFeedItems = rssFeed.items {
                source.feedItems = rssFeedItems
            }
            
            if let sourceImageURLString = rssFeed.image?.url, let sourceImageURL = URL(string: sourceImageURLString) {
                source.pictureURL = sourceImageURL
            }
            
            completion(true)
        }
    }
    
    func updateSource(source: Source, completion: @escaping (_ source: Source?)->()) {
        let parser = FeedParser(URL: source.url)
        parser.parseAsync { (result) in
            guard result.isSuccess, let rssFeed = result.rssFeed else {
                completion(nil)
                return
            }
            source.rssFeed = rssFeed
            if let rssFeedItems = rssFeed.items {
                source.feedItems = rssFeedItems
            }
            if let sourceImageURLString = rssFeed.image?.url, let sourceImageURL = URL(string: sourceImageURLString) {
                source.pictureURL = sourceImageURL
            }
            
            completion(source)
        }
    }
}
