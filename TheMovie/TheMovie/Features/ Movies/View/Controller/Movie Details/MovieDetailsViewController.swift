//
//  MovieDetailsViewController.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 12/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
import ViewAnimator

class MovieDetailsViewController: BaseViewController<MovieDetailsViewModel> {

    
    @IBOutlet weak var scroolView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var coverView: CustomView!
    @IBOutlet weak var ivCoverMovie: UIImageView!
    @IBOutlet weak var svInfo: UIStackView!
    @IBOutlet weak var svTitle: UIStackView!
    @IBOutlet weak var svViewReleased: UIStackView!
    @IBOutlet weak var svOverview: UIStackView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubtitle: UILabel!
    @IBOutlet weak var lbReleased: UILabel!
    @IBOutlet weak var lbDescription: CustomLabel!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var btnMoreAbout: CustomButton!
    @IBOutlet weak var constraintTopSvInfo: NSLayoutConstraint!
    
    
    @IBOutlet weak var lbRuntime: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbVoteCount: UILabel!
    
    @IBOutlet weak var lbStatus: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
        viewModel.viewModelDelegate = self
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func setupUI()  {
        super.setupUI()
        self.ivCoverMovie.isHidden = true
        self.svInfo.isHidden = true
        self.svOverview.isHidden = true
        self.btnMoreAbout.isHidden = true
        self.coverView.isHidden = true
        self.constraintTopSvInfo.constant = 0

        self.lbTitle.alpha = 0.0
        self.lbSubtitle.alpha = 0.0
        self.lbStatus.alpha = 0.0
        self.lbReleased.alpha = 0.0
        
    }
    
    func updateUI(withMovie movie: MovieDetails) {
        DispatchQueue.main.async {
            self.ivCoverMovie.setImageFromURL(toPath: movie.posterPath, toType: .fullImage) { (completed) in
                DispatchQueue.main.async {
                    
                    UIView.transition(with: self.view, duration: 2.5, options: .transitionCrossDissolve, animations: {
                        self.svInfo.isHidden = false
                        self.coverView.isHidden = false
                        self.ivCoverMovie.isHidden = false
                        self.svOverview.isHidden = false
                        self.ivCoverMovie.isHidden = false
                        self.btnMoreAbout.isHidden = false
                        UIView.animate(withDuration: 2.5) {
                            self.constraintTopSvInfo.constant = -20
                            self.lbTitle.alpha = 1.0
                            self.lbSubtitle.alpha = 1.0
                            self.lbStatus.alpha = 1.0
                            self.lbReleased.alpha = 1.0
                            
                            self.view.layoutIfNeeded();
                        }
                    })
                }
            }
            self.lbTitle.text = movie.title
            self.lbSubtitle.text = movie.tagline
            self.lbStatus.text = "\(movie.status ?? ""): "
            self.lbDescription.text = movie.overview
            self.lbGenre.text = movie.genres[0].name
            self.lbReleased.text = movie.releaseDate
            self.lbRuntime.text = "\(movie.runtime) min"
            self.lbVoteCount.text = String(movie.voteCount)
            
            self.navigationController?.navigationBar.topItem?.title = movie.title
        }
        
    }
    @IBAction func tapMoreAbout(_ sender: Any) {
        viewModel.didTapButtonMoreAbout(from: self)
    }
}

extension MovieDetailsViewController: MovieDetailsViewModelDelegate{
    func updateScreen() {
        guard let movie = viewModel.movie else {return}
        self.updateUI(withMovie: movie)
    }
    
    func startRequest() {
        DispatchQueue.main.async {
            self.aiLoading.startAnimating()
        }
    }
    
    func endRequest() {
        DispatchQueue.main.async {
            self.aiLoading.stopAnimating()
            self.aiLoading.isHidden = true
        }
    }
}
