//
//  HomeViewModel.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 25/10/2023.
//

import Foundation

class CategoryViewModel{
    var  bindresultToHomeViewController: ( () -> () ) = {}
//    var data : Brands?
   
    var handerDataOfHome: (() -> Void)?
    var services = NetworkServices()
    var networkManager = NetworkServices()
    
    var getAllProducts: ProductsResponse? {
        didSet{
            if let validHander =  handerDataOfHome {
                validHander()
            }
        }
    }

    //MARK: -Get All Model Return From Api
    func getProducts() -> ProductsResponse? {
        return getAllProducts
    }
    
    var favourite_items_array : [Draft_orders] = []
    var is_id_in_favourites : [Int: Bool] = [:]
    
    func getFavouriteItems () {
        
        
    
        favourite_items_array  = []
        //let mycustomer : CustomerTwo = (mydata.draft_orders?[d].customer)!
        networkManager.getCustomerWishList(Handler: {(dataValue:DraftOrdersResult?, error: Error?) in
            
            if let mydata = dataValue {
                
                for d in mydata.draft_orders! {
                    
                    if d.note != "Wishlist" {
                        continue
                    }
                    
                    //let mycustomer : CustomerTwo = (mydata.draft_orders?[d].customer)!
                    if d.customer?.id == UserDefaultsHelper.shared.getCustomerId() {
                        self.favourite_items_array.append(d);
                    }
                    
                    print(d.customer?.id, "vs.", UserDefaultsHelper.shared.getCustomerId())
                }
                
            }else {
                if let error = error{
                    
                    print(error.localizedDescription)
                }
            }
            if(UserDefaultsHelper.shared.getCustomerId() == 0){
                self.favourite_items_array = []
                
            }
            print("favourites are done")
            self.getDataFromApiForHome()
            
        }
        )
    }
    
    
    //MARK: -CAll Request of Api
    func getDataFromApiForHome() {
        services.getDataToCategory(Handler: { (dataValue:ProductsResponse?, error: Error?) in
            print("Success")

            if let mydata = dataValue {
                self.getAllProducts = mydata
                
                print("bind result")
                self.bindresultToHomeViewController()

            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
            
            print("products are done")
        })
    }
    func getDataFromApiForHome(filter1 : String , filter2 :String) {
        if(filter2 != "ALL"){
            services.getDataByProductType(Type: filter2, Handler: { (dataValue:ProductsResponse?, error: Error?) in
                print("Success")
                
                if let mydata = dataValue {
                    if(filter1 == "all") {
                        self.getAllProducts = mydata
                    }else{
                        self.getAllProducts = mydata
                        self.getAllProducts?.products = []
                        for p in mydata.products {
                            let allTags : [String] = p.tags?.components(separatedBy: ", ") ?? []
                            var found = false
                            for t in allTags {
                                if (t == filter1){
                                    found = true
                                    break
                                }
                                
                            }
                            if (found){
                                self.getAllProducts?.products.append(p)
                            }
                        }
                    }
                    
                    self.bindresultToHomeViewController()
                    
                }else {
                    if let error = error{
                        print(error.localizedDescription)
                    }
                }
            }
            )
        }
        else {
            services.getDataToCategory(Handler: { (dataValue:ProductsResponse?, error: Error?) in
                print("Success")

                if let mydata = dataValue {
                    if(filter1 == "all") {
                        self.getAllProducts = mydata
                    }else{
                        self.getAllProducts = mydata
                        self.getAllProducts?.products = []
                        for p in mydata.products {
                            let allTags : [String] = p.tags?.components(separatedBy: ", ") ?? []
                            var found = false
                            for t in allTags {
                                if (t == filter1){
                                    found = true
                                    break
                                }
                                
                            }
                            if (found){
                                self.getAllProducts?.products.append(p)
                            }
                        }
                    }
                    self.bindresultToHomeViewController()

                }else {
                    if let error = error{
                        print(error.localizedDescription)
                    }
                }
            })
        }
    }
    //MARK: -Getting Number of Brands
func getNumberOfProducts() -> Int? {
//    print(getAllProducts?.products.count)
    return getAllProducts?.products.count
    }
    func getTitle(index: Int) -> String?{
        return getAllProducts?.products[index].title ?? "NO"
    }
    
    func getID(index: Int) -> Int?{
        return Int(getAllProducts?.products[index].id ?? -1)
    }
    
    
    
    func getImage(index: Int) -> String?{
        if (getAllProducts?.products[index].images == nil || getAllProducts?.products[index].images.count == 0) {
            return "https://t3.ftcdn.net/jpg/02/48/42/64/360_F_248426448_NVKLywWqArG2ADUxDq6QprtIzsF82dMF.jpg"
        }
        return getAllProducts?.products[index].images[0].src
    }
    
    func getPrice(index: Int) -> String?{
     
        return getAllProducts?.products[index].variants?[0].price
    }
    func getProductID(index : Int ) -> Int64{
        return getAllProducts?.products[index].id ?? 7827742130326
    }
    func getVariantId(index: Int) ->Int? {
        return getAllProducts?.products[index].variants?[0].id
    }
    
    func filter(mainCategoryName:String)->[Product]{
        var arr : [Product] = []
        for i in 0..<(getAllProducts?.products.count ?? 1){
            if ((getAllProducts?.products[i].tags?.contains(mainCategoryName)) == true){
                arr.append(getAllProducts!.products[i])
            }
        }
        return arr
    }
}
    

