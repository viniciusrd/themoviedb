//
//  MovieDetailsViewModelType.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 12/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
protocol MovieDetailsViewModelType {
    
    var movieId: Int { get set }
//    var movieDetails: MovieDetails { get set }
    var headerText: String { get }
    
    func viewDidLoad()
}
