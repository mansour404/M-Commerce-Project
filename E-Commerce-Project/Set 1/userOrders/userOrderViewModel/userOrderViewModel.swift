//
//  UserOrderViewModel.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 25/10/2023.
//

import Foundation

class UserOrderViewModel{
    var  bindresultToHomeViewController: ( () -> () ) = {}
    //HERE
    var orderArr = [UserOrders]()
    var customerID = UserDefaultsHelper.shared.getCustomerId()

    var handerDataOfHome: (() -> Void)?
    var services = NetworkServices()
    var getAllOrders: AllOrders? {
        didSet{
            if let validHander =  handerDataOfHome {
                validHander()
            }
        }
    }

    //MARK: -Get All Model Returned From Api
    func getProducts() -> AllOrders? {
        return getAllOrders
    }
    
    
    //MARK: -CAll Request of Api
    //HERE
    func getDataFromApiForUserOrders() {
        services.getUserOrders(Handler: { (dataValue:AllOrders?, error: Error?) in
            print("Success")
            if let mydata = dataValue {
//                self.getAllOrders = mydata
                guard let orders = mydata.orders else { return }
                for order in orders {
                    let orderString = Int(order.note ?? "6866434621590" )
                    if self.customerID == orderString {
                        self.orderArr.append(order)
                    }
                }
                
//                self.getAllOrders?.orders = self.orderArr
                self.bindresultToHomeViewController()
//             print(mydata)
            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
   
    //MARK: -Getting Orders
    func getNumberOfOrders() -> Int {
        //    print(getAllOrders?.orders?.count)
//        guard let numberOfOrder = orderArr.count else{
//            return 0
//        }
        return orderArr.count
    }
    
    func getOrderNumber(index: Int) -> String?{
        return "\(orderArr[index].order_number ?? 1)"
    }
    
    func getNumberOfItems(index: Int) -> String?{
        return "\(orderArr[index].line_items?[0].quantity ?? 2)"
    }
    
    func getTotalPrice(index: Int) -> String?{
        return orderArr[index].total_price ?? "100"
    }
    
//    func getUserAddress(index : Int ) -> String?{
//        return getAllOrders?.orders?[index].customer?.default_address?.address1
//    }
    
    func getOrderTitle(index : Int ) -> String?{
        return orderArr[index].line_items?[0].title ?? "Adidas"
    }
    
    
//    func getUserPhone(index : Int ) -> String?{
//        return getAllOrders?.orders?[index].customer?.phone ?? "01025966867"
//    }
}




