//
//  SettingModel.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import UIKit

struct SettingModel {
    let id: Int
    let title: String
    let vc: UIViewController
    
    static func fetchSettings() -> [SettingModel] {
        let settings = [
            SettingModel(id: 0, title: "Address", vc: AddressListView(nibName: "AddressListView", bundle: nil)),
            SettingModel(id: 1, title: "Cuncerrency", vc: CurrencyView(nibName: "CurrencyView", bundle: nil)),
            SettingModel(id: 2, title: "About App", vc: AboutAppView(nibName: "AboutAppView", bundle: nil))
        ]
        return settings
    }
}

enum SettingType {
    case address
    case cuncerrency
    case aboutApp
}
