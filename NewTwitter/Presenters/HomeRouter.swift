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
   
    fileprivate weak var notificationViewController:NotificationViewController?
    
    init(notificationViewController:NotificationViewController) {
        self.notificationViewController = notificationViewController
    }
    func presentNotification() {
        notificationViewController?.performSegue(withIdentifier: "HomeToNotificationSegue", sender: nil)
    }
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let notificationVC = segue.destination as? NotificationViewController{
            //configurator notification VC here
        }
    }
}
