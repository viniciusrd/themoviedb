//
//  UpcomingMoviesViewController.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 11/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class UpcomingMoviesViewController: BaseViewController<UpcomingMovieViewModel> {

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let reuseIdentifier = String(describing: MovieCollectionViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - UICollectionViewDelegate

extension UpcomingMoviesViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")

    }
}

// MARK: - UICollectionViewDataSource

extension UpcomingMoviesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension UpcomingMoviesViewController: UICollectionViewDelegateFlowLayout {
    ///Set  size of the cell for collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 16
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 250)
    }
}
