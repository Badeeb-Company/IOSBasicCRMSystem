//
//  AbstractManager.swift
//  Hippy
//
//  Created by Mostafa on 5/14/17.
//  Copyright © 2017 Inova. All rights reserved.
//

import Foundation
import Alamofire
class AbstractManager{
    enum Result {
        case Fail
        case Success
    }
    
    func getStatus(response:DataResponse<Any>) -> Meta {
        var meta = Meta()
        switch response.result {
        case .failure(_):
            meta.parseMeta(dictionary: [:])
            return meta
        case .success(let value):
            if let dict = value as? NSDictionary {
//                if let metaDict = dict.value(forKey: "meta") as? NSDictionary {
                    meta.parseMeta(dictionary: dict)
//                }else{
//                    meta.parseMeta(dictionary: [:])
//                }
            }else{
                meta.parseMeta(dictionary: [:])
            }
            break
        default:
            meta.parseMeta(dictionary: [:])
            break;
        }
        return meta
    }
    
    
}
