//
//  LoginRouter.swift
//  NewTwitter
//
//  Created by DavidTran on 12/31/17.
//  Copyright © 2017 DavidTran. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

protocol LoginRouter:ViewRouter {
    func presentHome(with session:TWTRSession)
}
class LoginRouterImpl:LoginRouter{
    
    fileprivate weak var loginViewController:LoginViewController?
    
    init(loginViewController:LoginViewController) {
        self.loginViewController = loginViewController
    }

    func presentHome(with session: TWTRSession) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "MainContainVCIdentity") as! MainContainerViewController
        
        vc.session = session
       // let userInfo = ["session":session]
          // NotificationCenter.default.post(name: .LoginSession, object: nil, userInfo: userInfo)
        loginViewController!.present(vc, animated:true, completion:nil)
        //loginViewController?.performSegue(withIdentifier: "LoginToHomeSegue", sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let homeViewController = segue.destination as? HomeViewController{
//            homeViewController.text = "456789"
//        }
    }
    
}
