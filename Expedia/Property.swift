//
//  Property.swift
//  Expedia
//
//  Created by speplinski on 25/04/17.
//  Copyright © 2017 HotelOga. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Property
{
    let name: String?
    let address: String?
    
    init(json: JSON) throws
    {
        name = json["name"].string
        address = json["address"].string
    }
}
