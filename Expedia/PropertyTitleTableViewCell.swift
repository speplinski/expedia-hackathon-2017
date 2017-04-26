//
//  PropertyTitleTableViewCell.swift
//  Expedia
//
//  Created by speplinski on 26/04/17.
//  Copyright © 2017 HotelOga. All rights reserved.
//

import UIKit

class PropertyTitleTableViewCell: UITableViewCell
{
    @IBOutlet weak var name: UILabel!
    
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


