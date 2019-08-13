//
//  ArticleViewController.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 11/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation
import UIKit

class ArticalViewController: UIViewController {
    var viewModel: ArticalViewModel!
    @IBOutlet weak var articleTextView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        articleTextView.text = viewModel.articalContent
    }
    
}
