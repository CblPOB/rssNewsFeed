//
//  AppCoordinator.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 10/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
    var rootCoordinator: Coordinator {get}
    var rootController: UIViewController {get}
}

enum ChildCoordinator: String {
    case sources = "sources"
    case feed = "feed"
}

class AppCoordinator: Coordinator {
    private let rootViewController: UITabBarController
    private let newsProvider: NewsProvider
    var rootController: UIViewController {
        return rootViewController
    }
    
    var rootCoordinator: Coordinator {
        return self
    }
    
    private var childCoordinators = [ChildCoordinator: Coordinator]()
    
    init() {
        rootViewController = UITabBarController()
        newsProvider = NewsProvider(storageManager: UserDefaultsStorageService())
    }
    
    func start() {
        let sourcesCoordinator = SourcesPageCoordinator(rootCoordinator: self)
        let feedCoordinator = FeedPageCoordinator(rootCoordinator: self)
        
        sourcesCoordinator.newsProvider = newsProvider
        feedCoordinator.newsProvider = newsProvider
        
        let sourcesViewController = sourcesCoordinator.rootController
        let feedViewController = feedCoordinator.rootController
        
        sourcesCoordinator.start()
        feedCoordinator.start()
        
        sourcesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        feedViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        let tabBarViewControllers = [sourcesCoordinator.rootController, feedCoordinator.rootController]
        rootViewController.viewControllers = tabBarViewControllers
        
    }
}


