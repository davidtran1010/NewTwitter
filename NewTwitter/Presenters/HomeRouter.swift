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

class HomeRouterImpl: HomeRouter{

    var TweetPostSegueLoaded = false
    fileprivate weak var homeViewController:HomeViewController?
    var session:TWTRSession?

    init(homeViewController: HomeViewController) {
        self.homeViewController = homeViewController
    }
    func presentTweetPost(userImageURL: String, with session:TWTRSession){
            self.session = session
        if !TweetPostSegueLoaded{
            TweetPostSegueLoaded = true
            homeViewController?.performSegue(withIdentifier: "TweetPostVCSegue", sender: nil)

        }
        homeViewController?.TweetPostContraint.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.homeViewController?.view.layoutIfNeeded()
            })
        
//        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let popupVC = storyBoard.instantiateViewController(withIdentifier: "TweetPostVCIndentity") as! TweetPostViewController
//        homeViewController?.addChildViewController(popupVC)
//            popupVC.view.frame = homeViewController!.view.frame
//            popupVC.session = session
//            popupVC.userImageURL = userImageURL
//            popupVC.delegate = homeViewController
//
//            popupVC.view.alpha = 0
//            self.homeViewController?.addChildViewController(popupVC)
//            self.homeViewController!.view.addSubview(popupVC.view)
//
//
//        UIView.animate(withDuration: 0.5, delay: 0.1, options: .layoutSubviews, animations: {
//            popupVC.view.alpha = 1
//        }) { (isFinished) in
//             popupVC.didMove(toParentViewController: self.homeViewController)
//        }
     
        
    }
    func presentNotification() {
       presentVC(with: "NotificationVCIdentity")
    }
    
    func presentVC(with identifier:String){
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
        homeViewController?.present(vc, animated: true, completion: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TweetPostVCSegue"{
            if let tweetPostVC = segue.destination as? TweetPostViewController{
                tweetPostVC.session = self.session
                tweetPostVC.homeViewController = self.homeViewController
            }
        }
    }
    func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
}
