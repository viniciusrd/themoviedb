//
//  AppCoordinator.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 11/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    let rootViewController: UINavigationController
    let upcomingMoviesCoordinator: UpcomingMoviesCoordinator
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.window.rootViewController = self.rootViewController
        self.upcomingMoviesCoordinator = UpcomingMoviesCoordinator(navigationController: rootViewController)
    }
    
    func start() {
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
        self.upcomingMoviesCoordinator.start()
    }
}
