//
//  ProductsViewController.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 21/10/2023.
//

import UIKit

class ProductsViewController: UIViewController {
    // MARK: - Variables
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButtonOutlet: UIButton!
    @IBOutlet weak var rateFilterButtonOutlet: UIButton!
    @IBOutlet weak var priceFilterButtonOutlet: UIButton!
    @IBOutlet weak var charFilterButtonOutlet: UIButton!
    
    var buttonHidden:Bool = true
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Products"
        configureCollectionView()
        rateFilterButtonOutlet.isHidden = true
        priceFilterButtonOutlet.isHidden = true
        charFilterButtonOutlet.isHidden = true

        
    }
    // MARK: - Configure CollectionView
    private func configureCollectionView() {
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        //Registers
        productsCollectionView.register(UINib(nibName: CellIdentifier.productsCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.productsCollectionViewCell)
        
    }
    // MARK: - ACTIONS
    @IBAction func filterButtonTapped(_ sender: Any) {
        if buttonHidden{
            rateFilterButtonOutlet.isHidden = false
            priceFilterButtonOutlet.isHidden = false
            charFilterButtonOutlet.isHidden = false
            buttonHidden = false
        } else {
            rateFilterButtonOutlet.isHidden = true
            priceFilterButtonOutlet.isHidden = true
            charFilterButtonOutlet.isHidden = true
            buttonHidden = true
        }

    }
    @IBAction func rateFilterButtonTapped(_ sender: Any) {
    }
    
    @IBAction func priceFilterButtonTapped(_ sender: Any) {
    }
    
    @IBAction func charFilterButtonTapped(_ sender: Any) {
    }
}
    // MARK: - UICollectionView DataSource
    extension ProductsViewController:UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            10
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.productsCollectionViewCell, for: indexPath) as! ProductsCollectionViewCell
            return cell
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = ProductInfoViewController(nibName: "ProductInfoViewController", bundle: nil)
            vc.modalPresentationStyle = .automatic
            self.present(vc, animated: true)
        }
    }
// MARK: - UICollectionView Delegate

extension ProductsViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (productsCollectionView.frame.width / 2) - 10 , height: (productsCollectionView.frame.height) / 2.5 )
    }
}



   


