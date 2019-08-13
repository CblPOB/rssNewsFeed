//
//  FeedTableViewCell.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 11/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation
import UIKit

struct FeedCellDataObject {
    let title: String
    let date: String?
}

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(dataObject: FeedCellDataObject) {
        articleTitle.text = dataObject.title
        dateLabel.text = dataObject.date
        selectionStyle = .none
    }
}
