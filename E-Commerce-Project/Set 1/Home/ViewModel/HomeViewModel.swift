//
//  HomeViewModel.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 23/10/2023.
//

import Foundation
//All Leagues

class HomeViewModel{
    var  bindresultToHomeViewController: ( () -> () ) = {}

//    var data : Brands?
 static  var selectedBrandID : Int?
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
//                self.bindresultToHomeViewController()

            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
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
        HomeViewModel.selectedBrandID = getAllBrands?.smart_collections[Index].id
    }
    
    func getTitle(index: Int) -> String?{
        return getAllBrands?.smart_collections[index].title ?? "NO"
    }
    
    func getImage(index: Int) -> String?{
        return getAllBrands?.smart_collections[index].image.src
    }
    
    //MARK: - All Price Rules
    func getNumberOfPriceRules() -> Int? {
        print("///\(getAllPriceRules?.price_rules.count)" )
        return getAllPriceRules?.price_rules.count
   }
    
    func getId(index: Int) -> Int?{
        return getAllPriceRules?.price_rules[index].id  ?? 200
    }
    
    func getPriceRulesTitle(index: Int) -> String?{
        return getAllPriceRules?.price_rules[index].title ?? "NO Price Rule title"
    }
    
    //MARK: - All Discount Codes


    
}
    

