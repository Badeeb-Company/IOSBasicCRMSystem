//
//  NotificationViewController.swift
//  WaritexPromotions
//
//  Created by Mostafa on 7/8/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

class NotificationViewController: AbstractTabViewController,UITableViewDataSource {
    
    var currentPage : Int = 1
    
    var notifications : [Notification] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navig = self.navigationController?.navigationBar {
            print(navig)
            self.navigationController?.navigationBar.tintColor = UIColor.init(red: 183.0/255.0, green: 28.0/255.0, blue: 28.0/255.0, alpha: 1.0)
            
        }

        self.loadData(page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData(page: page)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 10))
        view.backgroundColor = UIColor.clear
        return view
    }
    override func loadData(page: Int) {
        
        let manager = NotificationManager()
        self.showLoading()
        manager.getNotifications(page: page, pageSize: pageSize) { (result) in
            if self.page == 1 {
                if let array = result.results as? [Notification]{
                    self.notifications = array
                }
            }else{
                if let array = result.results as? [Notification]{
                    let newNotifications = array
                    self.notifications.append(contentsOf: newNotifications)
                }
            }
            self.hideLoading()
            self.tableView.reloadData()
        }
    }
    
    // MARK: Table View Delegate & Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < notifications.count {
            let notification = notifications[indexPath.row]
            let width = UIScreen.main.bounds.width - 26
            return NotificationCell.heightForLabel(text: notification.desc, width: width)
        }
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        if indexPath.row < notifications.count {
            let notification = notifications[indexPath.row]

            cell.bindCell(notification: notification)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
}
