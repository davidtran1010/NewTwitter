//
//  HomeRouter.swift
//  NewTwitter
//
//  Created by DavidTran on 12/31/17.
//  Copyright © 2017 DavidTran. All rights reserved.
//

import Foundation
import UIKit
protocol HomeRouter:ViewRouter {
    func presentNotification()
}

class HomeRouterImpl:HomeRouter{
   
    fileprivate weak var homeViewController:HomeViewController?
    

    init(homeViewController: HomeViewController) {
        self.homeViewController = homeViewController
    }
    
    func presentNotification() {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "NotificationVCIdentity")
        homeViewController?.present(vc, animated: true, completion: nil)
    }
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let notificationVC = segue.destination as? NotificationViewController{
//            //configurator notification VC here
//        }
    }
}
