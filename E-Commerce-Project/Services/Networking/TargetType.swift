//
//  TargetType.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 23/10/2023.
//


import Foundation
import Alamofire

// mapping http metods with almofire
enum HTTPMethod: String {
    case get = "GET"
    case delete = "DELETE"
    case post = "POST"
    case put = "PUT"
}

// wrapper
enum Task {
    case requestPlain
    // associated value
    case requestParameters(parameters : [String: Any], encoding: ParameterEncoding)
}

// properties for API call
protocol TargetType {
    var baseURL: String { get }
    var pathURL: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: [String: String]? { get }
}

enum EndPoint : TargetType {
    
    case brands
    case all_products
    
    var baseURL: String {
        switch self {
        case .brands
            return ""
        case .all_products
            return ""
        }
        default
            return ""
    }
    
    var pathURL: String {
        switch self {
        case .brands
            return ""
        case .all_products
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .brands
            return HTTPMethod.get
        case .all_products
            return HTTPMethod.get
        }
    }
    
    var task: Task {
        switch self {
        case.brands
            return requestPlain
        case .all_products
            return requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
