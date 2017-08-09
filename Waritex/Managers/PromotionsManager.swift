//
//  PromotionsManager.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/16/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import Alamofire
import ReachabilitySwift
import CoreLocation

class PromotionsManager : AbstractManager{
    func getPromotionVendors(page: Int, pageSize: Int, promotion: Promotion, handler: @escaping (APIResponse) -> Void) -> Void {
        if Reachability.init()?.isReachable == false
        {
            // no Internet connection
            let response = APIResponse()
            response.error = NSError.init(domain: "waritex", code: 300, userInfo: nil)
            handler(response)
            return
        }
        let url = URL.init(string: "\(ServerConstants.promotionVendorsURL)\(promotion.id)/vendors.json")
        let params :[String : Any] = ["page": page, "page_size": pageSize, "lng": 0 , "lat" : 0]
        let headers = HTTPHeaders.init()
        Alamofire.request(url!, method: .get, parameters: params, headers: headers).responseJSON
            {response in
                switch response.result {
                case .success(let value):
                    if let resultDict = value as? NSDictionary {
                        if let data = resultDict.value(forKey: "data") as? NSDictionary {
                            if let dictArray = data.value(forKey: "vendors") as? [NSDictionary] {
                                var vendors : [Vendor] = []
                                for dict in dictArray {
                                    let vendor = Vendor()
                                    vendor.bindModel(dict)
                                    vendors.append(vendor)
                                }
                                let apiResponse = APIResponse()
                                apiResponse.results = vendors
                                handler(apiResponse)
                                return
                            }
                        }
                    }
                    break
                default:
                    let response = APIResponse()
                    response.error = NSError.init(domain: "waritex", code: 300, userInfo: nil)
                    handler(response)
                    break;
                }
                let response = APIResponse()
                response.error = NSError.init(domain: "waritex", code: 300, userInfo: nil)
                handler(response)
                
                
        }
        
    }
    func getPromotions(page: Int, pageSize: Int, expired: Bool, handler: @escaping (APIResponse) -> Void) -> Void {
        if Reachability.init()?.isReachable == false
        {
            // no Internet connection
            let response = APIResponse()
            response.error = NSError.init(domain: "waritex", code: 300, userInfo: nil)
            handler(response)
            return
        }
        let url = URL.init(string: ServerConstants.promotionsURL)
        let params :[String : Any] = ["page": page, "page_size": pageSize, "expired":"\(expired)"]
        let headers = HTTPHeaders.init()
        Alamofire.request(url!, method: .get, parameters: params, headers: headers).responseJSON
            {response in
                switch response.result {
                case .success(let value):
                    if let resultDict = value as? NSDictionary {
                        if let data = resultDict.value(forKey: "data") as? NSDictionary {
                            if let dictArray = data.value(forKey: "promotions") as? [NSDictionary] {
                                var promotions : [Promotion] = []
                                for dict in dictArray {
                                    let promotion = Promotion()
                                    promotion.bindModel(dict)
                                    promotions.append(promotion)
                                }
                                let apiResponse = APIResponse()
                                apiResponse.results = promotions
                                handler(apiResponse)
                                return
                            }
                        }
                    }
                    break
                default:
                    let response = APIResponse()
                    response.error = NSError.init(domain: "waritex", code: 300, userInfo: nil)
                    handler(response)
                    break;
                }
                let response = APIResponse()
                response.error = NSError.init(domain: "waritex", code: 300, userInfo: nil)
                handler(response)


        }

    }
    
    
    func getPromotionDetails(promotion:Promotion, handler: @escaping (APIResponse) -> Void) -> Void {
        if Reachability.init()?.isReachable == false
        {
            // no Internet connection
            let response = APIResponse()
            response.error = NSError.init(domain: "waritex", code: 300, userInfo: nil)
            handler(response)
            return
        }
        let url = URL.init(string: "\(ServerConstants.promotionsDetailsURL)\(promotion.id).json")
        let headers = HTTPHeaders.init()
        Alamofire.request(url!, method: .get, parameters: nil, headers: headers).responseJSON
            {response in
                switch response.result {
                case .success(let value):
                    if let resultDict = value as? NSDictionary {
                        if let data = resultDict.value(forKey: "data") as? NSDictionary {
                            if let dict = data.value(forKey: "promotion_info") as? NSDictionary {
                                let details = PromotionDetail()
                                details.bindModel(dict)
                                let apiResponse = APIResponse()
                                apiResponse.result = details
                                handler(apiResponse)
                                return
                            }
                        }
                    }
                    break
                default:
                    let response = APIResponse()
                    response.error = NSError.init(domain: "waritex", code: 300, userInfo: nil)
                    handler(response)
                    break;
                }
                let response = APIResponse()
                response.error = NSError.init(domain: "waritex", code: 300, userInfo: nil)
                handler(response)
                
                
        }
        
    }

}
