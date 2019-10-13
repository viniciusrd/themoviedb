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
    
    @IBOutlet weak var svBottomLoading: UIStackView!
    @IBOutlet weak var aiBottomLoading: UIActivityIndicatorView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var constraintBottomSvLoading: NSLayoutConstraint!
    
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
//        self.navigationController?.navigationBar.topItem?.title = viewModel.headerText
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let imageSearch = UIImage(named: "icSearchCopy")
        let searchBarButtonItem = UIBarButtonItem(image: imageSearch, style: .done, target: self, action: #selector(self.createSearchBar))
        self.navigationItem.setRightBarButton(searchBarButtonItem, animated: true)
        self.navigationItem.rightBarButtonItem?.style = .plain
        self.navigationItem.hidesSearchBarWhenScrolling = true
        
        self.navigationController?.navigationBar.topItem?.title = viewModel.headerText
    }
    
    
    @objc func createSearchBar()  {
        
        let searchBar = UISearchBar()
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        searchBar.barTintColor = .black
        searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchBar
        self.navigationItem.setRightBarButton(nil, animated: true)
    }
    
    func reloadData()  {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
//            self.animationCollectionView()
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
//        animationCollectionView()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.numberOfItems() - 1 {
            print("last cell \(indexPath.row) ")
            self.svBottomLoading.isHidden = false
            self.aiBottomLoading.startAnimating()
            self.constraintBottomSvLoading.constant = 22
            guard let page = self.viewModel.pagination?.page else { return }
            self.viewModel.pagination?.page = page + 1
            self.viewModel.upcomingMovies()
            
        }else{
            self.svBottomLoading.isHidden = true
            self.aiBottomLoading.stopAnimating()
            self.constraintBottomSvLoading.constant = -90
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension UpcomingMoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 16
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        if screenSize.width >= 414 && screenSize.height >= 896{
            return CGSize(width: 180, height: 250)
        }else{
             return CGSize(width: 160, height: 230)
        }
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

extension UpcomingMoviesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchText = searchText
        print(self.viewModel.searchText ?? "empty")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = self.viewModel.searchText, !searchText.isEmpty {
            self.viewModel.searchMovie(searchText: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        UIView.transition(with: self.view, duration: 2.5, options: .transitionCrossDissolve, animations: {
            searchBar.isHidden = true
            self.setupNavigationBar()
            self.view.layoutIfNeeded()
        })
        searchBar.resignFirstResponder()
        self.viewModel.searchText = ""
    }
}
