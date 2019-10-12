//
//  UpcomingMoviesViewController.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 11/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
import ViewAnimator

class UpcomingMoviesViewController: BaseViewController<UpcomingMovieViewModel> {

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    
    let reuseIdentifier = String(describing: MovieCollectionViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        viewModel.viewDidLoad()
        viewModel.viewModelDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = viewModel.headerText
    }
    
//    override func setupNavigationBar() {
//        super.setupNavigationBar()
//        
//    }
    
    func reloadData()  {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.animationCollectionView()
        }
    }
    
    func animationCollectionView()  {
        //collectionView.
        let diractionAnimation = AnimationType.from(direction: .bottom, offset: 30.0)
        UIView.animate(views: collectionView.visibleCells,
                           animations: [diractionAnimation],
                           duration: 0.5)
        
    }
}

// MARK: - UICollectionViewDelegate

extension UpcomingMoviesViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath.row, from: self)
    }
}

// MARK: - UICollectionViewDataSource

extension UpcomingMoviesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
        let movie = viewModel.movies[indexPath.row]
        cell.setup(withMovie: movie)
        animationCollectionView()
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension UpcomingMoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 18
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 250)
    }
}

extension UpcomingMoviesViewController: UpcomingViewModelDelegate{
    func updateScreen() {
        self.reloadData()
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
