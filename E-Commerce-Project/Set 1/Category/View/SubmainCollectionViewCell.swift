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
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var myView: UIView!
    
    var obj = FavouriteViewModel()
    
    var networkManager = NetworkServices()
    
    // important
    var product_id : Int? = 0
    var product_title : String? = ""
    var heartIsFilled : Bool = false;
    
    @IBAction func heart_button_pressed(_ sender: UIButton) {
        
        if heartIsFilled {
            StageDelete(product_id: product_id!)
            
        }
        else {
            createFavourite()
        }
        
    }
    
    
    @IBOutlet weak var heart_button_outlet: UIButton!
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myView.layer.cornerRadius = 15
        
        heart_button_outlet.setImage(UIImage(systemName: "heart"), for: .normal)
        
        bindresultToProductsViewController = {(check : Bool ) -> Void in
            
                self.colorheart(colored: check)
            
           
        }
        
            
    }
    
    override func didMoveToWindow() {
        setControllerFavourite()
    }
    
    override func layerWillDraw(_ layer: CALayer) {
        setControllerFavourite()
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
        networkManager.addFavouriteItem(userID: (UserDefaultsHelper.shared.getCustomerId()), productId: Int(product_id!), productName: (product_title)!, Handler:{
            DispatchQueue.main.async {
                
                
                self.bindresultToProductsViewController(true)
            }
        })
    }
    
    func  setControllerFavourite(){
        networkManager.getfavouriteItem(userID: (UserDefaultsHelper.shared.getCustomerId()) , productId: Int(product_id!), Handler: { (dataValue:WhishList?, error: Error?) in
            print("Success")
            if let mydata = dataValue {
                print(mydata.metafields)
                print(mydata.metafields.isEmpty)
                DispatchQueue.main.async {
                    
                    if(mydata.metafields.isEmpty == true ){
                        
                        self.bindresultToProductsViewController(false)
                        
                    }
                    else  {
                        self.bindresultToProductsViewController(true)
                        
                    }
                }
                print("yousof is right")
            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
       print("ziyad is wrong")
        
    }
    
    // MARK: - configure Nib
    func configure( imageName: String , priceText: String , productNameText: String ) {
        
        imageView.downloadImageFrom(imageName)

        if let titleLabel = productNameLabel {
            titleLabel.text = productNameText
        }
        if let titleLabel = priceLabel {
            titleLabel.text = priceText
        }
//        if let titleLabel = exchangeLabel {
//            titleLabel.text = exchangeText
//        }
//        if let ratingView = rating {
//            ratingView = rating
//        }
    }
}
