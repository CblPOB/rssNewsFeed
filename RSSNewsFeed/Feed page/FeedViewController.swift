//
//  FeedViewController.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 10/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class FeedViewController: UIViewController {
    @IBOutlet weak var feedTableView: UITableView!
    var viewModel: FeedViewModel!
    
    override func viewDidLoad() {
        feedTableView.tableFooterView = UIView()
        MBProgressHUD.showAdded(to: view, animated: true)
        viewModel.updateFeed { (success) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                if (success) {
                    self.feedTableView.reloadData()
                }
            }
        }
        super.viewDidLoad()
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(sectionIndex: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedTableViewCell else {
            fatalError("Can't dequeue cell with identifier feedCell")
        }
        
        cell.configure(dataObject: viewModel.itemDataObject(section: indexPath.section, row: indexPath.row))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle(index: section)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.sectionsTitles()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedItem(index: indexPath.row, section: indexPath.section)
    }
    
}
