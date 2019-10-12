//
//  UpcomingMoviesCoordinator.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 11/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class UpcomingMoviesCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showUpcomingMoviesViewController()
    }
    
    func showUpcomingMoviesViewController()  {
        let viewModel = UpcomingMovieViewModel()
        let controller = UpcomingMoviesViewController(viewModel: viewModel)
        self.navigationController.pushViewController(controller, animated: true)
    }
}
