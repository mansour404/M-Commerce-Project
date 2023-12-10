//
//  BaseView.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 23/10/2023.
//

import Foundation

protocol BaseView: AnyObject {
    func displayMessage(_ message: String, theme: MessagesTheme)
}
