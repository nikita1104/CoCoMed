//
//  OnBoardings.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 18/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import UIKit
import SideMenuSwift

class OnBoardingsViewController: UIViewController {

    
    
    @IBOutlet weak var onBoardingCollectionView: UICollectionView!
    
    @IBOutlet weak var onBoardingageControl: UIPageControl!
    
    
    var dataArr = [["image":"Onboarding1","title":"Detects places where people gather & highlight you the high risk area near you"],["image":"Onboarding2","title":"Self reporting & booking appointment if you are in high risk of geting the virus"],["image":"Onboarding3","title":"Your data will be securely stored in the app"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
    }
    
    
    private func setupUI()
    {
        //self.onBoardingageControl.currentPageIndicatorTintColor = Constants.darkBGColor
        //self.onBoardingageControl.pageIndicatorTintColor = Constants.onBoardingPageControlColor
        self.onBoardingageControl.currentPage = 0
        self.onBoardingageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        self.onBoardingCollectionView.register(UINib.init(nibName: "OnBoardingViewCell", bundle: nil), forCellWithReuseIdentifier: "onBoardingCell")
    }

    @IBAction func sendToHome(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}



extension OnBoardingsViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onBoardingCell", for: indexPath) as? OnBoardingViewCell
        
        let dict = self.dataArr[indexPath.item]
        
        if let image = dict["image"] {
        cell?.onBoardingImageView.image = UIImage(named:image)
            cell?.onBoardingBGImageView.backgroundColor = Constants.lightBGColor
        }
        
        if let title = dict["title"] {
            cell?.onBoardingHeading.textColor = Constants.lightTextColor
        cell?.onBoardingHeading.text = title
        }
        
        return cell!
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width : collectionView.bounds.size.width, height : collectionView.bounds.size.height)
    }
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        self.onBoardingageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        self.onBoardingageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    
}



