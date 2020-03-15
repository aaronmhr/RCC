//
//  TestViewController.swift
//  RCC
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit

final class TestViewController: UIViewController {
    private var viewModel: TestViewModel?

    convenience init(viewModel: TestViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}

final class TestViewModel {
    
}
