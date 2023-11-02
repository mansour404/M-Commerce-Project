//
//  PaymentView.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 19/10/2023.
//

import UIKit
import PassKit
import Lottie


enum PaymentState {
    case selected
    case notSelected
}

class PaymentView: UIViewController {
    
    // MARK: - Vars
    var viewModel: PaymentViewModel!
    var address: Address?
    var isHiddenFlag: Bool = true
    var cashState: PaymentState = .notSelected
    var creditState: PaymentState = .notSelected
    var finalTotalCost: Double = 0.0
    
    private var paymentRequest: PKPaymentRequest {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.com.shopifyApp.ITI"
        request.supportedNetworks = [.visa, .masterCard, .quicPay]
        request.supportedCountries = ["US", "EG", "QA", "AE", "SA"]
        request.merchantCapabilities = .capability3DS
        
        request.countryCode = "EG"
        request.currencyCode = "EGP"
        
        finalTotalCost = UserDefaultsHelper.shared.getFinalTotalCost()
        let roundedCost = Double(String(format:"%.2f", finalTotalCost)) ?? 1.00
        let _ = (finalTotalCost * 100).rounded() / 100
        let amount = NSDecimalNumber(value: roundedCost)
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Order Cost", amount: amount)]
        
        return request
    }
    private var animationView: LottieAnimationView?


    // MARK: - Outlets
    @IBOutlet weak var creditCardView: UIView!
    @IBOutlet weak var cashOnDeliveryView: UIView!
    @IBOutlet weak var creditSelectedImageView: UIImageView!
    @IBOutlet weak var cashSelectedImageView: UIImageView!
    
    @IBOutlet weak var orderInfoView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!

    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        finalTotalCost = UserDefaultsHelper.shared.getFinalTotalCost()
        configureUI()
        setupGestureRecognizer()
        viewModel = PaymentViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //isChoosePaymentMethod()
    }
    
    // MARK: - Actions
    @IBAction func checkoutButtonPressed(_ sender: Any) {
        
        //viewModel.postOrder(order: order)
        finalTotalCost = 0.0
        UserDefaultsHelper.shared.setFinalTotalCost(finalTotalCost)
        //viewModel.updateVar()
        
        if creditState == .selected {
            // TODO: - Present view controller of apple pay at the bottom of the view controller
            presentPaymentController()
        }else{
            // only play animaton for cash on delivery
            playAnimation()
        }
        
        // TODO: - Reset coupon.
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        checkoutButton.addCornerRadius()
        checkoutButton.isEnabled = false
        creditSelectedImageView.isHidden = true
        cashSelectedImageView.isHidden = true
        configureCardView(creditCardView)
        configureCardView(cashOnDeliveryView)
        
        orderInfoView.layer.cornerRadius = 20
        orderInfoView.clipsToBounds = true
        orderInfoView.dropShadow()
        
        totalLabel.text = String(finalTotalCost)
    }
    
    private func configureCardView(_ view: UIView) {
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.dropShadow()
    }
    
    private func presentPaymentController() {
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        if controller != nil {
            controller!.delegate = self
            self.present(controller!, animated: true) {
                print("Completed Order")
            }
        }
    }
    
    private func isChoosePaymentMethod() {
        if cashState == .selected || creditState == .selected {
            bottomLayoutConstraint.constant = 16
            UIView.animate(withDuration: 1.2) {
                self.view.layoutIfNeeded()
            }
        } else {
            bottomLayoutConstraint.constant = -220
            UIView.animate(withDuration: 1.0) {
                self.view.layoutIfNeeded()
            }
        }
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
        isChoosePaymentMethod()
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
        isChoosePaymentMethod()
    }
}

// MARK: - PKPayment Authorization ViewController Delegate
extension PaymentView: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.finalTotalCost = 0.0
            // TODO: - Get currency Symbol and add it after final cost on label
            self.totalLabel.text = "\(0.0) EGP"
            //viewModel.decreaseVariantCountByOrderAmount()
            self.viewModel.postOrder()
            self.playAnimation()
        }
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult.init(status: .success, errors: nil))
    }
}

// MARK: - Lootie Animation
extension PaymentView {
    
    func playAnimation() {
        animationView = .init(name: "Payment_Successful")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        // 4. Set animation loop mode
        animationView!.loopMode = .playOnce
        view.addSubview(animationView!)
        // 6. Play animation
        animationView?.play { [weak self] _ in
            self?.animationView?.removeFromSuperview()
            self?.navigateToRootVC()
        }
    }
    
    
    func navigateToRootVC(){
        let alert = Alert.showAlertWithMessage(title: "Congratulations", message: "Successful payment done", buttonTitle: "Ok") { action in
            //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true) // doesn't work
            //self.dismissViewControllers() // doesn't work
        }
        self.present(alert, animated: true)
    }
    
//    func dismissViewControllers() {
//        guard let vc = self.presentingViewController else { return }
//        while (vc.presentingViewController != nil) {
//            vc.dismiss(animated: true, completion: nil)
//        }
//    }
    
}

/*
 // A Failure attempt to make a toggle function for the two views.
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
