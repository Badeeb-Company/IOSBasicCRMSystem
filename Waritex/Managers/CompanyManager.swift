//
//  CompanyManager.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/26/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import Alamofire
import ReachabilitySwift
import CoreLocation

class CompanyManager : AbstractManager{
    func getCompanyInfo(handler: @escaping (APIResponse) -> Void) -> Void {
        if Reachability.init()?.isReachable == false
        {
            // no Internet connection
            let response = APIResponse()
            response.error = NSError.init(domain: "waritex", code: 300, userInfo: nil)
            handler(response)
            return
        }
        let url = URL.init(string: ServerConstants.companyInfoURL)
        let headers = HTTPHeaders.init()
        Alamofire.request(url!, method: .get, parameters: nil, headers: headers).responseJSON
            {response in
                switch response.result {
                case .success(let value):
                    if let resultDict = value as? NSDictionary {
                        if let data = resultDict.value(forKey: "data") as? NSDictionary {
                            if let dict = data.value(forKey: "company_info") as? NSDictionary {
                                let info = CompanyInfo()
                                info.bindModel(dict)
                                let apiResponse = APIResponse()
                                apiResponse.result = info
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
