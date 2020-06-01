//
//  SymptomCheckTermsVC.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 21/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import UIKit

class SymptomCheckTermsVC: UIViewController {

    
    
    @IBOutlet weak var continueButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Symptom Checker"
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    private func setUpView()
    {
        continueButton.layer.masksToBounds = true
        continueButton.layer.cornerRadius = continueButton.bounds.height/2.0
        continueButton.backgroundColor = Constants.selectedBtnColor
        continueButton.setTitleColor(Constants.selectedBtnCTAColor, for: .normal)
        continueButton.setTitle("Continue", for: .normal)
        
        
    }
    
    
    @IBAction func continueTapped(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SymptomCheckerVC") as? SymptomCheckerVC
        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = nil

        vc!.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension UIViewController {
        open override func awakeFromNib() {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
            navigationController?.navigationBar.backItem?.title = ""
            
            
    }
}
