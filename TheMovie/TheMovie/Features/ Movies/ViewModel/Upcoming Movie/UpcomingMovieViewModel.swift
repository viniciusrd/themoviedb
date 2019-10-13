//
//  UpcomingMovieViewModel.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 11/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
class UpcomingMovieViewModel: UpcomingViewModelType {
    //Mark: - Delegates
    
    weak var coodinatorDelegate: UpcomingViewModelCoordinadorDelegate?
    weak var viewModelDelegate: UpcomingViewModelDelegate?
    
    //Mark: - Properties
    
    static let reuseIdentifier = String(describing: MovieCollectionViewCell.self)
    
    var movieAPI: APIMovieProtocol{
        return APIMovieDefault()
    }
    
    var movies: [Movie] = []
    
    var headerText: String{
        return "Movies"
    }
    
    var searchText: String?
    
    var pagination: Pagination?
    
    init() {
        self.pagination = Pagination(page: 1, totalResults: 0, totalPage: 0)
    }
    
    func viewDidLoad() {
        upcomingMovies()
    }
    
    func upcomingMovies(){
        viewModelDelegate?.startRequest()
        guard let pagination = self.pagination else { return }
        movieAPI.upcomingMovies(forPage: String(pagination.page), forLanguage: Constants.language) { (response) in
            self.viewModelDelegate?.endRequest()
            switch response{
            case .success(let response):
                guard let response = response else { return }
                self.pagination = Pagination(page: response.page, totalResults: response.totalResults, totalPage: response.totalPage)
                if self.pagination?.page ?? 1 > 1{
                    print(response.movies)
                    self.movies = response.movies
                }else{
                    self.movies = response.movies
                }
                self.viewModelDelegate?.updateScreen()
            case .failure(let error):
                guard let error = error else { return }
                print(error.localizedDescription)
                self.coodinatorDelegate?.showErrorUpcomingMovie(withError: error)
            }
        }
    }
    
    func searchMovie(searchText: String) {
        let query =  QueryMovie(language: "en-US", page: 1, adult: false, query: searchText)
        viewModelDelegate?.startRequest()
        movieAPI.searchMovie(forQuery: query) { (response) in
            self.viewModelDelegate?.endRequest()
            switch response{
            case .success(let response):
                guard let response = response else { return }
                self.movies = response.movies
                self.viewModelDelegate?.updateScreen()
            case .failure(let error):
                guard let error = error else{ return }
                print(error.localizedDescription)
                self.coodinatorDelegate?.showErrorUpcomingMovie(withError: error)
            }
        }
    }
    
    func numberOfItems() -> Int {
        return movies.count
    }
    
    func didSelectRow(_ row: Int, from controller: UIViewController) {
        let movieSelect = self.movies[row] 
        coodinatorDelegate?.didSelectedMovie(movie: movieSelect, from: controller)
    }
    
    
    
 
    
    
    
    
    
}
