//
//  ExchnageRateManager.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import Foundation

protocol ExchnageRateServiceProtocol {
    func fetchData(completion: @escaping (Result<ExchangeRatesData?, DataError>) -> Void)
}

enum DataError: Error {
    case invalidData
    case invalidResponse
    case message(_ error: Error?)
}

// MARK: - Exchnage Rate Service
class ExchnageRateService: ExchnageRateServiceProtocol {
//    static let shared = ExchnageRateService()
//    private init() { }
    
    // API Link:  https://www.exchangerate-api.com/docs/free
    let url = URL(string: "https://open.er-api.com/v6/latest/USD")
    
    func fetchData(completion: @escaping (Result<ExchangeRatesData?, DataError>) -> Void) {
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(ExchangeRatesData?.self, from: data)
                completion(.success(results))
            }
            catch {
                completion(.failure(.message(error)))
            }
        }.resume()
    }
}


// MARK: - Mock Exchnage Rate Manager
final class MockExchnageRateManager {
    static let shared = MockExchnageRateManager()
    private init() { }
    
    func fetchDataFromJsonFile() -> ExchangeRatesData {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "exchangeData.json", withExtension: nil) else {
            fatalError("Could not find exchangeData.json")
        }
        guard let exchangeData = try? Data(contentsOf: fileUrl) else {
            fatalError("Couldn't convert data")
        }
        
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(ExchangeRatesData.self, from: exchangeData) else {
            fatalError("There was a problem decoding the data....")
        }
        
        return result
    }
}

