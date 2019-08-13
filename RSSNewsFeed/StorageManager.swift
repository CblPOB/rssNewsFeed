//
//  StorageManager.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 11/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation

protocol StorageManager {
    func retrieveSourcesList() -> [Source]
    func store(source: Source)
    func store(idsList: [UUID])
}
