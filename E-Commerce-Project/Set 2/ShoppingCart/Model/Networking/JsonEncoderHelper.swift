//
//  JsonEncoderHelper.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 30/10/2023.
//

import Foundation

class JsonEncoderHelper {
    
    class func convertObjectToJson<T: Codable>(object: T) -> [String: Any]? {
        do{
            let data = try JSONEncoder().encode(object)
            let json = String(data: data, encoding: String.Encoding.utf8)! // will always success.
            let dictionary = jsonToDictionary(from: json)
            return dictionary
        } catch (let error) {
            print(error.localizedDescription)
            return nil
        }
    }
    
    class func jsonToDictionary(from text: String) -> [String: Any]? {
        guard let data = text.data(using: .utf8) else { return nil }
        let anyResult = try? JSONSerialization.jsonObject(with: data, options: [])
        return anyResult as? [String : Any]
    }
    
    
}

