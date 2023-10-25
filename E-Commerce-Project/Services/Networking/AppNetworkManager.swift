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
   
         Alamofire.AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
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
   
        Alamofire.AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
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
       
         Alamofire.AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
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
    //https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-01/customers/6866434621590/metafields.json?namespace=wishlist
    func getCustomerWishList<T :Codable>(CustomerId : Int? ,Handler: @escaping (T?,Error?) -> Void){
      
        let urlFile = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-01/customers/6866434621590/metafields.json?namespace=wishlisthttps://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-01/customers/6866434621590/metafields.json?namespace=wishlist"
       
        Alamofire.AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
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

    func getProductById<T :Codable>(ProductId : Int ,Handler: @escaping (T?,Error?) -> Void){

        let urlFile = "//https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/products/7827742130326.json"
       
        Alamofire.AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
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
