//
//  SourcesTableViewCell.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 10/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

struct SourceCellDataObject {
    let sourceName: String
    let sourcePictureURL: URL?
}

class SourcesTableViewCell: UITableViewCell {
    @IBOutlet weak var sourcePictureImageView: UIImageView!
    @IBOutlet weak var sourceNameLabel: UILabel!

    func configure(dataObject: SourceCellDataObject) {
        sourcePictureImageView.kf.setImage(with: dataObject.sourcePictureURL)
        sourceNameLabel.text = dataObject.sourceName
        selectionStyle = .none
    }
}
