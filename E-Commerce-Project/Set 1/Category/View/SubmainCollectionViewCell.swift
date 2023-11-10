//
//  SubmainCollectionViewCell.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 19/10/2023.
//

import UIKit
import Cosmos

class SubmainCollectionViewCell: UICollectionViewCell {
    // MARK: - Variables
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var heart_button_outlet: UIButton!

    var obj = FavouriteViewModel()
    var networkManager = NetworkServices()
    // important
    var product_id : Int? = 0
    var product_title : String? = ""
    var product_Variant_Id : Int? = 0
    var product_Price : String? = ""
    var product_Image : String? = ""
    var heartIsFilled : Bool = false;
    

    // MARK: - LifeCycle Method
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myView.layer.cornerRadius = 15
        heart_button_outlet.setImage(UIImage(systemName: "heart"), for: .normal)
        heart_button_outlet.tintColor = UIColor.systemPurple
        
        bindresultToProductsViewController = {(check : Bool ) -> Void in
            self.colorheart(colored: check)
        }
    }
    
    func colorheart(colored : Bool){
        if colored {
            heart_button_outlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//            heart_button_outlet.tintColor = UIColor.systemPurple
            heartIsFilled = true
        }
        else {
            heart_button_outlet.setImage(UIImage(systemName: "heart"), for: .normal)
//            heart_button_outlet.backgroundColor = UIColor.systemPurple
            heartIsFilled = false
        }
    }
    
    // MARK: - Actions
    @IBAction func heart_button_pressed(_ sender: UIButton) {
        
        if heartIsFilled {
            StageDelete(product_id: product_Variant_Id!)
            
        }
        else {
            createFavourite()
        }
    }
        
    var  bindresultToProductsViewController: ( (_ colored : Bool) -> () ) = {colored in}
    
    
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
            DispatchQueue.main.async {
                
                self.bindresultToProductsViewController(false)
            }
        })
        
    }
    func createFavourite(){
        
        networkManager.addFavouriteItem(customerId: (UserDefaultsHelper.shared.getCustomerId()), productId: Int(product_id!), variant_id: product_Variant_Id!, productName: (product_title)!, price: product_Price!, imageURl: product_Image!, Handler:{
            DispatchQueue.main.async {
                
                
                self.bindresultToProductsViewController(true)
            }
        })
    }
    

    func  setControllerFavourite2(){
        
        networkManager.getCustomerWishList(Handler: {(dataValue:DraftOrdersResult?, error: Error?) in
            if let mydata = dataValue {
                var ok = false;
                
                print("********************************************")
                print("this the filter in product info  ")
                print("\(String(describing: mydata.draft_orders?.count) )")
                print("********************************************")
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
                                    print("\(String(describing: self.product_Variant_Id))")
                                    print("********************************************")
                                    print("********************************************")
                                    print("this the filter in product info this is a product id in draft order ")
                                    print("\(String(describing: mydata.draft_orders?[d].line_items?[0].variant_id))")
                                    print("********************************************")
                                    if(mydata.draft_orders?[d].line_items?[0].variant_id == self.product_Variant_Id){
                                        //self.bindresultToProductsViewController(true)
                                        //break
                                        ok = true;
                                    }else {
                                        //self.bindresultToProductsViewController(false)
                                    }
                                }
                                
                            }
                        }
                        
                    }
                }
                DispatchQueue.main.async {
                    self.bindresultToProductsViewController(ok)
               }
                
            }else {
                if let error = error{
                    self.bindresultToProductsViewController(false)
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    // MARK: - configure Nib
//    func configure( imageName: String , priceText: String , productNameText: String ) {
    func configure(imageName: String , priceText: String , productNameText: String, exchangeText: String) {
        
        if let titleLabel = productNameLabel {
            titleLabel.text = productNameText
        }
        if let titleLabel = priceLabel {
            titleLabel.text = priceText
        }
        
        if let titleLabel = exchangeLabel {
            titleLabel.text = exchangeText
        }
        imageView.downloadImageFrom(imageName)
    }
}
