//
//  sectionHeader.swift
//  E-Commerce-Project
//
//  Created by Admin on 20/10/2023.
//

import UIKit

class sectionHeader: UICollectionReusableView {
    var header : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    static let identifier = "HeaderView"
    
    func setHeaderValue (value : String) {
        
        setupConstraints()
        
        header.text = value
        header.backgroundColor = .systemBackground
    }
    
    private func setupConstraints() {
        self.addSubview(header)
        
        NSLayoutConstraint.activate([
            header.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            header.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            header.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18)
        ])
    }

}
