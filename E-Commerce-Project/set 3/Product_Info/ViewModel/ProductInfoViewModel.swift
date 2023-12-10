//
//  ProductInfoViewModel.swift
//  E-Commerce-Project
//
//  Created by Admin on 25/10/2023.
//

import Foundation

class ProductInfoViewModel {
    
    var id : Int64?
    var product : ProductCompleteModel?
   
    var manager = AbstractNetworkService()
    var networkManager = NetworkServices()
    var myView : ProductInfoViewController?
    
    var obj = FavouriteViewModel()
    
    var isInFavourites : Bool = false
    var  bindresultToProductsViewController: ( (_ colored : Bool) -> () ) = {colored in}
    
   
    
    func reload_my_view () {
        myView?.viewReload()
    }
    
    func numberOfOptions () -> Int{
        return product?.options?.count ?? 0
    }
    
    func optionValuesCount (for_Row row : Int) -> Int{
        return product?.options?[row].values?.count ?? 0
    }
    
    
    func optionName (row : Int, column : Int) -> String {
        return product?.options?[row].values?[column] ?? "Nil"
    }
    
    func initializeProduct () {
        manager.getData(endPoint: EndPoint.product_info(ProductID: id!), Handler: { (dataValue:AllProducts?, error: Error?) in
            print("Success")

            if let mydata = dataValue {
                self.product = mydata.product
                self.reload_my_view()
                
                //print(mydata)

            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    func StageDelete(product_id : Int){
     
        obj.compiltionHandler = { id in
            if id != -1 {
                print(id)
                self.deleteProductFromFavourites(wishId: id)
            }
            
        }
        obj.sendWishId(userID: Int64(UserDefaultsHelper.shared.getCustomerId()), productId: product_id)
        
          
    }
    
        func deleteProductFromFavourites(wishId : Int){
            networkManager.removefavouriteItem(userID: (UserDefaultsHelper.shared.getCustomerId()), wishId: wishId ,Handler: {
            self.bindresultToProductsViewController(false)
        })
        
    }
    func createFavourite(){
        networkManager.addFavouriteItem(customerId: UserDefaultsHelper.shared.getCustomerId(), productId: product?.id ?? 0, variant_id: product?.variants?[0].id ?? 0, productName: product?.title ?? "no title in productinfovm", price: product?.variants?[0].price ?? "130", imageURl: product?.images[0].src ?? ""  , Handler:{
            self.bindresultToProductsViewController(true)
        })
    }
                                      
    func  setControllerFavourite(){

        networkManager.getCustomerWishList(Handler: {(dataValue:DraftOrdersResult?, error: Error?) in
            
            if let mydata = dataValue {
                print("********************************************")
                    print("this the filter in product info  ")
                print("\(String(describing: mydata.draft_orders?.count) )")
                print("********************************************")
                
                var ok = false;
                
                if((mydata.draft_orders?.count ?? 0) > 0){
                    for d in 0..<(mydata.draft_orders?.count ?? 0) {
                        if(UserDefaultsHelper.shared.getCustomerId() != 0){
                            if(mydata.draft_orders?[d].note == "Wishlist" ){
                                let mycustomer : CustomerTwo = (mydata.draft_orders?[d].customer)!
                                    if(mycustomer.id == UserDefaultsHelper.shared.getCustomerId()){
                                    print("********************************************")
                                        print("this the filter in product info  ")
                                        print("\(mycustomer.id == UserDefaultsHelper.shared.getCustomerId())")
                                    print("********************************************")
                                        print("********************************************")
                                            print("this the filter in product info this is product id  ")
                                        print("\(String(describing: self.product?.variants?[0].id))")
                                        print("********************************************")
                                        print("********************************************")
                                            print("this the filter in product info this is a product id in draft order ")
                                        print("\(String(describing: mydata.draft_orders?[d].line_items?[0].variant_id))")
                                        print("********************************************")
                                    if(mydata.draft_orders?[d].line_items?[0].variant_id == self.product?.variants?[0].id){
                                        //self.bindresultToProductsViewController(true)
                                        ok = true
                                    }else {
                                        //self.bindresultToProductsViewController(false)
                                    }
                                }
                                
                            }
                        }
                        
                    }
                }
                self.bindresultToProductsViewController(ok);
                
            }else {
                    if let error = error{
                        self.bindresultToProductsViewController(false)
                        print(error.localizedDescription)
                    }
                }
            })
        }

    //MARK: - Fetching Data From Api to chech if in favourite
    
}
