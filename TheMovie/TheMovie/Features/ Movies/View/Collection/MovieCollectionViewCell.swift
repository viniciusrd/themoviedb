//
//  MovieCollectionViewCell.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 11/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backGroundView: CustomView!
    @IBOutlet weak var ivCoverMovie: UIImageView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var lbNameMovie: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backGroundView.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        ivCoverMovie.image = nil
        lbNameMovie.text = nil
    }
    
    func hideAnimetion() {
    }
    
    func setup(withMovie movie: Movie) {
        if let posterURL =  movie.posterPath {
            ivCoverMovie.setImageFromURL(toPath: posterURL, toType: .compressedImage, completion: { (complete) in
                DispatchQueue.main.async() {
                    if complete, self.aiLoading.isAnimating{
                        self.aiLoading.stopAnimating()
                        self.aiLoading.isHidden = true
                    }
                }
            })
        }else{
            ivCoverMovie.isHidden = true
        }
        lbNameMovie.text = movie.originalTitle
    }
    
}
