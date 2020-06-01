//
//  HomeVC.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 20/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import UIKit
import SideMenuSwift
import MapKit

class HomeVC: UIViewController {

    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var symptomCheckerButton: UIButton!
    
    
    
    
    let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         title = "Logo"
        
        
        setUpView()
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.showsBackgroundLocationIndicator = true
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
            Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(self.checkLocation), userInfo: nil, repeats: true)
        }
        
        

        
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsBuildings = true
        mapView.mapType = .standard
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
       
    }

    
    
    
    
    
    private func setUpView()
    {
        symptomCheckerButton.layer.masksToBounds = true
        symptomCheckerButton.layer.cornerRadius = symptomCheckerButton.bounds.height/2.0
        symptomCheckerButton.backgroundColor = Constants.selectedBtnColor
        symptomCheckerButton.setTitleColor(Constants.selectedBtnCTAColor, for: .normal)
        symptomCheckerButton.setTitle("Symptom Checker", for: .normal)
        
        searchButton.layer.masksToBounds = true
        searchButton.layer.cornerRadius = 8.0
        
        searchView.layer.masksToBounds = true
        
        searchView.layer.cornerRadius = 8.0
        searchView.layer.borderColor = UIColor(rgb: 0xCCCCCC).cgColor
        searchView.layer.borderWidth = 1.0
        
        searchTextField.backgroundColor = Constants.lightBGColor
    }
    
    
    
    @objc func checkLocation()
    {
        locationManager.requestLocation()
    }
    

    @IBAction func openSideMenu(_ sender: Any) {
       sideMenuController?.revealMenu()
    }
    
    
    
    @IBAction func searchTapped(_ sender: Any) {
    }
    
    
    
    @IBAction func symptomCheckerButton(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SymptomCheckTermsVC") as? SymptomCheckTermsVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}

extension HomeVC : MKMapViewDelegate
{
    
    
}


extension HomeVC : CLLocationManagerDelegate
{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error::: \(error)")
               locationManager.stopUpdatingLocation()
        let alert = UIAlertController(title: "Enable Location Access", message: "With location data, it detects places where people gather & highlight you the high risk area near you", preferredStyle: UIAlertController.Style.alert)
        
        self.present(alert, animated: true, completion: nil)
               alert.addAction(UIAlertAction(title: "Yes,Sure", style: .default, handler: { action in
                   
                    UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
                     
               }))
        alert.addAction(UIAlertAction(title: "Remind Me Later", style: .cancel, handler: { action in
           
            
            
       
        }))
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        

     // The locations array is sorted in chronologically ascending order, so the
      // last element is the most recent
      guard locations.last != nil else {return}

      var currentLocation = locations.last
      defer { currentLocation = locations.last }
      locationManager.stopUpdatingLocation()
      var horizontalDist : Double?
      var verticalDist : Double?
      let lat : Double?
      let long : Double?
              
      lat = ((currentLocation?.coordinate.latitude)!) * .pi / 180.0
      long = ((currentLocation?.coordinate.longitude)!) * .pi / 180.0
      let a1 = pow(cos(lat!), 2.0) * pow(sin(long! / 2.0), 2.0)
      let a2 = pow(sin(lat! / 2.0), 2.0)
      horizontalDist = 2.0 * atan2(sqrt(a1), sqrt((1 - a1)))
      verticalDist = 2.0 * atan2(sqrt(a2), sqrt((1 - a2)))
      horizontalDist! /= 10;
      horizontalDist! *= 10;
      horizontalDist! += 5;
      verticalDist! /= 10;
      verticalDist! *= 10;
      verticalDist! += 5;
              
              if (GridUtil.shared!.grid[0] == horizontalDist && GridUtil.shared!.grid[1] == verticalDist) {
                  GridUtil.shared!.count += 1
                  print("\(horizontalDist!) \(verticalDist!) Stayed in same point for \(GridUtil.shared!.count) minutes")
                                             if (GridUtil.shared!.count == 3) {
                                                 print("\(horizontalDist!) \(verticalDist!) Stayed in same point for 3 minutes")
                                              //send data to server
                                             } else {
                                                  print("\(horizontalDist!) \(verticalDist!)")
                                             }
                                         }
              else {
                     GridUtil.shared!.count = 0;
                      print("\(horizontalDist!) \(verticalDist!) loaction changed")
                                         
                    }

              GridUtil.shared!.grid[0] = horizontalDist!
              GridUtil.shared!.grid[1] = verticalDist!
              print("FOREGROUND SERVICE IS RUNNING!!!")
        
        
        
        
    }
    
    
    
  
    
    
}



extension HomeVC : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
