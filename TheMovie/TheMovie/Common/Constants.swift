//
//  Constants.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 11/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation

enum TypeImage {
    case compressedImage
    case fullImage
}

struct Constants {

    static let scheme = "https"
    static let movieHost = "api.themoviedb.org"
    static let movieVersionAPI = "/3"
    static let movieApiKey = "c5850ed73901b8d268d0898a8a9d8bff"
    
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
