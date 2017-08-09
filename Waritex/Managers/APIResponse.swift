//
//  APIResponse.swift
//  Hippy
//
//  Created by Mostafa on 5/14/17.
//  Copyright © 2017 Inova. All rights reserved.
//

import Foundation
public class APIResponse {
    
    public var result:AnyObject?
    public var error:NSError?
    public var status:Bool = false
    public var args:Array<AnyObject>?
    public var results: [AnyObject]?
    // Default constructor
    public init() {
        
    }
    
}
