//
//  PropertyViewController.swift
//  Expedia
//
//  Created by speplinski on 25/04/17.
//  Copyright © 2017 HotelOga. All rights reserved.
//

import UIKit

class PropertyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var property: Property?
    
    var arrRes: [Property] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func goToHome(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isHidden = true
    }
    
    func scanHotel(_ sender: Any)
    {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "CameraViewControler") as! CameraViewController
        view.uploadType = "hotel"
        self.present(view, animated: true)
    }
    
    func scanRoom(_ sender: Any)
    {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "CameraViewControler") as! CameraViewController
        view.uploadType = "room"
        self.present(view, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PropertyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PropertyTableViewCell")! as! PropertyTableViewCell
        let property: Property = arrRes[(indexPath as NSIndexPath).row]
        
        cell.name.text = property.name
        cell.address.text = property.address
        cell.button.tag = indexPath.row
        //cell.button.addTarget(self,action:#selector(onShowProperty(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
}


