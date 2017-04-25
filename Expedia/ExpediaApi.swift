//
//  ExpediaApi.swift
//  Expedia
//
//  Created by speplinski on 25/04/17.
//  Copyright © 2017 HotelOga. All rights reserved.
//

import Foundation
import Siesta
import SwiftyJSON

let api: ExpediaApi = ExpediaApi()

class ExpediaApi
{
    private let service = Service(baseURL: "http://35.187.48.156/")
    
    var authToken: String? {
        didSet {
            service.wipeResources()
            service.invalidateConfiguration()
        }
    }
    
    fileprivate init()
    {
        #if DEBUG
            // Bare-bones logging of which network calls Siesta makes:
            LogCategory.enabled = [.network]
            
            // For more info about how Siesta decides whether to make a network call,
            // and when it broadcasts state updates to the app:
            LogCategory.enabled = LogCategory.common
            
            // For the gory details of what Siesta’s up to:
            //LogCategory.enabled = LogCategory.detailed
        #endif
        
        service.configure
        {
            $0.pipeline[.parsing].add(SwiftyJSONTransformer, contentTypes: ["*/json"])
            $0.expirationTime = 3600
        }
        
        service.configure("**", description: "auth token")
        {
            if let authToken = self.authToken {
                $0.headers["X-API-TOKEN"] = authToken
            }
        }
        
        service.configureTransformer("/list")
        {
            try ($0.content as JSON)["list"]
                .arrayValue
                .map(Property.init)
        }
    }
    
    // API
    var upload: Resource { return service.resource("/upload") }
    var new: Resource { return service.resource("/new") }
    var list: Resource { return service.resource("/list") }
}

