//
//  HomeRouter.swift
//  NewTwitter
//
//  Created by DavidTran on 12/31/17.
//  Copyright © 2017 DavidTran. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit
protocol HomeRouter:ViewRouter {
    func presentNotification()
    func presentTweetPost(userImageURL: String,with session:TWTRSession)
}

class HomeRouterImpl:HomeRouter{

   
    fileprivate weak var homeViewController:HomeViewController?
    

    init(homeViewController: HomeViewController) {
        self.homeViewController = homeViewController
    }
    func presentTweetPost(userImageURL: String, with session:TWTRSession){
       
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "TweetPostVCIndentity") as! TweetPostViewController
        homeViewController?.addChildViewController(popupVC)
            popupVC.view.frame = homeViewController!.view.frame
            popupVC.session = session
            popupVC.userImageURL = userImageURL
            popupVC.delegate = homeViewController
            self.homeViewController!.view.addSubview(popupVC.view)
            popupVC.didMove(toParentViewController: homeViewController)
        
    }
    func presentNotification() {
       presentVC(with: "NotificationVCIdentity")
    }
    
    func presentVC(with identifier:String){
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
        homeViewController?.present(vc, animated: true, completion: nil)
    }
    
    
    func presentPopupVC(with identifier:String,sesion:TWTRSession){
        
        
        
//        homeViewController?.transition(from: homeViewController!, to: popupVC, duration: 0.5, options: .transitionFlipFromTop, animations: {
//           
//        }, completion: nil)
        
    }
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let notificationVC = segue.destination as? NotificationViewController{
//            //configurator notification VC here
//        }
    }
}
