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
    func getDataToCategory<T :Codable>(Handler: @escaping (T?,Error?) -> Void) {
   let urlFile = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/products.json"
  
       AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
       if let validData = data.data {
           do{
               let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
               print("Success22")
               Handler(dataRetivied, nil)
               let ggg = dataRetivied as! ProductsResponse
//               print("===================================")
//               print(ggg.products[1].id )
//               print("===================================")
           }catch let error{
             print (error)
               Handler(nil, error)
           }
       }
       else{print("There is error in casting data")}
    }
  }
    func getDataByProductType<T :Codable>(Type : String,Handler: @escaping (T?,Error?) -> Void) {
   let urlFile = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/products.json?product_type=\(Type)"
  
       AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
       if let validData = data.data {
           do{
               let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
               print("Success22")
               Handler(dataRetivied, nil)
               let ggg = dataRetivied as! ProductsResponse
//               print("===================================")
//               print(ggg.products[1].id )
//               print("===================================")
           }catch let error{
             print (error)
               Handler(nil, error)
           }
       }
       else{print("There is error in casting data")}
    }
  }
    func getCustomerWishList<T :Codable>(CustomerId : Int? ,Handler: @escaping (T?,Error?) -> Void){
      
        let urlFile = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/customers/6866434621590/metafields.json?namespace=wishlist"
       
        Alamofire.AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
            if let validData = data.data {
                do{
                    let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                    print("Success")
                Handler(dataRetivied, nil)
                
                }catch let error{
                  print ("this is an error :\(error)")
                    Handler(nil, error)
                }
            }
            else{}
        }
    }

    func getProductById<T :Codable>(ProductId : String ,Handler: @escaping (T?,Error?) -> Void){

        let urlFile = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/products/\(ProductId).json"
       
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

protocol end_point_generator {
    var base_URL : String {get}
    var method : Alamofire.HTTPMethod {get}
    var filePath : String {get}
}

enum EndPoint  : end_point_generator {
    
    case Home
    case all_products
    case product_info (ProductID : Int64)
    
    var base_URL: String {
        return "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .Home:
            return .get
        case .all_products:
            return .get
        case .product_info:
            return .get
        }
    }
    
    var filePath: String {
        switch self {
        case .Home:
            return "smart_collections.json"
        case .all_products:
            return "products.json"
        case .product_info (let ProductID):
            return "products/\(ProductID).json"
        }
    }
    
    
}

class AbstractNetworkService   {
 
    //MARK: - Fetching Data From Api
    func getData<T :Codable>(endPoint : EndPoint, Handler: @escaping (T?,Error?) -> Void) {
        
        let urlFile = endPoint.base_URL + endPoint.filePath
    
   
        AF.request(urlFile,method: endPoint.method).response { data in
        if let validData = data.data {
            do{
                let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                
//                let x = dataRetivied as! AllProducts
//                print(x)
//
//                print("product succeeded")
                Handler(dataRetivied, nil)
            
            }catch let error{
              print (error)
//                print("product failed")
                Handler(nil, error)
            }
        }
        else{print("There is error in casting data")}
    }
  }
}
