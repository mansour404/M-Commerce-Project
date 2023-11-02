//
//  AddressListView.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import UIKit

class AddressListView: UIViewController {
    
    // MARK: - Vars
    lazy var viewModel: AddressViewModel = {
        return AddressViewModel() // initialized the default parameters
    }()
    
    
    // MARK: - Outlets
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var addNewAddressButton: UIButton!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCartTableView()
        configureCheckoutButton()
        //emptyView.isHidden = true
        
        // init view model
        initVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initVM()
        print("1")
    }

    // MARK: - Actions
    @IBAction func continueButtonPressed(_ sender: Any) {
        // TODO: - Change App Flow, make shoping list view controllers before payment directly.
        let vc = OrderViewController(nibName: "OrderViewController", bundle: nil)
//        let vc = PaymentView(nibName: "PaymentView", bundle: nil)
        // passing data before navigation
        //        pay.order = order
        //        pay.orderTotalPrice = Double(order?.totalPrice ?? "") ?? 0
        //vc.address = viewModel.shippingAddress
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addNewAddressButtonPressed(_ sender: Any) {
        let vc = NewAddressView(nibName: "NewAddressView", bundle: nil)
        vc.delegate = self // set delegate/(reference) = self
        // passing data before navigation
        navigationController?.pushViewController(vc, animated: true)
//        vc.modalPresentationStyle = .automatic
//        self.present(vc, animated: true)
    }
    
    // MARK: - Functions
    func configureCartTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "AddressCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AddressCell")
    }
    
    func configureCheckoutButton() {
        continueButton.addCornerRadius()
        addNewAddressButton.addCornerRadius()
    }
}

// MARK: - Table view data source
extension AddressListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as? AddressCell else { return UITableViewCell()}
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.addressCellViewModel = cellVM
        return cell
    }
}

// MARK: - Table view delegate
extension AddressListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if viewModel.getCellViewModel(at: indexPath).isDefault == false {
                let alertController = UIAlertController(title: "Warning", message: "Are you sure u want to delete address from list?", preferredStyle: .actionSheet)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { [weak self] action in
                    guard let self = self else { return }
                    
                    viewModel.removeAddress(indexPath: indexPath)
                    initVM()
                }
                alertController.addAction(cancelAction)
                alertController.addAction(confirmAction)
                present(alertController, animated: true)
            } else {
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                Alert.showAlert(target: self, title: "Rejected", message: "Can't remove default address", actions: [cancelAction])
            }
            
        }
        
        // TODO: - add edit option for editingStyle == .insert
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - Did select row at index path
        viewModel.selectAddressForShipping(indexPath: indexPath)
    }
    
}


// MARK: - Binding
extension AddressListView {
    
    func initVM() {
        // MARK: Naive binding: Set the closure implementation for AddressListView
        // Don't forget to fetch data
        viewModel.getAllAddresses()
        // 1
        viewModel.reloadAddressTableViewClosure = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
        }
    }
    
    func updateTableView(at indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

// MARK: - Delegate Protocol
extension AddressListView: DelegateProtocol { // confirm protocol
    func backValue(address: Address?) {
        guard let address = address else { return }
        viewModel.creatNewAddress(address: address)
        initVM()
    }
}
