//
//  AbstractTabViewController.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/10/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

class AbstractTabViewController: AbstractViewController,UITableViewDelegate {
    let pageSize = 10
    var page = 1
    @IBOutlet weak var tobView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addSubview(self.refreshControl)

    }
    
   
   
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(AbstractTabViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
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

    func loadData(page: Int){
        //TODO Override
        print("Load Data")
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.willShowRow(indexPath: indexPath)
    }
}
