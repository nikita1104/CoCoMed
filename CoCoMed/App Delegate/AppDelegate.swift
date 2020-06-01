//
//  AppDelegate.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 18/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import UIKit
import CoreData
import SideMenuSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var backgroundUpdateTask: UIBackgroundTaskIdentifier!
    var backgroundTaskTimer:Timer! = Timer()
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureSideMenu()
        
        
        return true
    }

    
    private func configureSideMenu() {
        SideMenuController.preferences.basic.menuWidth = 278.0
        SideMenuController.preferences.basic.defaultCacheKey = "0"
    }
    
    func doBackgroundTask() {
        DispatchQueue.global(qos: .default).async {
            self.beginBackgroundTask()

            if self.backgroundTaskTimer != nil {
                self.backgroundTaskTimer.invalidate()
                self.backgroundTaskTimer = nil
            }

            //Making the app to run in background forever by calling the API
            self.backgroundTaskTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.startTracking), userInfo: nil, repeats: true)
            RunLoop.current.add(self.backgroundTaskTimer, forMode: RunLoop.Mode.default)
            RunLoop.current.run()

            // End the background task.
            //self.endBackgroundTask()

        }
    }

    func beginBackgroundTask() {
        self.backgroundUpdateTask = UIApplication.shared.beginBackgroundTask(withName: "Track location in background", expirationHandler: {
            self.endBackgroundTask()
        })
    }

    func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(self.backgroundUpdateTask)
        self.backgroundUpdateTask = UIBackgroundTaskIdentifier.invalid
    }
    
    @objc func startTracking()
    {
        BackgroundLocationManager.instance.start()
    }
    
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.doBackgroundTask()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {

        if self.backgroundTaskTimer != nil {
            self.backgroundTaskTimer.invalidate()
            self.backgroundTaskTimer = nil
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CoCoMed")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

