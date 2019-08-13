//
//  AddSourceViewModel.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 10/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation

enum AddSourceError: String {
    case invalidName = "Invalid source name"
    case invalidURL = "Invalid source URL"
}

struct SourceDataObject {
    let sourceName: String
    let sourceURL: URL
}

protocol AddSourceDelegate: class {
    func back()
}

class AddSourceViewModel: SourceEditViewModel {
    var editingSource: SourceDataObject? {
        return nil
    }
    
    weak var delegate: AddSourceDelegate?
    var addSourceService: AddingSource?
    
    func saveSource(name: String?, urlString: String?, completion: @escaping (_ error: AddSourceError?)->()) {
        guard let sourceName = name else {
            completion(.invalidName)
            return
        }
        
        guard let sourceURLString = urlString, let sourceURL = URL(string: sourceURLString) else {
            completion(.invalidURL)
            return
        }
        
        addSourceService?.add(source: SourceDataObject(sourceName: sourceName, sourceURL: sourceURL), completion: { (success) in
            completion(success ? nil : .invalidURL)
            DispatchQueue.main.async {
                if success {
                    self.delegate?.back()
                }
            }
        })
    }
}
