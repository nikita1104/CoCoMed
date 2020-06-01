//
//  SymptomCheckerVC.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 21/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import UIKit

class SymptomCheckerVC: UIViewController {

    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var noButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Symptom Checker"
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    
    private func setUpView()
       {
           yesButton.layer.masksToBounds = true
           yesButton.layer.cornerRadius = yesButton.bounds.height/2.0
           yesButton.backgroundColor = Constants.selectedBtnColor
           yesButton.setTitleColor(Constants.selectedBtnCTAColor, for: .normal)
           yesButton.setTitle("Yes", for: .normal)
        
        noButton.layer.masksToBounds = true
        noButton.layer.cornerRadius = noButton.bounds.height/2.0
        noButton.backgroundColor = Constants.disabledBtnColor
        noButton.setTitleColor(Constants.disabledBtnCTAColor, for: .normal)
        noButton.setTitle("No", for: .normal)
           
           
       }
       
    
    
    @IBAction func yesTapped(_ sender: Any) {
    }
    
    @IBAction func noTapped(_ sender: Any) {
    }
    

}
