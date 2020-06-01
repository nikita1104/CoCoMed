//
//  SideMenuContainerVC.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 20/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import UIKit
import SideMenuSwift



class Preferences {
    static let shared = Preferences()
    var enableTransitionAnimation = false
}

class SideMenuContainerVC: UIViewController {

    
     var isDarkModeEnabled = false
     @IBOutlet weak var tableView: UITableView! {
         didSet {
             tableView.dataSource = self
             tableView.delegate = self
             tableView.separatorStyle = .none
         }
     }
     @IBOutlet weak var selectionTableViewHeader: UILabel!

     @IBOutlet weak var selectionMenuTrailingConstraint: NSLayoutConstraint!
     

     override func viewDidLoad() {
         super.viewDidLoad()

         isDarkModeEnabled = SideMenuController.preferences.basic.position == .under
         configureView()

         sideMenuController?.cache(viewControllerGenerator: {
             self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")
         }, with: "1")

         sideMenuController?.cache(viewControllerGenerator: {
             self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")
         }, with: "2")
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")
        }, with: "3")
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")
        }, with: "4")
        

         sideMenuController?.delegate = self
     }

     private func configureView() {
         

         let sidemenuBasicConfiguration = SideMenuController.preferences.basic
         let showPlaceTableOnLeft = (sidemenuBasicConfiguration.position == .under) != (sidemenuBasicConfiguration.direction == .right)
         if showPlaceTableOnLeft {
            selectionMenuTrailingConstraint.constant = SideMenuController.preferences.basic.menuWidth - view.frame.width
         }

         
     }

     override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
         super.viewWillTransition(to: size, with: coordinator)

         let sidemenuBasicConfiguration = SideMenuController.preferences.basic
         let showPlaceTableOnLeft = (sidemenuBasicConfiguration.position == .under) != (sidemenuBasicConfiguration.direction == .right)
         selectionMenuTrailingConstraint.constant = showPlaceTableOnLeft ? SideMenuController.preferences.basic.menuWidth - size.width : 0
         view.layoutIfNeeded()
     }

}


extension SideMenuContainerVC : SideMenuControllerDelegate
{
    func sideMenuController(_ sideMenuController: SideMenuController,
                            animationControllerFrom fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BasicTransitionAnimator(options: .transitionFlipFromLeft, duration: 0.6)
    }

    func sideMenuController(_ sideMenuController: SideMenuController, willShow viewController: UIViewController, animated: Bool) {
       
    }

    func sideMenuController(_ sideMenuController: SideMenuController, didShow viewController: UIViewController, animated: Bool) {
       
    }

    func sideMenuControllerWillHideMenu(_ sideMenuController: SideMenuController) {
       
    }

    func sideMenuControllerDidHideMenu(_ sideMenuController: SideMenuController) {
        
    }

    func sideMenuControllerWillRevealMenu(_ sideMenuController: SideMenuController) {
       
    }

    func sideMenuControllerDidRevealMenu(_ sideMenuController: SideMenuController) {
        
    }
}


extension SideMenuContainerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    // swiftlint:disable force_cast
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SelectionCell
        
        let row = indexPath.row
        if row == 0 {
            cell.titleLabel?.text = "My appointment"
        } else if row == 1 {
            cell.titleLabel?.text = "Settings"
        } else if row == 2 {
            cell.titleLabel?.text = "About Us"
        }
        else if row == 3 {
            cell.titleLabel?.text = "Login"
        }
        else if row == 4 {
            cell.titleLabel?.text = "Register"
        }
        cell.titleLabel?.textColor = isDarkModeEnabled ? .white : .black
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row

        sideMenuController?.setContentViewController(with: "\(row)", animated: Preferences.shared.enableTransitionAnimation)
        sideMenuController?.hideMenu()

        if let identifier = sideMenuController?.currentCacheIdentifier() {
            print("[Example] View Controller Cache Identifier: \(identifier)")
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 59.0
    }
}

class SelectionCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var optionImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        optionImage.layer.masksToBounds = true
        optionImage.layer.cornerRadius = 4.0
    }
    
    
    
}
