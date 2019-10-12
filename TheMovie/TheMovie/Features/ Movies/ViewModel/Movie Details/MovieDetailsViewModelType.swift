//
//  MovieDetailsViewModelType.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 12/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
protocol MovieDetailsViewModelType {
    var movieAPI: APIMovieProtocol { get }
    var movie: MovieDetails? { get set }
    
    var movieId: Int { get set }
    var headerText: String { get }
    
    func viewDidLoad()
}
