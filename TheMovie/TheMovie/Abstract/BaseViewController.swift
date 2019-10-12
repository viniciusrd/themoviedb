//
//  BaseViewController.swift
//  TheMovie
//
//  Created by Vinicius Rodrigues on 11/10/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class BaseViewController<T>: UIViewController {

    private(set) var viewModel: T
    
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: T) {}
}
