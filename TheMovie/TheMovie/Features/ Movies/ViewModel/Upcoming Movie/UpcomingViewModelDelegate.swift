//
//  UpcomingViewModelDelegate.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 12/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
protocol UpcomingViewModelDelegate: class {
    func updateScreen()
    func startRequest()
    func endRequest()
}
