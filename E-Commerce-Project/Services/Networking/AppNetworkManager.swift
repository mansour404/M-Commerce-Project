//
//  AppNetworkManager.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 25/10/2023.
//

import Foundation
import Alamofire
class NetworkServices   {
 
    //MARK: - Fetching Data From Api
     func getData<T :Codable>(Handler: @escaping (T?,Error?) -> Void) {
    let urlFile = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/smart_collections.json"
   
        AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
        if let validData = data.data {
            do{
                let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                print("Success")
                Handler(dataRetivied, nil)
            
                let ggg = dataRetivied as! Brands
                print("===================================")
                print(ggg.smart_collections[0].title )
                print("===================================")
            }catch let error{
              print (error)
                Handler(nil, error)
            }
        }
        else{print("There is error in casting data")}
    }
  }
    func getAllProductsForBrandData<T :Codable>(BrandId: Int ,Handler: @escaping (T?,Error?) -> Void) {
    let urlFile = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/collections/\(BrandId)/products.json"
   
        AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
        if let validData = data.data {
            do{
                let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                print("Success")

                Handler(dataRetivied, nil)
            
            }catch let error{
              print (error)
                Handler(nil, error)
            }
        }
        else{print("There is error in casting data")}
    }
  }
     func getCustomerData<T :Codable>(Handler: @escaping (T?,Error?) -> Void){
        let urlFile = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/customers.json"
       
            AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
            if let validData = data.data {
                do{
                    let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                    print("Success")
                   
                    Handler(dataRetivied, nil)
                
                }catch let error{
                  print (error)
                    Handler(nil, error)
                }
            }
            else{print("There is error in casting data")}
        }
    }
}
