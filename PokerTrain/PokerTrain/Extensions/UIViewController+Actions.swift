//
//  UIViewController+showRateView.swift
//  TraidingSimulator
//
//  Created by Kyzu on 11.02.23.
//

import UIKit
import StoreKit

extension UIViewController {
    
    func showRateView(){
        if #available(iOS 14, *){
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene  {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            SKStoreReviewController.requestReview()
        }
    }
    
    func shareApp() {
        let text = "www.trade.com"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}
