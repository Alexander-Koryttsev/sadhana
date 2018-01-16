//
//  NavigationVC.swift
//  Sadhana
//
//  Created by Alexander Koryttsev on 7/13/17.
//  Copyright © 2017 Alexander Koryttsev. All rights reserved.
//

import UIKit

class NavigationVC: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11, *) {
            navigationBar.prefersLargeTitles = true
        }
    }
}
