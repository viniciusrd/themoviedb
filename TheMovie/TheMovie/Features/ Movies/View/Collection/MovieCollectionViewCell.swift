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
        ivCoverMovie.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        ivCoverMovie.image = nil
        lbNameMovie.text = nil
    }
    
    func setup(withMovie movie: Movie) {
        
    }
    
}
