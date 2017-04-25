//
//  PropertyTableViewCell.swift
//  Expedia
//
//  Created by speplinski on 25/04/17.
//  Copyright © 2017 HotelOga. All rights reserved.
//

import UIKit

class PropertyTableViewCell: UITableViewCell
{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
    }
}

