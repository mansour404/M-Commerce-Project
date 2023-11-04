//
//  OrderViewModel.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 24/10/2023.
//

import Foundation

protocol OrderViewModelProtocol {
    func fetchPriceRules()
    func get_discount_amount (code : String) -> Double?
    func get_discount_type (code : String) -> String?
}

class OrderViewModel: OrderViewModelProtocol {
    
    var networkingService: OrderNetworkingService = OrderNetworkingService()
    var handerDataOfHome: (() -> Void)?
    
    var priceRuleTitle : [Int : String] = [:]
    var priceRuleDiscountCodes : [Int : [String]] = [:]
    
    var priceRuleDiscountAmount : [Int : String] = [:]
    var priceRuleDiscountType : [Int : String] = [:]
    
    var DiscountCode_PriceRuleId : [String : Int] = [:]
    
    var cellTitle : [String] = []
    var cellDiscountCode : [String] = []
    
    let downloadGroup = DispatchGroup()
    
    
    
    var getAllPriceRules: AllPriceRules? {
        didSet{
            if let validHander =  handerDataOfHome {
                //validHander()
            }
        }
    }
    
    var getDiscountCodes: AllDiscounts? {
        didSet{
            if let validHander =  handerDataOfHome {
                //validHander()
            }
        }
    }
    
    var bindToOrderVC: (() -> ()) = {}
    
    
    // VM
    func fetchPriceRules() {
        networkingService.getPriceRule(Handler: {(dataValue:AllPriceRules? , error: Error?) in
            print("Success to fetch price rules")
            
            if let mydata = dataValue {
                self.getAllPriceRules = mydata
                for p in self.getAllPriceRules?.price_rules ?? []{
                    self.priceRuleTitle[p.id] = p.title
                    self.priceRuleDiscountType[p.id] = p.value_type
                    self.priceRuleDiscountAmount[p.id] = p.value
                }
                //self.bindresultToHomeViewController()
                self.fetchDiscountCodes()
                
            } else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    
    private func fetchDiscountCodes() {
        for price_rule in getAllPriceRules?.price_rules ?? [] {
            downloadGroup.enter()
            networkingService.getSingleDiscountCode(priceRuleId: price_rule.id, Handler: { (dataValue:AllDiscounts?, error: Error?) in
                print("Success")
                if let mydata = dataValue {
                    self.getDiscountCodes = mydata
                    // self.bindresultToHomeViewController()
                    if !mydata.discount_codes.isEmpty {
                        if self.priceRuleDiscountCodes[price_rule.id] == nil {
                            
                            self.priceRuleDiscountCodes[price_rule.id] = []
                        }
                        
                        //self.priceRuleDiscountCodes[p.id]?.append(mydata.discount_codes[0].code)
                        for discount_code in mydata.discount_codes {
                            self.priceRuleDiscountCodes[price_rule.id]?.append(discount_code.code)
                            
                            self.DiscountCode_PriceRuleId[discount_code.code] = price_rule.id
                        }
                        
                        //  mydata.discount_codes[0].code
                    }
                    
                } else {
                    if let error = error{
                        print(error.localizedDescription)
                    }
                }
                self.downloadGroup.leave()
            })
        }
        downloadGroup.notify(queue: DispatchQueue.main) {
            // mansour handler for applying code
            // Calling bindToOrderVC after fetch data
            self.bindToOrderVC()
        }
    }
    
    func get_discount_amount (code : String) -> Double? {
        guard let price_rule_id = DiscountCode_PriceRuleId[code] else {
            return nil;
        }
        
        return Double(priceRuleDiscountAmount[price_rule_id]!)
        
    }
    
    func get_discount_type (code : String) -> String? {
        guard let price_rule_id = DiscountCode_PriceRuleId[code] else {
            return nil;
        }
        
        return priceRuleDiscountType[price_rule_id]
    }
    
    
}
