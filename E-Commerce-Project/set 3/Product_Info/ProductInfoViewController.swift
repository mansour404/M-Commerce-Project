//
//  ProductInfoViewController.swift
//  E-Commerce-Project
//
//  Created by Admin on 19/10/2023.
//

import UIKit

class ProductInfoViewController: UIViewController {
    
    let heartButton = UIButton(type: .custom) // treat it as an outlet
    var heartIsFilled : Bool = true;
    
    func toggleHeart () {
        if heartIsFilled {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        else {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        heartIsFilled = !heartIsFilled
    }
    
    @IBOutlet weak var addToCartView: UIView!
    @IBOutlet weak var scroll_and_add_to_cart_vertical_spacing: NSLayoutConstraint!
    
    @IBOutlet weak var reviewsHeight: NSLayoutConstraint!
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    
    
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    
    
    
    @IBOutlet weak var optionsHeight: NSLayoutConstraint!
    
    func setproductImagesCollectionView () -> Void {
        productImagesCollectionView.delegate = self;
        productImagesCollectionView.dataSource = self;
        
        productImagesCollectionView.register(UINib(nibName: "CopounCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CopounCollectionViewCell")
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
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func addFavouriteButton() -> UIBarButtonItem {
        
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        heartButton.tintColor = UIColor.systemPurple
        heartButton.addTarget(self, action: #selector(heartButtonPressed), for: .touchUpInside)

        let heartBarButtonItem = UIBarButtonItem(customView: heartButton)
        return heartBarButtonItem
    }
    
    @objc func heartButtonPressed(sender: UIButton) {
//        let vc = FavouriteListVCViewController(nibName: "FavouriteListVCViewController", bundle: nil)
//        // passing data before navigation
//        //navigationController?.pushViewController(vc, animated: true)
//        vc.modalPresentationStyle = .automatic
//        self.present(vc, animated: true)
        print("heart button is pressed")
        
        toggleHeart()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setOptionsView ()
        setproductImagesCollectionView()
        setReviewsView()
        
        hideAddToCart()
        
        navigationItem.setRightBarButtonItems([addFavouriteButton()], animated: true)
        
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
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        optionsCollectionView.reloadData()
        
        var height = optionsCollectionView.collectionViewLayout.collectionViewContentSize.height
        optionsHeight.constant = height
        
        height = reviewsCollectionView.collectionViewLayout.collectionViewContentSize.height
        reviewsHeight.constant = height
        
        
        
        view.layoutIfNeeded()
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProductInfoViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if (collectionView == optionsCollectionView) {
            return 3
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
            return 10
        }
        else if (collectionView == productImagesCollectionView) {
            return 5
        }
        else if (collectionView == reviewsCollectionView) {
            return 4
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == optionsCollectionView) {
            let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: "OptionCollectionViewCell", for: indexPath) as! OptionCollectionViewCell
        
            cell.setOptionValue(value: "White")
            
            return cell;
        }
        else if (collectionView == productImagesCollectionView) {
            let cell = productImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "CopounCollectionViewCell", for: indexPath) as! CopounCollectionViewCell
            
            cell.configure(with: "coupon")
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
        if indexPath.section == 0 {
            return "First header"
        }
        else if indexPath.section == 1 {
            return "Second header"
        }
        else if indexPath.section == 2 {
            return "third header"
        }
        return "Default"
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeader.identifier, for: indexPath) as! sectionHeader
//
//        header.setHeaderValue(value: getHeaderName(indexPath: indexPath))
//
//        return header
//    }
    
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
        if (addToCartView.isHidden == true) {
            showAddToCart()
        }
        else {
            hideAddToCart()
        }
        
        print("toggle add to cart")
        print("an item is pressed")
    }
    
    
}
