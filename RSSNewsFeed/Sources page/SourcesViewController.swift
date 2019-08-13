//
//  SourcesViewController.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 10/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation
import UIKit

class SourcesViewController: UIViewController {
    @IBOutlet weak var sourcesTableView: UITableView!
    var viewModel: SourcesViewModel!
    
    override func viewDidLoad() {
        sourcesTableView.tableFooterView = UIView()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sourcesTableView.reloadData()
    }
}

extension SourcesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewModel.numberOfItems {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "addSource") else {
                fatalError("Can't dequeue cell with identifier addSource")
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "sourceCell") as? SourcesTableViewCell else {
                fatalError("Can't dequeue cell with identifier sourceCell")
            }
            
            cell.configure(dataObject: viewModel.itemForIndex(index: indexPath.row))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case viewModel.numberOfItems:
            viewModel.selectedAddSource()
        default:
            viewModel.selectedItem(index: indexPath.row)
        }
    }
}
