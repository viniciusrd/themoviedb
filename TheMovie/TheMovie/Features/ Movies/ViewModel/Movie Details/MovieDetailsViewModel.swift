//
//  MovieDetailsViewModel.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 12/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
class MovieDetailsViewModel: MovieDetailsViewModelType {
    var movieId: Int
    
    
    
    init(id: Int) {
        self.movieId = id
    }
    
    var headerText: String = ""
    
    
    
    func viewDidLoad() {
        
    }
    
    
}
