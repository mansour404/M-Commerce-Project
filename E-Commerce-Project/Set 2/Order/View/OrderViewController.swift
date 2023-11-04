//
//  PaymentViewController.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 19/10/2023.
//

import UIKit

class OrderViewController: UIViewController {
    
    // MARK: - Vars
    private let shoppinViewModel: ShoppingCartViewModel = ShoppingCartViewModel()
    private let orderViewModel: OrderViewModel = OrderViewModel()
    var totalPrice: Double = 1.0
    var currencySymbol: String = ""
    
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
        
        bindViewModel()
        shoppinViewModel.fetchCartProducts()
        
        couponTextField?.delegate = self
        applyCouponButton?.isUserInteractionEnabled = false
        applyCouponButton?.alpha = 0.5
    }

    // MARK: - Actions
    @IBAction func applyCouponButtonPressed(_ sender: Any) {
        // binding
        orderViewModel.bindToOrderVC = { [weak self] in
            guard let self = self else { return }
            // 3 things,
            // update discountMoneyLabel
            // totalMoneyLabel: UILabel!
            //

            //discountMoneyLabel.text =
            print("inside bind")
            guard let couponText = self.couponTextField.text else { return }
            let type = self.orderViewModel.get_discount_type(code: couponText)
            let amount = self.orderViewModel.get_discount_amount(code: couponText)
            
            if (type != nil && amount != nil) {
                // Print
                print("+++++++++++++")
                print(type!, amount!)
                print("+++++++++++++")
                
                if type == "percentage" {
                    // summer discount, code
                    //  dream1, code
                    let positiveAmount = -1 * amount!
                    let precentageValueInDouble = self.totalPrice / positiveAmount // positive value
                    let priceAfterDiscount = self.totalPrice - precentageValueInDouble
                    // Update Labels
                    self.discountMoneyLabel.text = "\(precentageValueInDouble)" + "  " + currencySymbol
                    self.totalMoneyLabel.text = "\(priceAfterDiscount)"  + "  " + currencySymbol
                    // Update final cost
                    UserDefaultsHelper.shared.setFinalTotalCost(priceAfterDiscount)
                } else /* "fixed_amount"*/ {
                    let priceAfterDiscount = totalPrice + amount!
                    self.discountMoneyLabel.text = "\(amount!)" + "  " + currencySymbol
                    // Update Labels
                    self.totalMoneyLabel.text = String(priceAfterDiscount) + "  " + currencySymbol
                    // Update final cost
                    UserDefaultsHelper.shared.setFinalTotalCost(priceAfterDiscount)
                }
            }
        }
        
        orderViewModel.fetchPriceRules()
    }
    
    @IBAction func checkoutButtonPressed(_ sender: Any) {
        // PaymentView
        //let vc = PaymentView(nibName: "PaymentView", bundle: nil)
        let vc = AddressListView(nibName: "AddressListView", bundle: nil)
        // passing data before navigation
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Function
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        // Register cell
        let nib = UINib(nibName: "ProductItemCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ProductItemCell")
    }
    
    private func configureButtonsUI() {
        applyCouponButton.addCornerRadius()
        checkoutButton.addCornerRadius()
    }
    
    private func bindViewModel() {
        shoppinViewModel.reloadTableViewClosure = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        shoppinViewModel.updateTotalPriceClosure = { [weak self] (totalPrice , symbol) in
            self?.subtotalMoneyLabel.text = String(totalPrice) + "  " + symbol
            self?.totalMoneyLabel.text = String(totalPrice) + "  " + symbol
            self?.discountMoneyLabel.text = "0.00" + "  " + symbol
//            var validPrice = totalPrice
//            validPrice.removeLast(5)
            self?.totalPrice = totalPrice
            self?.currencySymbol = symbol
        }
    }
}

// MARK: - Data source
extension OrderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppinViewModel.cartProductsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductItemCell", for: indexPath) as? ProductItemCell else { return UICollectionViewCell() }
        shoppinViewModel.configureCollectionViewCell(cell, at: indexPath.item)
        return cell
    }
}

// MARK: - Delegate
extension OrderViewController: UICollectionViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 196
    }
}

// MARK: - Delegate flow layout
extension OrderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.8
        let height = collectionView.frame.height * 0.9
        let size = CGSize(width: width, height: height)
        return size
    }
}

// MARK: - TextField Delegate
extension OrderViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if !text.isEmpty{
            applyCouponButton?.isUserInteractionEnabled = true
            applyCouponButton?.alpha = 1.0
        } else {
            applyCouponButton?.isUserInteractionEnabled = false
            applyCouponButton?.alpha = 0.5
        }
        return true
    }
}
