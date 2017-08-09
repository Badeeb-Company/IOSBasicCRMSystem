//
//  PromotionViewController.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/23/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class PromotionViewController: AbstractViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var promotionTitleLabel: UILabel!
    @IBOutlet weak var promotionDetailsTextView: UITextView!
    @IBOutlet weak var promotionDateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIView!
    
    var scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:320,height: 150))
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var frame: CGRect = CGRect(x:0, y:100, width:0, height:0)
    var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:0,y: 0, width:200, height:50))
    
    
    var promotion : Promotion?
    var promotionDetails : PromotionDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutSubviews()
        self.promotionDetailsTextView.textColor = ServerConstants.TextColor
        if let navig = self.navigationController?.navigationBar {
            print(navig)
            self.navigationController?.navigationBar.tintColor = UIColor.init(red: 183.0/255.0, green: 28.0/255.0, blue: 28.0/255.0, alpha: 1.0)
            
        }
        self.configureScrollView()

        self.loadPromotion()
    }
    func loadPromotion() {
    
        if let prom = self.promotion {
            let manager = PromotionsManager()
            self.showLoading()
            manager.getPromotionDetails(promotion: prom, handler: { (response) in
                self.hideLoading()
                if let details = response.result as? PromotionDetail {
                    self.promotionDetails = details
                    self.configureScrollView()
                    self.promotionTitleLabel.text = details.title
                    self.promotionDateLabel.text = "ساري حتي : \(details.dueDate)"
                    //self.promotionDetailsLabel.text = details.desc
                    self.promotionDetailsTextView.text = details.desc
                }
            })
        }
    }
    // MARK: Page Control
    @IBOutlet weak var describtionView: UIView!
    
    func configureScrollView(){
        scrollView.removeFromSuperview()
        // Do any additional setup after loading the view, typically from a nib.
        let height = (UIScreen.main.bounds.width * 868.0/1188.0) + 35
        scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:self.view.bounds.width,height: height))
        var frame = self.imageView.frame
        frame.size.height = scrollView.frame.height
        self.imageView.frame = frame
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: imageView.frame.height)
        self.imageView.addConstraint(heightConstraint)
        pageControl = UIPageControl(frame: CGRect(x:self.view.bounds.width/2 - 100,y: scrollView.bounds.height + scrollView.frame.origin.y, width:200, height:9))
        configurePageControl()
        self.view.layoutIfNeeded()
 
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        self.imageView.addSubview(scrollView)
        //        self.view.sendSubview(toBack: scrollView)
        if let details = self.promotionDetails {
        for index in 0...(details.photos.count-1) {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            print(index)
            frame.size = self.scrollView.frame.size
            self.scrollView.isPagingEnabled = true
            frame.origin.y = 0
            let subView = UIView(frame: frame)
            var imageFrame = subView.bounds
            imageFrame.size.height = imageFrame.size.height  - 35
            imageFrame.origin.x = 0
            imageFrame.origin.y = 0
            imageFrame.size.width = imageFrame.size.width - (imageFrame.origin.x * 2.0)
            let imageView = UIImageView.init(frame: imageFrame)
            imageView.contentMode = .scaleAspectFill
            if let url = URL.init(string: details.photos[index].url){
                
                imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "imgPlaceholder"))
            }else{
                imageView.image = #imageLiteral(resourceName: "imgPlaceholder")
            }
            imageView.clipsToBounds = true
            subView.addSubview(imageView)
            self.scrollView.addSubview(subView)
            }
            self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * CGFloat(details.photos.count),height: self.scrollView.frame.size.height)

        }
        self.scrollView.semanticContentAttribute = .forceLeftToRight
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        pageControl.semanticContentAttribute = .forceLeftToRight
    }
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        if let prom = self.promotionDetails {
            self.pageControl.numberOfPages = prom.photos.count
        }else{
            self.pageControl.numberOfPages = 0
        }
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.init(red: 87.0/255.0, green: 166.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        self.view.addSubview(pageControl)
        
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    @IBAction func showVendors(_ sender: UIButton) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? VendorsViewController {
            dest.promotion = self.promotion
            dest.promotionDetails = self.promotionDetails
        }
    }
    

}
