//
//  UpcomingViewModelType.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 12/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
protocol UpcomingViewModelType {
    
    var movieAPI: APIMovieProtocol { get }
    var movies: [Movie] { get set}
    
    var headerText: String { get }
    
    func viewDidLoad()
    func searchFor(text: String)
    func didSelectRow(_ row: Int, from controller: UIViewController)
    func numberOfItems() -> Int
}
