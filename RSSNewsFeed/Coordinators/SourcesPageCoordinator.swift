//
//  SourcesPageCoordinator.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 10/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation
import UIKit

class SourcesPageCoordinator: Coordinator {
    private let parentCoordinator: Coordinator
    private var rootViewController: UINavigationController
    var newsProvider: NewsProvider?
    var rootCoordinator: Coordinator {
        return parentCoordinator
    }
    
    var rootController: UIViewController {
        return rootViewController
    }
    
    init(rootCoordinator: Coordinator) {
        parentCoordinator = rootCoordinator
        rootViewController = UINavigationController()
    }
    
    func start() {
        let sourcesViewModel = SourcesViewModel()
        sourcesViewModel.sourcesManager = newsProvider
        sourcesViewModel.delegate = self
        
        let sourcesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SourcesViewController") as? SourcesViewController
        sourcesViewController?.viewModel = sourcesViewModel
        
        if let viewController = sourcesViewController {
            rootViewController = UINavigationController(rootViewController: viewController)
        } else {
            rootViewController = UINavigationController()
        }
    }
}

extension SourcesPageCoordinator: SourcesDelegate {
    func editSource(sourceID: UUID) {
        if let editSourceViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditSource") as? AddSourceViewController {
            guard let dataObject = newsProvider?.sourceDataObject(sourceID: sourceID) else {
                fatalError("Fatal inconsistency in sources array")
            }
            let editSourceViewModel = EditSourceViewModel(sourceToEdit: dataObject, sourceID: sourceID)
            editSourceViewModel.delegate = self
            editSourceViewModel.editingService = newsProvider
            editSourceViewController.viewModel = editSourceViewModel
            rootViewController.pushViewController(editSourceViewController, animated: true)
        }
    }
    
    func addSource() {
        if let addSourceViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditSource") as? AddSourceViewController {
            let addSourceViewModel = AddSourceViewModel()
            addSourceViewModel.delegate = self
            addSourceViewModel.addSourceService = newsProvider
            addSourceViewController.viewModel = addSourceViewModel
            rootViewController.pushViewController(addSourceViewController, animated: true)
        }
    }
}

extension SourcesPageCoordinator: AddSourceDelegate & EditSourceDelegate {
    func back() {
        rootViewController.popViewController(animated: true)
    }
}
