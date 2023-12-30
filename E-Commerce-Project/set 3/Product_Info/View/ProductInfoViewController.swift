//
//  ProductInfoViewController.swift
//  E-Commerce-Project
//
//  Created by Admin on 19/10/2023.
//

import UIKit

class ProductInfoViewController: UIViewController {
    

    // MARK: - Variables
    @IBOutlet weak var variant_price: UILabel!
    @IBOutlet weak var variant_availability: UILabel!
    @IBOutlet weak var addToCartView: UIView!
    @IBOutlet weak var scroll_and_add_to_cart_vertical_spacing: NSLayoutConstraint!
    @IBOutlet weak var reviewsHeight: NSLayoutConstraint!
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var optionsHeight: NSLayoutConstraint!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productTags: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var number_of_cart_items_label: UILabel!

        
        
        var variant_available_elements : Int = 0
        var variant_index : Int = 0
        var variant_Unique_ID : Int = 0 // found variant - mansour - send as a paramter for addToCart
        // Vars
        let shoppingCartService = ShoppingCartService()
        let shoppingCartViewModel = ShoppingCartViewModel()
        var inventory_item_id: Int = 0
        
        func get_variant_data () {
            
            print ("get_variant_data")
            print(view_model.product)
            let all_variants : [VariantCompleteModel] = view_model.product?.variants ?? []
            
            var found : VariantCompleteModel = VariantCompleteModel()
            for v in all_variants {
                //numOptions
                
                print(v)
                
                var equal : Bool = true
                
                if numOptions >= 1 {
                    equal = equal && (v.option1 == view_model.product?.options?[0].values?[selectedOption[0]])
                }
                if numOptions >= 2 {
                    equal = equal && (v.option2 == view_model.product?.options?[1].values?[selectedOption[1]])
                }
                if numOptions >= 3 {
                    equal = equal && (v.option3 == view_model.product?.options?[2].values?[selectedOption[2]])
                }
                
                if (equal) {
                    print("variant is found")
                    found = v;
                    break
                }
                else {
                    print("variant is NOT found")
                }
            }
            
            variant_price.text = found.price ?? "not found"
            variant_availability.text = found.inventory_quantity != nil ? String(found.inventory_quantity!) : "not found"
            variant_available_elements = found.inventory_quantity ?? 0
            variant_Unique_ID  = found.id ?? 0
            inventory_item_id = found.inventory_item_id ?? 0
        }
        
        var numberOfCartItems : Int = 0
        
        func updateNumberLabel () {
            number_of_cart_items_label.text = String(numberOfCartItems)
        }
        func reset_cart () {
            numberOfCartItems = 0
            updateNumberLabel()
        }
        
    
     
          func addToCart(cart: ShoppingCartModel) {
              let customerId = UserDefaultsHelper.shared.getCustomerId()
              
              shoppingCartService.addProductToCartShopping(customerId: customerId, variantId: cart.variantId ?? 0, cart: cart) { error in
                  if error != nil {
                      print(error)
                      print("Error cann't added to shopping cart")
                  } else {
                      print("succed added to shopping cart")
                  }
              }
          }
        //++++++++++++++++++++++++++++++++++++++++++++++ // mansour end here
    //------------------------------------------------------------------------------
    
    // options code------------------------------------------------------------------------------
    
    var selectedOption : [Int] = []
    var selectedOptionsCount = 0
    var numOptions = 0
    
    func get_number_of_options () -> Int{
        return numOptions
    }
    
    func reset_options () {
        selectedOptionsCount = 0
        numOptions = view_model.numberOfOptions()
        selectedOption = Array(repeating: -1, count: view_model.numberOfOptions())
    }
    
    func isOptionSelected (row : Int) -> Bool {
        return selectedOption[row] != -1
    }
    
    func setOption (row : Int, value : Int) {
        //selectedOptionsCount += (selectedOption[row] == -1) ? 1 : 0
        selectedOption[row] = value
    }
    
    func unsetOption (row : Int) {
        //selectedOptionsCount -= (selectedOption[row] != -1) ? 1 : 0
        selectedOption[row] = -1
    }
    
    func toggleOption (row : Int, value : Int) {
        
        let cell = optionsCollectionView.cellForItem(at: IndexPath(item: value, section: row)) as! OptionCollectionViewCell
        
        let old_cell : OptionCollectionViewCell? = isOptionSelected(row: row) ?
        optionsCollectionView.cellForItem(at: IndexPath(item: selectedOption[row], section: row)) as! OptionCollectionViewCell : nil
        
        
        if isOptionSelected(row: row) {
            
            if selectedOption[row] == value {
                unsetOption(row: row)
                selectedOptionsCount -= 1
                
                cell.unselect()
            }
            else {
                setOption(row: row, value: value)
                
                cell.select()
            }
            
            
        }
        else {
            selectedOptionsCount += 1
            setOption(row: row, value: value)
            
            cell.select()
            
        }
        
        if old_cell != nil {
            old_cell!.unselect()
        }
    }
    
