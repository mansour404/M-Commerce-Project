//
//  SettingModel.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import Foundation

struct SettingModel {
    let id: Int?
    let title: String?
    let setting: SettingType
    
    static func fetchSettings() -> [SettingModel] {
        let settings = [
            SettingModel(id: 0, title: "Address", setting: .address),
            SettingModel(id: 1, title: "Cuncerrency", setting: .cuncerrency),
            SettingModel(id: 2, title: "Contact Us", setting: .contactUs),
            SettingModel(id: 3, title: "About App", setting: .aboutApp),
        ]
        return settings
    }
}

enum SettingType {
    case address
    case cuncerrency
    case contactUs
    case aboutApp
}
