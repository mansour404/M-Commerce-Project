//
//  PaymentView.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 19/10/2023.
//

import UIKit
import PassKit

enum PaymentState {
    case selected
    case notSelected
}

class PaymentView: UIViewController {
    
    // MARK: - Vars
    var isHiddenFlag: Bool = true
    var cashState: PaymentState = .notSelected
    var creditState: PaymentState = .notSelected
    

    // MARK: - Outlets
    @IBOutlet weak var creditCardView: UIView!
    @IBOutlet weak var cashOnDeliveryView: UIView!
    @IBOutlet weak var creditSelectedImageView: UIImageView!
    @IBOutlet weak var cashSelectedImageView: UIImageView!
    
    @IBOutlet weak var orderInfoView: UIView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupGestureRecognizer()
    }
    
    @IBAction func checkoutButtonPressed(_ sender: Any) {
        // TODO: - Present view controller of apple pay at the bottom of the view controller
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        checkoutButton.addCornerRadius()
        checkoutButton.isEnabled = false
        creditSelectedImageView.isHidden = true
        cashSelectedImageView.isHidden = true
        configureCardView(creditCardView)
        configureCardView(cashOnDeliveryView)
    }
    
    private func configureCardView(_ view: UIView) {
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.dropShadow()
    }
    
    // MARK: - Setup gesture recognizer
    func setupGestureRecognizer() {
        let creditGesture = UITapGestureRecognizer(target: self, action: #selector(getFiredCredit(_:)))
        let cashGesture = UITapGestureRecognizer(target: self, action: #selector(getFiredCash(_:)))

        addGesture(view: creditCardView, gesture: creditGesture)
        addGesture(view: cashOnDeliveryView, gesture: cashGesture)
    }
    
    private func addGesture(view: UIView, gesture:UITapGestureRecognizer) {
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
    }

    @objc func getFiredCredit(_ sender: UITapGestureRecognizer) {
        switch creditState {
        case .selected:
            creditSelectedImageView.isHidden = true
            checkoutButton.isEnabled = false
            creditState = .notSelected
        case .notSelected:
            creditSelectedImageView.isHidden = false
            checkoutButton.isEnabled = true
            creditState = .selected
        }
        cashSelectedImageView.isHidden = true
        cashState = .notSelected
    }
    
    @objc func getFiredCash(_ sender: UITapGestureRecognizer) {
        switch cashState {
        case .selected:
            cashSelectedImageView.isHidden = true
            checkoutButton.isEnabled = false
            cashState = .notSelected
        case .notSelected:
            cashSelectedImageView.isHidden = false
            checkoutButton.isEnabled = true
            cashState = .selected
        }
        creditSelectedImageView.isHidden = true
        creditState = .notSelected
    }
}

/*
//    @objc func underTest(_ sender: UITapGestureRecognizer? = nil, firstState: UnsafeMutablePointer<PaymentState>, secondState: UnsafeMutablePointer<PaymentState>, firstView: UIView, secondView: UIView) {
//        switch firstState.pointee {
//        case .selected:
//            firstView.isHidden = true
//            checkoutButton.isEnabled = false
//            firstState.pointee = .notSelected
//        case .notSelected:
//            firstView.isHidden = false
//            checkoutButton.isEnabled = true
//            firstState.pointee = .selected
//        }
//        secondView.isHidden = true
//        secondState.pointee = .notSelected
//    }
 */
