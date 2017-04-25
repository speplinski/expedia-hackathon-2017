//
//  PropertyViewController.swift
//  Expedia
//
//  Created by speplinski on 25/04/17.
//  Copyright © 2017 HotelOga. All rights reserved.
//

import UIKit

class PropertyViewController: UIViewController {
    
    var property: Property?
    
    @IBAction func goToHome(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


