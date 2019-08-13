//
//  SourcesViewModel.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 10/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation

protocol SourcesDelegate: class {
    func addSource()
    func editSource(sourceID: UUID)
}

class SourcesViewModel {
    var delegate: SourcesDelegate?
    var sourcesManager: SourcesManager?
    private var sourcesList: [Source] {
        if let manager = sourcesManager {
            return manager.sourcesList()
        } else {
            return [Source]()
        }
    }
    var numberOfItems: Int {
        return sourcesList.count
    }
    
    func itemForIndex(index: Int) -> SourceCellDataObject {
        let selectedItem = sourcesList[index]
        return SourceCellDataObject(sourceName: selectedItem.name, sourcePictureURL: selectedItem.pictureURL)
    }
    
    func selectedItem(index: Int) {
        delegate?.editSource(sourceID: sourcesList[index].sourceID)
    }
    
    func selectedAddSource() {
        delegate!.addSource()
    }
}
