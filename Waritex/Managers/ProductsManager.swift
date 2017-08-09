//
//  ProductManager.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/16/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import Alamofire
import ReachabilitySwift
import CoreLocation

class ProductsManager : AbstractManager{
    
    func getProducts(page: Int, pageSize: Int, handler: @escaping (APIResponse) -> Void) -> Void {
        if Reachability.init()?.isReachable == false
        {
            // no Internet connection
            let response = APIResponse()
            response.error = NSError.init(domain: "waritex", code: 300, userInfo: nil)
            handler(response)
            return
        }
        let url = URL.init(string: ServerConstants.productsURL)
        let params :[String : Any] = ["page": page, "page_size": pageSize]
        let headers = HTTPHeaders.init()
        Alamofire.request(url!, method: .get, parameters: params, headers: headers).responseJSON
            {response in
                switch response.result {
                case .success(let value):
                    if let resultDict = value as? NSDictionary {
                        if let data = resultDict.value(forKey: "data") as? NSDictionary {
                            if let dictArray = data.value(forKey: "products") as? [NSDictionary] {
                                var products : [Product] = []
                                for dict in dictArray {
                                    let product = Product()
                                    product.bindModel(dict)
                                    products.append(product)
                                }
                                let apiResponse = APIResponse()
                                apiResponse.results = products
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
