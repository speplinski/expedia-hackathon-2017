//
//  PropertyItem.swift
//  Expedia
//
//  Created by speplinski on 26/04/17.
//  Copyright © 2017 HotelOga. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PropertyItem
{
    let name: String!
    let isLabel: Bool!
    let isHotelAmenity: Bool!
    
    init(name: String, isLabel: Bool, isHotelAmenity: Bool) {
        self.name = name
        self.isLabel = isLabel
        self.isHotelAmenity = isHotelAmenity
    }
}

