//
//  PaymentViewController.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 19/10/2023.
//

import UIKit

class OrderViewController: UIViewController {
    
    // MARK: - Vars
    

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var couponTextField: UITextField!
    @IBOutlet weak var subtotalMoneyLabel: UILabel!
    @IBOutlet weak var discountMoneyLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var applyCouponButton: UIButton!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureButtonsUI()
    }

    // MARK: - Actions
    @IBAction func applyCouponButtonPressed(_ sender: Any) {
    }
    
    @IBAction func checkoutButtonPressed(_ sender: Any) {
    }
    
    // MARK: - Function
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "ProductItemCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ProductItemCell")
    }
    
    func configureButtonsUI() {
        applyCouponButton.addCornerRadius()
        checkoutButton.addCornerRadius()
    }
}

// MARK: - Data source
extension OrderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductItemCell", for: indexPath) as? ProductItemCell else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: - Delegate
extension OrderViewController: UICollectionViewDelegate {
    
}

// MARK: - Delegate flow layout
extension OrderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.8
        let height = collectionView.frame.height * 0.9
        let size = CGSize(width: width, height: height)
        return size
    }
}