    func viewReload () {
        optionsCollectionView.reloadData()
        productName.text = view_model.product?.title
        productTags.text = view_model.product?.tags
        productDescription.text = view_model.product?.body_html
        
        productImagesCollectionView.reloadData()
        
        reset_options()
        reset_cart()
    }
    
    // view_mode
    var view_model = ProductInfoViewModel()
    var product_id : Int64 = 7827742130326
    
    func setID (id: Int64) {
        print("inside set id : \(id)")
        self.product_id = id;
    }
    
    func setproductImagesCollectionView () -> Void {
        productImagesCollectionView.delegate = self;
        productImagesCollectionView.dataSource = self;
        
        productImagesCollectionView.register(UINib(nibName: "ProductImageCell", bundle: nil), forCellWithReuseIdentifier: "ProductImageCell")
    }
    
    func setReviewsView () -> Void {
        reviewsCollectionView.delegate = self;
        reviewsCollectionView.dataSource = self;
        
        let layout_ = UICollectionViewCompositionalLayout { index, env in

            let itemSize = NSCollectionLayoutSize (widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem (layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize (widthDimension: .absolute(self.reviewsCollectionView.superview!.frame.width), heightDimension: .absolute(100))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets (top: 0, leading: 0, bottom: 0, trailing: 0)
            
            
            section.boundarySupplementaryItems = [header]
            
            //section.orthogonalScrollingBehavior = .continuous
            
            return section

        }
        
        reviewsCollectionView.setCollectionViewLayout(layout_, animated: true)
        
        reviewsCollectionView.register(UINib(nibName: "ReviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCollectionViewCell")
        
        reviewsCollectionView.register(sectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeader.identifier)
    }
    
    func setOptionsView () -> Void {
        optionsCollectionView.delegate = self;
        optionsCollectionView.dataSource = self;
        
        let layout_ = UICollectionViewCompositionalLayout { index, env in

            let itemSize = NSCollectionLayoutSize (widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem (layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize (widthDimension: .absolute(100), heightDimension: .absolute(100))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets (top: 0, leading: 0, bottom: 0, trailing: 0)
            
            
            section.boundarySupplementaryItems = [header]
            
            section.orthogonalScrollingBehavior = .continuous
            
            return section

        }
        
        optionsCollectionView.setCollectionViewLayout(layout_, animated: true)
        
        optionsCollectionView.register(UINib(nibName: "OptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OptionCollectionViewCell")
        
        optionsCollectionView.register(sectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeader.identifier)
    }
    
    
    private func addFavouriteButton() -> UIBarButtonItem {
        
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartIsFilled = false
        heartButton.tintColor = UIColor.systemPurple
        heartButton.addTarget(self, action: #selector(heartButtonPressed), for: .touchUpInside)

        let heartBarButtonItem = UIBarButtonItem(customView: heartButton)
        return heartBarButtonItem
    }
    // heart
    let heartButton = UIButton(type: .custom) // treat it as an outlet
    var heartIsFilled : Bool = true;
    
    func setHeartButton(){
        view_model.setControllerFavourite()
    }
    @objc func heartButtonPressed(sender: UIButton) {
        print(heartIsFilled)
        if heartIsFilled {
            view_model.StageDelete(product_id: view_model.product!.variants![0].id!)
            
        }
        else {
            view_model.createFavourite()
        }

    }
    func colorheart(colored : Bool){
        if colored {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartIsFilled = true
        }
        else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartIsFilled = false
        }
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("view did load")
        view_model.id = product_id
        view_model.myView = self
        view_model.bindresultToProductsViewController = {(check : Bool ) -> Void in
            DispatchQueue.main.async {
                self.colorheart(colored: check)
            }
        }
        view_model.initializeProduct()
        setOptionsView ()
        setproductImagesCollectionView()
        setReviewsView()
        hideAddToCart()
        navigationItem.setRightBarButtonItems([addFavouriteButton()], animated: true)
       setHeartButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        optionsCollectionView.reloadData()
        
        var height = optionsCollectionView.collectionViewLayout.collectionViewContentSize.height
        optionsHeight.constant = height
        
        height = reviewsCollectionView.collectionViewLayout.collectionViewContentSize.height
        reviewsHeight.constant = height
        view.layoutIfNeeded()
        
    }
    
    func showAddToCart () {
        if (addToCartView.isHidden) {
            scroll_and_add_to_cart_vertical_spacing.constant = 0;
            addToCartView.isHidden = false;
            view.layoutIfNeeded()
        }
    }
    
    func hideAddToCart () {
        if (!addToCartView.isHidden) {
            scroll_and_add_to_cart_vertical_spacing.constant = -addToCartView.frame.height;
            addToCartView.isHidden = true
            view.layoutIfNeeded()
        }
    }
    
    @IBAction func plus_button_tapped(_ sender: Any) {
        
        if (numberOfCartItems < variant_available_elements) {
            numberOfCartItems += 1;
        }
        
        updateNumberLabel()
        
        print("plus")
    }
    
    @IBAction func minus_button_tapped(_ sender: Any) {
        if (numberOfCartItems > 0) {
            numberOfCartItems -= 1;
        }
        updateNumberLabel()
        print("minus")
    }
    
  
    @IBAction func add_to_cart_tapped(_ sender: Any) {
          // mansour starts here
        let customerId = UserDefaultsHelper.shared.getCustomerId()
        
        guard customerId != 0 else {
            let cancelAction = UIAlertAction(title: "Close", style: .cancel)

            let joinAction = UIAlertAction(title: "Join us", style: .default) { [weak self] _ in
                AppDelegate.resetViewController()
            }

            Alert.showAlert(target: self, title: "Can't Add to shop cart!", message: "Would you like to join us!", actions: [cancelAction, joinAction])
            return
        }
        
          print("add to cart")
          var Mansour_selectedOptionValues : [Int] = selectedOption //
          
          guard let product = view_model.product else { return }
          
          
          let elements_to_be_added_to_cart : Int = numberOfCartItems;
          let quantity = elements_to_be_added_to_cart // same variable with different name.
          
          let productTitle = view_model.product?.title ?? "title Does not exist"
          let productId : Int = view_model.product?.id ?? 0 // use it in case data in variants is insufficient
          let imageString : String = view_model.product?.images.first?.src ?? "Beware :O .. Image Src is Empty"
          let price = Double(view_model.product?.variants?.first?.price ?? "1.0")
          let variantId = variant_Unique_ID
          let inventory_item_id = self.inventory_item_id
          let availableElements = variant_available_elements
        print(availableElements)
        
        print(variantId)
          
          let cartModel = ShoppingCartModel(title: productTitle, quantity: quantity, price: price, image: imageString, draftOrderId: productId, variantId: variantId, availableElements: availableElements, inventory_item_id: inventory_item_id)
          
          addToCart(cart: cartModel)
      }
  
}
// MARK: - Extension

extension ProductInfoViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if (collectionView == optionsCollectionView) {
            return view_model.numberOfOptions()
        }
        else if (collectionView == productImagesCollectionView) {
            return 1
        }
        else if (collectionView == reviewsCollectionView) {
            return 1
        }
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == optionsCollectionView) {
            return view_model.product?.options?[section].values?.count ?? 6
        }
        else if (collectionView == productImagesCollectionView) {
            return view_model.product?.images.count ?? 0
        }
        else if (collectionView == reviewsCollectionView) {
            return 3
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == optionsCollectionView) {
            let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: "OptionCollectionViewCell", for: indexPath) as! OptionCollectionViewCell
        
            //cell.setOptionValue(value: "White")
            cell.setOptionValue(value: view_model.product?.options?[indexPath.section].values?[indexPath.item] ?? "default")
            
            return cell;
        }
        else if (collectionView == productImagesCollectionView) {
            let cell = productImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageCell", for: indexPath) as! ProductImageCell
            
            cell.configure(with: "coupon")
            
//            let img = UIImageView()
//            img.downloadImageFrom(view_model.product?.images[indexPath.item].src)
//            img.frame.size.height = img.superview?.frame.size.height ?? img.frame.size.height
//            img.frame.size.width = img.superview?.frame.size.width ?? img.frame.size.height
//
//            cell.couponImageView.image = img.getImageInsideView()
            cell.couponImageView.downloadImageFrom(view_model.product?.images[indexPath.item].src)
            
            cell.layer.cornerRadius = 30
            
            return cell;
        }
        else if (collectionView == reviewsCollectionView) {
            let cell = reviewsCollectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath) as! ReviewCollectionViewCell
            
            
            return cell;
        }
        
        let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: "OptionCollectionViewCell", for: indexPath) as! OptionCollectionViewCell
    
        cell.setOptionValue(value: "White")
        
        return cell;
    }
    
    func getOptionsCollectionViewHeaderName (indexPath: IndexPath) -> String{

        return view_model.product?.options?[indexPath.section].name ?? "Nil"
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeader.identifier, for: indexPath) as! sectionHeader
            
            
            if collectionView == optionsCollectionView {
                header.setHeaderValue(value: getOptionsCollectionViewHeaderName(indexPath: indexPath))
            }
            else if collectionView == reviewsCollectionView {
                header.setHeaderValue(value: "Reviews")
            }
            
            return header
        }
        return UICollectionViewCell()
    }
}

extension ProductInfoViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == productImagesCollectionView {
            return CGSize (width:  productImagesCollectionView.frame.width, height:  productImagesCollectionView.frame.height)
        }
        else if collectionView == reviewsCollectionView {
            return CGSize (width:  reviewsCollectionView.frame.width, height:  125)
        }
        
        return CGSize (width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == optionsCollectionView {
            
            let row = indexPath.section
            let value = indexPath.item
            toggleOption(row: row, value: value)
            
            if selectedOptionsCount == get_number_of_options() {
                get_variant_data()
                showAddToCart()
            }
            else {
                hideAddToCart()
            }
            print("toggle add to cart")
            print(selectedOptionsCount)
            reset_cart()
        }
    }
}
