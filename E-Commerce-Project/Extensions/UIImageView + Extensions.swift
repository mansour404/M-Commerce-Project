//
//  UIImageView + download.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 19/10/2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    // MARK: - Download image from string url
    func downloadImageFrom(_ stringURL: String?, placeHolder: String = "leagueDefault") {
        guard let stringURL = stringURL, let url = URL(string: stringURL) else {
            image = UIImage(named: placeHolder)
            return
        }
        kf.indicatorType = .activity
        kf.setImage(with: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let imageRes):
                self.image = imageRes.image
            case .failure(let error):
                print(error.localizedDescription)
                self.image = UIImage(named: placeHolder)
            }
        }
    }
    
    func getImageInsideView () -> UIImage{
        return self.image ?? UIImage()
    }
    
    // MARK: - Make imageView rounded
    func rounded() {
       clipsToBounds = true
        // Set the corner radius to make the imageView circular
        layer.cornerRadius = min(frame.size.width, frame.size.height) / 2.0
        layer.masksToBounds = true
    }
    
    func addBorder(width: CGFloat = 0.5, color: CGColor = UIColor.systemGray.cgColor) {
        // Add a circular black stroke (border) around the image view
        layer.borderWidth = width // Adjust the border width as needed
        layer.borderColor = color
    }
}
