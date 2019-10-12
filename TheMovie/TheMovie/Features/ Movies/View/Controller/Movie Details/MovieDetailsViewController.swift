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
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var coverView: CustomView!
    @IBOutlet weak var ivCoverMovie: UIImageView!
    
    @IBOutlet weak var svInfo: UIStackView!
    
    @IBOutlet weak var contentContainerView: CustomView!
    @IBOutlet weak var svTitle: UIStackView!
    @IBOutlet weak var svViewReleased: UIStackView!
    @IBOutlet weak var svOverview: UIStackView!
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubtitle: UILabel!
    
    @IBOutlet weak var lbReleased: UILabel!
    @IBOutlet weak var lbDescription: CustomLabel!
    
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    
    @IBOutlet weak var btnMoreAbout: CustomButton!
    
    @IBOutlet weak var contraintTopSvInfo: NSLayoutConstraint!
    @IBOutlet weak var constraintTopContentView: NSLayoutConstraint!
    @IBOutlet weak var contraintTopButton: NSLayoutConstraint!
    @IBOutlet weak var constraintBottomButton: NSLayoutConstraint!
    
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
    
//    override func setupNavigationBar() {
//        super.setupNavigationBar()
//       
//    }
    
    override func setupUI()  {
        super.setupUI()
         self.navigationController?.navigationBar.topItem?.title = viewModel.headerText
        self.ivCoverMovie.isHidden = true
        self.svInfo.isHidden = true
        self.svOverview.isHidden = true
        self.btnMoreAbout.isHidden = true
        self.containerView.isHidden = true
        self.contraintTopSvInfo.constant = 0
        self.constraintBottomButton.constant = -40
        
        self.btnMoreAbout.frame = CGRect(x: 100, y: 100, width: 0, height: 0)
        
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
                        self.ivCoverMovie.isHidden = false
                        UIView.animate(withDuration: 2.5) {
                            self.contraintTopSvInfo.constant = -20
                            self.svInfo.isHidden = false
                            self.svOverview.isHidden = false
                            self.containerView.isHidden = false
                            self.lbTitle.alpha = 1.0
                            self.lbSubtitle.alpha = 1.0
                            self.lbStatus.alpha = 1.0
                            self.lbReleased.alpha = 1.0
                            
                            self.btnMoreAbout.isHidden = false
                            self.constraintBottomButton.constant = 22

                            self.view.layoutIfNeeded();
                        }
                    })
                    
                }
            }
            self.lbTitle.text = movie.originalTitle
            self.lbSubtitle.text = movie.tagline
            self.lbStatus.text = "\(movie.status): "
            self.lbDescription.text = movie.overview
            self.lbGenre.text = movie.genres[0].name
            self.lbReleased.text = movie.releaseDate
            self.lbRuntime.text = "\(movie.runtime) min"
            self.lbVoteCount.text = String(movie.voteCount)
            
        }
    }
    @IBAction func tapMoreAbout(_ sender: Any) {
        
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
