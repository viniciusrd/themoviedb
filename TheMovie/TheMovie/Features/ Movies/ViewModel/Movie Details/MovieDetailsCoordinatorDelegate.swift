//
//  MovieDetailsCoordinatorDelegate.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 12/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
protocol MovieDetailsCoordinatorDelegate: class {
    func showErrorMovieDetails(withError error: Error)
    func showMoreAboutMovie(withUrl url: String?, from viewController: UIViewController)
}
