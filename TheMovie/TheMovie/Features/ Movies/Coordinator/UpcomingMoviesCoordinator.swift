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
        viewModel.coodinatorDelegate = self
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    func showMovieDetailsViewController(withMovie movie: Movie) {
        let viewModel = MovieDetailsViewModel(id: movie.id)
        let controller = MovieDetailsViewController(viewModel: viewModel)
        self.navigationController.pushViewController(controller, animated: true)
    }
}

extension UpcomingMoviesCoordinator: UpcomingViewModelCoordinadorDelegate{
    func didSelectedMovie(movie: Movie, from viewController: UIViewController) {
        print("Selected movie \(movie.originalTitle ?? "Not found name")")
        showMovieDetailsViewController(withMovie: movie)
    }
}
