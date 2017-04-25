//
//  AddNewHotelViewController.swift
//  Expedia
//
//  Created by speplinski on 25/04/17.
//  Copyright © 2017 HotelOga. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddNewHotelViewController: UIViewController {
    
    @IBOutlet weak var hotelName: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func save(_ sender: Any) {
        let post = [
            "hotelName": hotelName.text!
        ]
        api.new.request(.post, json: post).onFailure {_ in
            print("Error")
            self.presentingViewController!.dismiss(animated: true, completion: nil)
            }.onSuccess {data in
                self.presentingViewController!.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        self.addPin()
        self.focusMapView()
    }
    
    func addPin()
    {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2DMake(51.3797432,-0.0853196)
        annotation.coordinate = centerCoordinate
        annotation.title = hotelName.text!
        self.mapView.addAnnotation(annotation)
    }
    
    func focusMapView()
    {
        let mapCenter = CLLocationCoordinate2DMake(51.3797432,-0.0853196)
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(mapCenter, span)
        self.mapView.setRegion(region, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



