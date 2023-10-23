//
//  CategoriesViewController.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 18/10/2023.
//

import UIKit

class CategoriesViewController: UIViewController {
    // MARK: - Variables
    @IBOutlet weak var subMainCollectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "Categories"
        configureCollectionView()

    }
    // MARK: - Configure CollectionView
    private func configureCollectionView() {
        subMainCollectionView.dataSource = self
        subMainCollectionView.delegate = self
        //Registers
        subMainCollectionView.register(UINib(nibName: CellIdentifier.submainCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.submainCollectionViewCell)
    }
}

// MARK: - UICollectionView DataSource
extension CategoriesViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = subMainCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.submainCollectionViewCell, for: indexPath) as! SubmainCollectionViewCell
        return cell
        
    }

}


// MARK: - UICollectionView Delegate

extension CategoriesViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (subMainCollectionView.frame.width / 2) - 10 , height: (subMainCollectionView.frame.height) / 2.5 )
    }
}

