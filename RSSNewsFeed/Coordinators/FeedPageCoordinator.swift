//
//  FeedPageCoordinator.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 10/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation
import UIKit

class FeedPageCoordinator: Coordinator {
    
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
        let feedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as? FeedViewController
        let feedViewModel = FeedViewModel()
        feedViewModel.feedManager = newsProvider
        feedViewModel.delegate = self
        feedViewController?.viewModel = feedViewModel
        if let viewController = feedViewController {
            rootViewController = UINavigationController(rootViewController: viewController)
        } else {
            rootViewController = UINavigationController()
        }
    }
}

extension FeedPageCoordinator: FeedDelegate {
    func showArtical(dataObject: ArticalDataObject) {
        if let articalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Artical") as? ArticalViewController {
            articalViewController.viewModel = ArticalViewModel(article: dataObject)
            rootViewController.pushViewController(articalViewController, animated: true)
        }
    }
}
