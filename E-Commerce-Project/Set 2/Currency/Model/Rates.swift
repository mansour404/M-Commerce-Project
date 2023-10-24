//
//  Rates.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import Foundation

struct Rates : Codable {
    let USD : Double?
    let EGP : Double?
    let SAR : Double?
    let AED : Double?
    let KWD : Double?
    let QAR : Double?
    
    enum CodingKeys: String, CodingKey {
        case USD = "USD"
        case EGP = "EGP"
        case SAR = "SAR"
        case AED = "AED"
        case KWD = "KWD"
        case QAR = "QAR"
    }
}

//enum Rates : Double, Codable, CaseIterable {
//    case USD
//    case EGP
//    case SAR
//    case AED
//    case KWD
//    case QAR
//
//    enum CodingKeys: String, CodingKey {
//        case USD = "USD"
//        case EGP = "EGP"
//        case SAR = "SAR"
//        case AED = "AED"
//        case KWD = "KWD"
//        case QAR = "QAR"
//    }
//}
