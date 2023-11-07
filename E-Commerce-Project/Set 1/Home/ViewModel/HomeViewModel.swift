//
//  HomeViewModel.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 23/10/2023.
//

import Foundation
//All Leagues
import Alamofire
class HomeViewModel{
    var  bindresultToHomeViewController: ( () -> () ) = {}
    let downloadGroup = DispatchGroup()
        var priceRuleTitle : [Int : String] = [:]
        var productDiscountCode : [Int : String] = [:]
        var cellTitle : [String] = []
        var cellDiscountCode : [String] = []
//    var data : Brands?
 static  var selectedBrandName : String?
    var handerDataOfHome: (() -> Void)?
    var services = NetworkServices()
    
    var getAllBrands: Brands? {
        didSet{
            if let validHander =  handerDataOfHome {
                validHander()
            }
        }
    }

    var getAllPriceRules: AllPriceRules? {
        didSet{
            if let validHander =  handerDataOfHome {
                validHander()
            }
        }
    }
    
    var getDiscountCodes: AllDiscounts? {
        didSet{
            if let validHander =  handerDataOfHome {
                validHander()
            }
        }
    }
    
   
    
    //MARK: -Get All Model Return From Api
    func getBrand() -> Brands? {
        return getAllBrands
    }

  
    
    //MARK: -CAll Request of Api
    func getDataFromApiForHome() {
        services.getData(Handler: { (dataValue:Brands?, error: Error?) in
            print("Success")

            if let mydata = dataValue {
                self.getAllBrands = mydata
                self.bindresultToHomeViewController()

            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    func fetchPriceRules(){
            services.getPriceRule(Handler: {(dataValue:AllPriceRules? , error: Error?) in
                print("Success to fetch price rules")
                
                if let mydata = dataValue {
                    self.getAllPriceRules = mydata
                    for p in self.getAllPriceRules?.price_rules ?? []{
                        self.priceRuleTitle[p.id] = p.title
                    }
                    //self.bindresultToHomeViewController()
                    self.fetchDiscountCodes()            }else {
                    if let error = error{
                        print(error.localizedDescription)
                    }
                }
            })
        }
    func getSingleDiscountCode <T:Codable> (priceRuleId: Int,Handler : @escaping (T?,Error?) -> Void){
                let URL = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/price_rules/\(priceRuleId)/discount_codes.json"
                Alamofire.AF.request(URL,method: Alamofire.HTTPMethod.get).response { data in
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
                    else{print("There is error in casting data")}
                }
            }
    func fetchDiscountCodes(){
          for p in getAllPriceRules?.price_rules ?? [] {
              downloadGroup.enter()
              getSingleDiscountCode(priceRuleId: p.id, Handler: { (dataValue:AllDiscounts?, error: Error?) in
                  print("Success")
                  if let mydata = dataValue {
                      self.getDiscountCodes = mydata
                      // self.bindresultToHomeViewController()
                      if !mydata.discount_codes.isEmpty {
                          self.productDiscountCode[p.id] = mydata.discount_codes[0].code
                      }
                      
                  }else {
                      if let error = error{
                          print(error.localizedDescription)
                      }
                  }
                  self.downloadGroup.leave()
              })
          }
          downloadGroup.notify(queue: DispatchQueue.main) {
              for dicElement in self.productDiscountCode {
                  let title = self.priceRuleTitle[dicElement.key] ?? "nil"
                  let code = dicElement.value
                  self.cellTitle.append(title)
                  self.cellDiscountCode.append(code)
              }
              self.bindresultToHomeViewController()
              
          }
      }
//    func fetchDiscountCodes(){
//        for rule in getAllPriceRules!.price_rules {
//            services.getDiscountCodes(priceRuleId: rule.id, Handler: <#T##((Decodable & Encodable)?, Error?) -> Void#>)
//        }
//
//    }
    
    //MARK: - Brands
    func getNumberOfBrands() -> Int? {
    return getAllBrands?.smart_collections.count
   }
    
    func setSelectedBrandID (Index :Int){
        HomeViewModel.selectedBrandName = getAllBrands?.smart_collections[Index].title
    }
    
    func getTitle(index: Int) -> String?{
        return getAllBrands?.smart_collections[index].title ?? "NO"
    }
    
    func getImage(index: Int) -> String?{
        return getAllBrands?.smart_collections[index].image.src
    }
    
    //MARK: - All Price Rules
        func getNumberOfPriceRules() -> Int? {
    //        print("\(getAllPriceRules?.price_rules.count)" )
            return cellTitle.count
        }
        
    //    func getId(index: Int) -> Int?{
    //        return getAllPriceRules?.price_rules[index].id  ?? 200
    //    }
        
        func getPriceRulesTitle(index: Int) -> String?{
            return cellTitle[index]
        }
        
        func getPriceRuleDiscountCode(index: Int)->String{
            return cellDiscountCode[index]
        }
    
    //MARK: - All Discount Codes


    
}
    

