//
//  PropertyViewController.swift
//  Expedia
//
//  Created by speplinski on 25/04/17.
//  Copyright © 2017 HotelOga. All rights reserved.
//

import UIKit
import Siesta
import SwiftyJSON

class PropertyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var property: Property?
    
    var currentTag: Int?
    
    var currentStatus: String?
    
    var arrRes: [PropertyItem] = []
    
    var timer: Timer? = nil
    
    @IBOutlet weak var propertyName: UILabel!
    
    @IBOutlet weak var propertyAddress: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func goToHome(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isHidden = true
        
        self.propertyName.text = property?.name
        self.propertyAddress.text = property?.address
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.getStatus()
        
        //self.loader.startAnimating()
        self.tableView.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
        super.viewDidDisappear(animated)
    }

    func getStatus()
    {
        api.status.request(.get).onFailure {_ in
            print("Error")
            }.onSuccess {data in
                var response: JSON = data.content as! JSON
                
                self.arrRes = []
                
                self.arrRes.append(PropertyItem(name: "Hotel Amenities", isLabel: true, isHotelAmenity: true))
                for item in response["hotel"]["amenities"].array! {
                    self.arrRes.append(PropertyItem(name: item.string!, isLabel: false, isHotelAmenity: true))
                }
                
                self.arrRes.append(PropertyItem(name: "Room Amenities", isLabel: true, isHotelAmenity: false))
                for item in response["room"]["amenities"].array! {
                    self.arrRes.append(PropertyItem(name: item.string!, isLabel: false, isHotelAmenity: false))
                }
                
                self.currentStatus = response["status"].string
                debugPrint(self.currentStatus!)
                
                if self.currentStatus == "done" {
                    api.save.request(.get).onSuccess {data in
                        //debugPrint(data)
                    }
                }
                
                if self.timer == nil {
                    self.timer =  Timer.scheduledTimer(
                        timeInterval: TimeInterval(5.0),
                        target      : self,
                        selector    : #selector(self.getStatus),
                        userInfo    : nil,
                        repeats     : true)
                }
                
                self.tableView.reloadData()
                //self.loader.stopAnimating()
                self.tableView.isHidden = false
        }
    }
    
    func scanHotel()
    {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
        view.uploadType = "hotel"
        self.present(view, animated: true)
    }
    
    func scanRoom()
    {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
        view.uploadType = "room"
        self.present(view, animated: true)
    }
    
    func removeItem(sender: UIButton) {
        
        let item: PropertyItem = arrRes[sender.tag]
        
        self.currentTag = sender.tag
        
        let alert = UIAlertController(title: "Delete Amenity", message: "Are you sure you want to delete \(item.name!)?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
            self.removeItemConfirmed()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func removeItemConfirmed() {
        arrRes.remove(at: self.currentTag!)
        self.tableView.reloadData()
        self.currentTag = -1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item: PropertyItem = arrRes[(indexPath as NSIndexPath).row]
        
        var cell: UITableViewCell
        
        if item.isLabel == true {
            cell = tableView.dequeueReusableCell(withIdentifier:  "PropertyTitleTableViewCell")! as! PropertyTitleTableViewCell
            ( cell as! PropertyTitleTableViewCell ).name.text = item.name
            
            ( cell as! PropertyTitleTableViewCell ).button.tag = indexPath.row
            
            if item.isHotelAmenity == true {
                ( cell as! PropertyTitleTableViewCell ).button.addTarget(self, action: #selector(scanHotel), for: .touchUpInside)
            } else {
                ( cell as! PropertyTitleTableViewCell ).button.addTarget(self, action: #selector(scanRoom), for: .touchUpInside)
            }
            
            if currentStatus != "done" {
                ( cell as! PropertyTitleTableViewCell ).showProgress()
            } else {
                ( cell as! PropertyTitleTableViewCell ).hideProgress()
            }
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier:  "PropertyItemTableViewCell")! as! PropertyItemTableViewCell
            ( cell as! PropertyItemTableViewCell ).name.text = item.name
            
            
            ( cell as! PropertyItemTableViewCell ).button.tag = indexPath.row
            
            if item.isHotelAmenity == true {
                ( cell as! PropertyItemTableViewCell ).button.addTarget(self, action: #selector(self.removeItem(sender:)), for: .touchUpInside)
            } else {
                ( cell as! PropertyItemTableViewCell ).button.addTarget(self, action: #selector(self.removeItem(sender:)), for: .touchUpInside)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
}


