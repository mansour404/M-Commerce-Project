//
//  ProductViewModel.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 25/10/2023.
//

import Foundation
class ProductViewModel {
    var handerDataOfHome: (() -> Void)?
    var  bindresultToProductsViewController: ( () -> () ) = {}
    
    var services = NetworkServices()
    var networkManager = NetworkServices()
    
    var AllBrandProducts: ProductsResponse? {
        didSet{
            if let validHander =  handerDataOfHome {
                validHander()
            }
        }
    }
    var dataArr : [Product]?

    
    var favourite_items_array : [Draft_orders] = []
    var is_id_in_favourites : [Int: Bool] = [:]
    
    
    var f_handler : ( () -> () ) = {}
    func getFavouriteItems (handler : @escaping ( () -> () )) {
        
        f_handler = handler
        
        //let mycustomer : CustomerTwo = (mydata.draft_orders?[d].customer)!
        favourite_items_array  = []
        networkManager.getCustomerWishList( Handler: {(dataValue:DraftOrdersResult?, error: Error?) in
            
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
            //self.getDataFromApiForProduct()
            
            self.f_handler()
            
        }
        )
    }
    //MARK: - Sorting
    //HERE

    func sortByPrice(){
            dataArr?.sort { (product1, product2) -> Bool in
                if let price1 = product1.variants?.first?.price, let price2 = product2.variants?.first?.price {
                    if let priceValue1 = Double(price1), let priceValue2 = Double(price2) {
                        return priceValue1 < priceValue2
                    }
                }
                
                return false
            }
        }
    
    func sortByArrangingTheLetters(){
        dataArr?.sort { (product1, product2) -> Bool in
            if let title1 = product1.title, let title2 = product2.title {
                return title1.localizedCompare(title2) == .orderedAscending
            }
            
            // If titles are not available, keep the order unchanged
            return false
        }
    }
    
    //MARK: -CAll Request of Api
    func getDataFromApiForProduct() {
        guard let name  = HomeViewModel.selectedBrandName else {
            print("error in brand name")
            return
        }
        print("===============================")
        print("\(name)")
        print("++++++++++++++++++++++++++++++++")
        services.getAllProductsForBrandData(BrandId: name, Handler: { (dataValue:ProductsResponse?, error: Error?) in
            print("Success")

            if let mydata = dataValue {
                self.AllBrandProducts = mydata
                self.bindresultToProductsViewController()

            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
    func getDataFromApiForProduct_WithFilter(SearchText : String) {
        services.getAllProductsForBrandData(BrandId: HomeViewModel.selectedBrandName ?? 0, Handler: { (dataValue:ProductsResponse?, error: Error?) in
            print("Success")

            if let mydata = dataValue {
                self.AllBrandProducts = mydata
                self.AllBrandProducts?.products = []
                
                for p in mydata.products {
                    if (p.title?.contains(SearchText) == true){
                        self.AllBrandProducts?.products.append(p)
                    }
                }
                
                self.bindresultToProductsViewController()

            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    //MARK: -Getting Number of Brands
func getNumberOfProduct() -> Int? {
    return AllBrandProducts?.products.count
   }
    
    func getPrice(index: Int) -> String?{
        return  AllBrandProducts?.products[index].variants?[0].price
        
    }
    
    func getTitle(index: Int) -> String?{
        return   AllBrandProducts?.products[index].title
        
    }
    
    func getImage(index: Int) -> String?{
        return   AllBrandProducts?.products[index].images.first?.src
        
    }
    
    func getid(index: Int) -> String{
        if ( AllBrandProducts?.products[index].images.count == 0) {
            return "https://t3.ftcdn.net/jpg/02/48/42/64/360_F_248426448_NVKLywWqArG2ADUxDq6QprtIzsF82dMF.jpg"
        }
        return   AllBrandProducts?.products[index].images[0].src ?? "none"
 
    }
    func getProductID (index : Int) -> Int64{
            return AllBrandProducts?.products[index].id ?? 0
        }
    func getVariant_Id (index : Int) -> Int{
        return AllBrandProducts?.products[index].variants?[0].id ?? 0
    }
   
//    func getImage(index: Int) -> String?{
//        return getAllBrands?.smart_collections[index].image.src
//
//    }
}
    


