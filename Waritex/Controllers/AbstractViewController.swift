//
//  AbstractViewController.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/10/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import Photos
import Toast_Swift
import MBProgressHUD
import Crashlytics

class AbstractViewController: UIViewController {
    var selectedProduct : Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ServerConstants.BackgroundColor
        self.navigationController?.navigationBar.barTintColor = ServerConstants.BackgroundColor
        self.navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
        if let nav = self.navigationController {
            nav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.init(red: 183.0/255.0, green: 28.0/255.0, blue: 28.0/255.0, alpha: 1.0)]
        }
    }
    static var currentViewController : AbstractViewController?
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AbstractViewController.currentViewController = self
    }
    /*
     * toastStyle property is the styler of the toast message
     */
    var toastStyle = ToastStyle();
    
    /*
     * MARK: function that show the message on the screen as a Toast
     */
    func showToastMessage(messag: String)
    {
        DispatchQueue.main.async {
            if(self.tabBarController != nil){
                let y = (self.view.frame.height - self.tabBarController!.tabBar.frame.height) - 50;
                let x = self.view.frame.width/2;
                self.tabBarController!.view.makeToast(messag, duration: 3.0, position: CGPoint(x: x, y: y), style: self.toastStyle)
            }else{
                self.view.makeToast(messag, duration: 3.0, position: .bottom, style: self.toastStyle)
            }
        }
    }
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        // TODO Segue to Info Screen
        performSegue(withIdentifier: "InfoSegue", sender: self)
    }
    /*
     *  MARK: public functionS that shows/hides the hud with loading text
     */
    var hudVisibile = false
    var hud : MBProgressHUD?
    func showLoading()
    {
        DispatchQueue.main.async
            {
                if self.hudVisibile == false
                {
                    self.hudVisibile = true
                    self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    self.hud?.mode = MBProgressHUDMode.annularDeterminate
                    self.hud?.label.text = "Loading"
                    
                }
        }
        
    }
    func openProduct(product: Product){
        //TODO Open product
        self.selectedProduct = product
        self.performSegue(withIdentifier: "ProductDetailSeuge", sender: nil)
    }
    func openPromotion(promotion: Promotion){
        //TODO Open Promotion
        self.performSegue(withIdentifier: "showPromotionSegue", sender: self)
    }
    func openPromotionDeeplink(promotionID : Int) {
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad : PromotionViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "PromotionViewController") as! PromotionViewController
        initialViewControlleripad.promotion = Promotion()
        initialViewControlleripad.promotion?.id = promotionID
        self.navigationController?.pushViewController(initialViewControlleripad, animated: true)
        

    }
    func hideLoading()
    {
        DispatchQueue.main.async {
            self.hud?.hide(animated: true)
            self.hud = nil
            self.hudVisibile = false
        }
        
    }
    let appID = "1262921612"

    func rateApp(){
        //Bundle.main.object(forInfoDictionaryKey: "appID") as! String
        let str = "itms-apps://itunes.apple.com/app/id" + appID;
        if let url = URL(string: str) {
            UIApplication.shared.openURL(url)
        }
    }
    func shareApp(){
        let textToShare = "Check out Waritex is!"
        let str = "itms-apps://itunes.apple.com/app/id" + appID;

        if let myWebsite = URL(string: str) {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true) {
            }
        }

    }
}
