//
//  BaseAPI.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 23/10/2023.
//


import Foundation
import Alamofire


class BaseAPI<T:TargetType> {

    func fetchData<M: Decodable>(target: T, model: M.Type, completion: @escaping((Result<M?, NSError>)) -> Void) {
        let url = target.baseURL + target.pathURL
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = HTTPHeaders(target.headers ?? [:])
        let params = buildParameters(task: target.task)
        AF.request(url, method: method, parameters: params.0, encoding: params.1, headers: headers).response { response in
            guard let statusCode = response.response?.statusCode else {
                // ADD Custom Error
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                completion(.failure(error))
                return
            }
            if statusCode == 200 {
                guard let result = try? response.result.get() else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    completion(.failure(error))
                    return
                }
                guard let data = try? JSONSerialization.data(withJSONObject: result, options: []) else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    completion(.failure(error))
                    return
                }
                guard let jsonObject = try? JSONDecoder().decode(M.self, from: data) else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    completion(.failure(error))
                    return
                }
                completion(.success(jsonObject))
            } else {
                // ADD Custom Error
                // Error Parsing , for the Error from Back- End
                let message = "Error message parssed form backend "
                let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: message])
                completion(.failure(error))
            }
        }
    }

    private func buildParameters(task: Task) -> ([String: Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(let parameters, let encoding):
            return (parameters, encoding)
        }
    }
}

      /* ------------------------------------------------------------------ */




    


