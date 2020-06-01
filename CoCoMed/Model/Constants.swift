//
//  Constants.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 18/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import Foundation
import UIKit


struct Constants {
    static let screenSize = UIScreen.main.bounds.size
    static let normalScreenSize : CGFloat = 320.0
    static let normalScreenHeight : CGFloat = 480.0
    static let lightBGColor : UIColor = UIColor(rgb: 0xF6F6F6)
    static let darkBGColor : UIColor = UIColor(rgb: 0x666666)
    static let onBoardingPageControlColor : UIColor = UIColor(rgb: 0xD8D8D8)
    static let selectedBtnColor : UIColor = UIColor(rgb: 0x333333)
    static let disabledBtnColor : UIColor = UIColor(rgb: 0x9B9B9B)
    static let selectedBtnCTAColor : UIColor = UIColor(rgb: 0xFFFFFF)
    static let disabledBtnCTAColor : UIColor = UIColor(rgb: 0x000000)
    static let lightTextColor : UIColor = UIColor(rgb: 0x666666)
    
    
}

var isViewAllTapped = false


var hasTopNotch: Bool {
    if #available(iOS 11.0, tvOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    return false
}




extension UIColor {

    convenience init(rgb: UInt) {
        self.init(rgb: rgb, alpha: 1.0)
    }

    convenience init(rgb: UInt, alpha: CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
