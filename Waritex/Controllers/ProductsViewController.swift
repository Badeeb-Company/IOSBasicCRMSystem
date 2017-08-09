//
//  ProductsViewController.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/16/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

class ProductsViewController: AbstractViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var products : [Product] = []
    var currentPage : Int = 1
    var page : Int = 1
    var pageSize = 20
    @IBOutlet weak var productsCollectionView: UICollectionView!
    override func viewDidLoad() {

        super.viewDidLoad()
        self.productsCollectionView.addSubview(self.refreshControl)

        self.loadData(page: page)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData(page: page)
        self.selectedProduct = nil
    }
    func loadData(page: Int) {
        let manager = ProductsManager()
        self.showLoading()
        manager.getProducts(page: page, pageSize: pageSize) { (result) in
            if self.page == 1 {
                if let products = result.results as? [Product]{
                    self.products = products
                }
            }else{
                if let products = result.results as? [Product]{

                let newProducts = products
                self.products.append(contentsOf: newProducts)
                }
            }
            self.hideLoading()
            self.productsCollectionView.reloadData()
        }
    }
    
    // MARK: Table View Delegate & Data Source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: "prodcutCell", for: indexPath) as! ProductCell
        self.willShowRow(indexPath: indexPath)
        if indexPath.row < products.count {
            let product = products[indexPath.row]
            cell.bindCell(product: product)
        }
        return cell
    }
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ProductsViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        page = 1
        self.loadData(page: page)
        refreshControl.endRefreshing()
    }

    func willShowRow(indexPath: IndexPath) {
        print("Will display index = \(indexPath.row), overall = \(page * pageSize)")
        if indexPath.row > (pageSize * page - (pageSize/2)) {
            print("Next Page")
            page = page+1
            loadData(page: page)
        }else{
            print("No Need")
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO Open Promotion
        if indexPath.row < products.count {
            let product = products[indexPath.row]
            self.openProduct(product: product)

        }
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 5.0) / 2.0
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductDetailSeuge" {
            if let dest = segue.destination as? ProductViewController {
                if let prod = self.selectedProduct {
                    dest.product = prod
                }
            }
        }
        segue.destination.hidesBottomBarWhenPushed = true
    }
}
