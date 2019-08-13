//
//  EditSourceViewModel.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 11/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation

protocol EditSourceDelegate: class {
    func back()
}

class EditSourceViewModel: SourceEditViewModel {
    
    weak var delegate: EditSourceDelegate?
    var editingService: EditingSource?
    private let editingObject: SourceDataObject
    
    var editingSource: SourceDataObject? {
        return editingObject
    }
    
    private let editingSourceID: UUID
    
    init(sourceToEdit: SourceDataObject, sourceID: UUID) {
        editingObject = sourceToEdit
        editingSourceID = sourceID
    }
    
    func saveSource(name: String?, urlString: String?, completion: @escaping (AddSourceError?) -> ()) {
        guard let sourceName = name else {
            completion(.invalidName)
            return
        }
        
        guard let sourceURLString = urlString, let sourceURL = URL(string: sourceURLString) else {
            completion(.invalidURL)
            return
        }
        
        editingService?.updateSource(sourceID: editingSourceID, dataObject: SourceDataObject(sourceName: sourceName, sourceURL: sourceURL), completion: { (success) in
            completion(success ? nil : .invalidURL)
            DispatchQueue.main.async {
                if success {
                    self.delegate?.back()
                }
            }
        })
    }
}
