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
