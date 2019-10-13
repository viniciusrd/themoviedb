//
//  UpcomingViewModelCoordinadorDelegate.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 12/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
protocol UpcomingViewModelCoordinadorDelegate: class {
    func showErrorUpcomingMovie(withError error: Error)
    func didSelectedMovie(movie: Movie, from viewController: UIViewController)
}
