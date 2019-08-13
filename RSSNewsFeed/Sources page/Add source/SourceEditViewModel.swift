//
//  SourceEditViewModel.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 11/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation

protocol SourceEditViewModel {
    func saveSource(name: String?, urlString: String?, completion: @escaping (_ error: AddSourceError?)->())
    var editingSource: SourceDataObject? {get}
}
