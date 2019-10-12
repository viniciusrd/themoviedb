//
//  Constants.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 11/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
import UIKit

enum TypeImage {
    case compressedImage
    case fullImage
}

struct Constants {

    static let scheme = "https"
    static let movieHost = "api.themoviedb.org"
    static let movieVersionAPI = "/3"
    static let movieApiKey = "c5850ed73901b8d268d0898a8a9d8bff"
    static let language = "en-US"
    
    static func movieImageHost(type: TypeImage) -> String{
        var path = ""
        switch type{
        case .compressedImage:
            path = "w500/"
        case .fullImage:
            path = "original/"
        }
        return "https://image.tmdb.org/t/p/"+path
    }
    
}

struct Colors {
    static let appBarTintColor = #colorLiteral(red: 0, green: 0.8320397735, blue: 0.457329154, alpha: 1)
    static let appBarTextTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}
