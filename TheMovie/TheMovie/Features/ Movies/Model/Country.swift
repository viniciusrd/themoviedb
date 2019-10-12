//
//  Country.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 11/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
struct Country: Codable {
    let id: String
    let name: String
    enum CodingKeys: String, CodingKey {
        case id = "iso_3166_1"
        case name = "name"
    }
}
