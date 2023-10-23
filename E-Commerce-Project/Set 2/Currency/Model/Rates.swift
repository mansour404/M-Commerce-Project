//
//  Rates.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import Foundation

enum Rates : Double, Codable, CaseIterable {
    case USD
    case EUR
    case CAD
    case EGP
    case SAR
    case AED
    case KWD
    case QAR

    
    enum CodingKeys: String, CodingKey {
        case USD = "USD"
        case EUR = "EUR"
        case CAD = "CAD"
        case EGP = "EGP"
        case SAR = "SAR"
        case AED = "AED"
        case KWD = "KWD"
        case QAR = "QAR"
    }
    
}
