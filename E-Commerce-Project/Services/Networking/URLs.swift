//
//  URLs.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 23/10/2023.
//


import Foundation

// MARK: - Token
struct Token {
    
}


// MARK: - URLs
struct URLs {
    
    // MARK: - Base URL
    //static let base2 = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/"
    static let base = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/"
    // MARK: - Path RUL
    
    //static let addressPath = "customers/\(UserDefaultsHelper.shared.getCustomerId())/addresses.json"
    static let addressPath = "customers/\(6866630049942)/addresses.json"
    
    //static let addressPath2 = "customers/\(UserDefaultsHelper.shared.getCustomerId())/addresses" // test addresPath & addresPath2
}
