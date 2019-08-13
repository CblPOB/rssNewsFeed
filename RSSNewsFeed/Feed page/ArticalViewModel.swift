//
//  ArticalViewModel.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 11/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation

class ArticalViewModel {
    private let articalDataObject: ArticalDataObject
    var articalContent: String {
        return articalDataObject.articalContent
    }
    
    init(article: ArticalDataObject) {
        articalDataObject = article
    }
}
