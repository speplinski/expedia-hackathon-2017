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
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func showProgress() {
        self.progress.startAnimating()
        self.name.frame.origin.x = 44
    }
    
    public func hideProgress() {
        self.progress.stopAnimating()
        self.name.frame.origin.x = 16
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
    }
}


