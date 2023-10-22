//
//  CurrencyModel.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import Foundation

struct CurrencyModel {
    static let currencySymbol = ["د.إ", "AU$", "CA$", "CHF", "Kč", "kr", "€", "GBP£", "HK$", "₪", "¥", "₩", "RM", "NZ$", "zł", "kr", "SG$", "$", "E£"]
}

enum Currency: String {
    case AED, AUD, CAD, CHF, CZK, DKK, EGP, EUR, GBP, HKD, ILS, JPY, KRW, MYR, NZD, PLN, SEK, SGD, USD
}


