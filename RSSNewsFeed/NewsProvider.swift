//
//  NewsProvider.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 10/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation

protocol SourcesManager: class {
    func sourcesList() -> [Source]
}

protocol FeedManager: class {
    func sourcesList() -> [Source]
    func updateFeed(completion: ((_ success: Bool)->())?)
}

protocol AddingSource {
    func add(source: SourceDataObject, completion: @escaping (_ success: Bool)->())
}

protocol EditingSource: class {
    func updateSource(sourceID: UUID, dataObject: SourceDataObject, completion: @escaping (_ success: Bool)->())
    func sourceDataObject(sourceID: UUID) -> SourceDataObject?
}

class NewsProvider {
    private var sources = [Source]()
    private let networkManager = NetworkManager()
    private let storageManager: StorageManager
    
    init(storageManager: StorageManager) {
        self.storageManager = storageManager
        self.sources = storageManager.retrieveSourcesList()
        updateFeed(completion: nil)
    }
}

extension NewsProvider: SourcesManager {
    func sourcesList() -> [Source] {
        return sources
    }
}

extension NewsProvider: AddingSource {
    func add(source: SourceDataObject, completion: @escaping (_ success: Bool)->()) {
        let newSource = Source(name: source.sourceName, url: source.sourceURL)
        networkManager.loadFeed(source: newSource) { (source) in
            if let loadedSource = source {
                self.sources.append(loadedSource)
                self.storageManager.store(source: loadedSource)
                self.storageManager.store(idsList: self.sources.map({ (source) -> UUID in return source.sourceID }))
            }
            completion(source != nil)
        }
    }
}

extension NewsProvider: FeedManager {
    func updateFeed(completion: ((Bool) -> ())?) {
        let downloadGroup = DispatchGroup()
        for source in sources {
            downloadGroup.enter()
            networkManager.updateFeed(source: source) { (success) in
                downloadGroup.leave()
            }
        }
        
        downloadGroup.notify(queue: DispatchQueue.main) {
            if let completionBlock = completion {
                completionBlock(true)
            }
        }
    }
}

extension NewsProvider: EditingSource {
    func updateSource(sourceID: UUID, dataObject: SourceDataObject, completion: @escaping (_ success: Bool)->()) {
        let oldItemIndex = sources.firstIndex { (source) -> Bool in
            return source.sourceID == sourceID
        }
        
        guard let index = oldItemIndex else {
            fatalError("Fatal sources array inconsistency")
        }
        
        let editedSource = Source(name: dataObject.sourceName, url: dataObject.sourceURL, sourceID: sourceID)
        networkManager.loadFeed(source: editedSource) { (source) in
            if let newSource = source {
                self.sources.remove(at: index)
                self.sources.insert(newSource, at: index)
                completion(true)
            } else {
                completion(false)
            }
        }
        
    }
    
    func sourceDataObject(sourceID: UUID) -> SourceDataObject? {
        let itemWithID = sources.filter({ (source) -> Bool in
            return source.sourceID == sourceID
        }).first
        
        guard let source = itemWithID else {
            return nil
        }
        
        return SourceDataObject(sourceName: source.name, sourceURL: source.url)
    }
}
