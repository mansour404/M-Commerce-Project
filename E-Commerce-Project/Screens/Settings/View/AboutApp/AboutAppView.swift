//
//  AboutAppView.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import UIKit

class AboutAppView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
    }
    
    private func configureNavigationItem() {
        self.navigationItem.title = "About Us"
    }
}
