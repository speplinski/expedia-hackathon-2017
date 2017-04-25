//
//  RootViewController.swift
//  Expedia
//
//  Created by speplinski on 25/04/17.
//  Copyright © 2017 HotelOga. All rights reserved.
//

import Foundation
import UIKit
import Siesta
import SwiftyJSON

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var arrRes: [Property] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        api.list.request(.get).onFailure {_ in
            print("Error")
            }.onSuccess {data in
                self.arrRes = data.content as! [Property]
                self.tableView.reloadData()
                self.loader.stopAnimating()
                self.tableView.isHidden = false
        }
        
        self.loader.startAnimating()
        self.tableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PropertyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PropertyTableViewCell")! as! PropertyTableViewCell
        let property: Property = arrRes[(indexPath as NSIndexPath).row]
        
        cell.name.text = property.name
        cell.address.text = property.address
        cell.button.tag = indexPath.row
        cell.button.addTarget(self,action:#selector(onShowProperty(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func onShowProperty(sender: UIButton)
    {
        let property: Property = arrRes[sender.tag]
        let view = self.storyboard?.instantiateViewController(withIdentifier: "PropertyViewController") as! PropertyViewController
        view.property = property
        self.present(view, animated: true)
    }
}

