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
    //MARK: -Getting Number of Brands
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
}
    
