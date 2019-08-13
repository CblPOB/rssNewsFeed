//
//  UserDefaultsStorageService.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 11/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation

struct SourceStoreObject: Codable {
    let sourceID: UUID
    let sourceName: String
    let sourceLink: String
}

class UserDefaultsStorageService: StorageManager {
    let idsKey = "ids"
    
    func  retrieveSourcesList() -> [Source] {
        guard let retrievedData = UserDefaults.standard.array(forKey: idsKey) else {
            return [Source]()
        }
        
        let sourcesIDs = retrievedData as! [String]
        var sources = [Source]()
        for id in sourcesIDs {
            do {
                let sourceStoredObject = try JSONDecoder().decode(SourceStoreObject.self, from: UserDefaults.standard.data(forKey: id)!)
                sources.append(Source(name: sourceStoredObject.sourceName, url: URL(string: sourceStoredObject.sourceLink)!, sourceID: sourceStoredObject.sourceID))
            } catch {
                fatalError()
            }
        }
        
        return sources
    }
    
    func store(source: Source) {
        let sourceStoredObject = SourceStoreObject(sourceID: source.sourceID, sourceName: source.name, sourceLink: source.url.absoluteString)
        do {
            let data = try JSONEncoder().encode(sourceStoredObject)
            UserDefaults.standard.set(data, forKey: source.sourceID.uuidString)
        } catch {
            fatalError()
        }
    }
    
    func store(idsList: [UUID]) {
        let idsStringsList = idsList.map { (id) -> String in
            return id.uuidString
        }
        
        UserDefaults.standard.set(idsStringsList, forKey: idsKey)
    }
}

