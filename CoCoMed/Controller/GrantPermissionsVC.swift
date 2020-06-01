//
//  GrantPermissionsVC.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 01/06/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import UIKit
import CoreBluetooth
import UserNotifications

class GrantPermissionsVC: UIViewController {

    
    var centralManager: CBCentralManager?
    var peripheral: CBPeripheral?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    private func askForLocationPermission()
    {
        let alert = UIAlertController(title: "Enable Location Access", message: "With location data, it detects places where people gather & highlight you the high risk area near you", preferredStyle: UIAlertController.Style.alert)
         
         self.present(alert, animated: true, completion: nil)
                alert.addAction(UIAlertAction(title: "Yes,Sure", style: .default, handler: { action in
                    
                     UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
                      
                }))
         alert.addAction(UIAlertAction(title: "Remind Me Later", style: .cancel, handler: { action in
            
             
             
        
         }))
    }
    
    
    private func askForBluetoothPermission()
    {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    
    private func askForPushNotificationPermission()
    {
         UNUserNotificationCenter.current().delegate = self
         UIApplication.shared.registerForRemoteNotifications()
    }
    
    
    static func enableExposureNotifications(from viewController: UIViewController) {
//        ExposureManager.shared.manager.setExposureNotificationEnabled(true) { error in
//            NotificationCenter.default.post(name: ExposureManager.authorizationStatusChangeNotification, object: nil)
//            if let error = error as? ENError, error.code == .notAuthorized {
//                viewController.show(RecommendExposureNotificationsSettingsViewController.make(), sender: nil)
//            } else if let error = error {
//                showError(error, from: viewController)
//            } else {
//                (UIApplication.shared.delegate as! AppDelegate).scheduleBackgroundTaskIfNeeded()
//                enablePushNotifications(from: viewController)
//            }
//        }
    }
    
    @IBAction func getPermissionsButtonTapped(_ sender: Any) {
        
    }
    
    

}

extension GrantPermissionsVC : CBPeripheralDelegate, CBCentralManagerDelegate
{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
       
        switch central.state {
        case .unauthorized:
            switch central.authorization {
            case .allowedAlways:
                print(central.authorization)
            case .denied:
                print(central.authorization)
            case .restricted:
                print(central.authorization)
            case .notDetermined:
                print(central.authorization)
            @unknown default:
                print("default")
                
            }
        case .unknown:
            print(central.state)
        case .unsupported:
            print(central.state)
        case .poweredOn:
            self.centralManager?.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey:true])
        case .poweredOff:
            print(central.state)
        case .resetting:
            print(central.state)
        @unknown default:
            print("default")
        }
        
        }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        self.peripheral = peripheral
        self.peripheral?.delegate = self
        
        centralManager?.connect(peripheral, options: nil)
        centralManager?.stopScan()
    }
  
    
    
}



extension GrantPermissionsVC : UNUserNotificationCenterDelegate
{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
}
