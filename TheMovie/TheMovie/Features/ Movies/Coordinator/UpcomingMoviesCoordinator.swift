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
        viewModel.coodinatorDelegate = self
        self.navigationController.pushViewController(controller, animated: true)
    }
}

extension UpcomingMoviesCoordinator: UpcomingViewModelCoordinadorDelegate{
    
    func showErrorUpcomingMovie(withError error: Error) {
        DispatchQueue.main.async {
            let alert = AlertHelper(withTitle: "Ops", withMessage: error.localizedDescription)
            self.navigationController.present(alert.showWarning(), animated: true, completion: nil)
        }
    }
    
    func didSelectedMovie(movie: Movie, from viewController: UIViewController) {
        print("Selected movie \(movie.originalTitle ?? "Not found name")")
        showMovieDetailsViewController(withMovie: movie)
    }
}

extension UpcomingMoviesCoordinator: MovieDetailsCoordinatorDelegate{
    func showMoreAboutMovie(withUrl url: String?, from viewController: UIViewController) {
        guard let homepage = url, let url = URL(string: homepage) else {
            let alert = AlertHelper(withTitle: "Ops", withMessage: "Unable to retrieve url for selected movie")
            self.navigationController.present(alert.showWarning(), animated: true, completion: nil)
            return
        }
        UIApplication.shared.open(url)
    }
    
    func showErrorMovieDetails(withError error: Error) {
        DispatchQueue.main.async {
            let alert = AlertHelper(withTitle: "Ops", withMessage: error.localizedDescription)
            self.navigationController.present(alert.showWarning(), animated: true, completion: nil)
        }
    }
    
    
}
