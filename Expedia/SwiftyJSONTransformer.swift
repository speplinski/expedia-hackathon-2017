//
//  SwiftyJSONTransformer.swift
//  Expedia
//
//  Created by speplinski on 25/04/17.
//  Copyright © 2017 HotelOga. All rights reserved.
//

import Foundation
import SwiftyJSON
import Siesta

let SwiftyJSONTransformer = ResponseContentTransformer(transformErrors: true)
{
    JSON($0.content as AnyObject)
}

extension TypedContentAccessors
{
    var json: JSON
    {
        return typedContent(ifNone: JSON.null)
    }
}

