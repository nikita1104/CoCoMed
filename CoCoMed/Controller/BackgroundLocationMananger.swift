//
//  BackgroundLocationMananger.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 01/06/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class BackgroundLocationManager :NSObject, CLLocationManagerDelegate {

    static let instance = BackgroundLocationManager()
    static let BACKGROUND_TIMER = 60.0 // restart location manager every 60 seconds
    static let UPDATE_SERVER_INTERVAL = 60 * 60 // 1 hour - once every 1 hour send location to server

    let locationManager = CLLocationManager()
    var timer:Timer?
    var currentBgTaskId : UIBackgroundTaskIdentifier?
    var lastLocationDate : Date = Date()

    private override init(){
        
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.activityType = .other
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.allowsBackgroundLocationUpdates = true
      
}

    
    @objc func applicationEnterBackground(){
        print("applicationEnterBackground")
        start()
    }
    
    

    func start(){
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            
                locationManager.requestLocation()
            
        } else {
               self.locationManager.requestAlwaysAuthorization()

                // For use in foreground
                self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.restricted:
            print("Restricted Access to location")
        case CLAuthorizationStatus.denied:
            print("User denied access to location")
        case CLAuthorizationStatus.notDetermined:
            print("Status not determined")
        default:
            print("startUpdatingLocation")
            locationManager.requestLocation()
            
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if(timer==nil){
            // The locations array is sorted in chronologically ascending order, so the
            // last element is the most recent
            guard locations.last != nil else {return}

            let currentLocation = locations.last
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
                    print("BACKGROUND SERVICE IS RUNNING!!!")
                    
                    
                    
                    }
                    
                    
                    
                
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         
         locationManager.stopUpdatingLocation()
    }

    
    func sendLocationToServer(location:CLLocation, now:Date){
        //TODO
    }
    
    

    
}
