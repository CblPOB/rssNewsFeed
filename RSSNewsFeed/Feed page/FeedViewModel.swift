//
//  FeedViewModel.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 10/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation

protocol FeedDelegate: class {
    func showArtical(dataObject: ArticalDataObject)
}

struct ArticalDataObject {
    let articalContent: String
}

class FeedViewModel {
    var feedManager: FeedManager?
    var delegate: FeedDelegate?
    
    private var sourcesList: [Source] {
        if let manager = feedManager {
            return manager.sourcesList()
        } else {
            return [Source]()
        }
    }
    
    var numberOfSections: Int {
        return sourcesList.count
    }
    
    func numberOfItems(sectionIndex: Int) -> Int {
        if let items = sourcesList[sectionIndex].feedItems {
            return items.count
        } else {
            return 0
        }
    }
    
    func updateFeed(completion:@escaping (_ success: Bool)->()) {
        feedManager?.updateFeed(completion: { (success) in
            completion(success)
        })
    }
    
    func itemDataObject(section: Int, row: Int) -> FeedCellDataObject {
        let item = sourcesList[section].feedItems![row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let dateString = dateFormatter.string(from: item.pubDate!)
    
        return FeedCellDataObject(title:  item.title ?? "", date: dateString)
    }
    
    func sectionTitle(index: Int) -> String {
        return sourcesList[index].name
    }
    
    func sectionsTitles() -> [String] {
        let titles = sourcesList.map { (source) -> String in
            return source.name
        }
        return titles
    }
    
    func selectedItem(index: Int, section: Int) {
        let item = sourcesList[section].feedItems![index]
        delegate?.showArtical(dataObject: ArticalDataObject(articalContent: item.description!))
    }
}
