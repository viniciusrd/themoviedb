//
//  MovieDetailsViewModel.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 12/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
class MovieDetailsViewModel: MovieDetailsViewModelType {
   
    var movieAPI: APIMovieProtocol{
        return APIMovieDefault()
    }
    
    var movie: MovieDetails?
    
    var movieId: Int
    
    weak var coodinatorDelegate: MovieDetailsCoordinatorDelegate?
    weak var viewModelDelegate: MovieDetailsViewModelDelegate?
    
    init(id: Int) {
        self.movieId = id
    }
    
    var headerText: String {
        return "Movie Details"
    }
    
    
    
    func viewDidLoad() {
        movieDetails()
    }
    
    func movieDetails()  {
        viewModelDelegate?.startRequest()
        movieAPI.movieDetails(forMovie: movieId) { (response) in
            self.viewModelDelegate?.endRequest()
            switch response{
            case .success(let response):
                guard let movieDetails = response else { return }
                self.movie = movieDetails
                self.viewModelDelegate?.updateScreen()
            case .failure(let error):
                guard let error = error else { return }
                print(error.localizedDescription)
            }
        }
    }
    
    
}
