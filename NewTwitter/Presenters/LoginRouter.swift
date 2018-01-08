//
//  LoginRouter.swift
//  NewTwitter
//
//  Created by DavidTran on 12/31/17.
//  Copyright © 2017 DavidTran. All rights reserved.
//

import Foundation
import UIKit
protocol LoginRouter:ViewRouter {
    func presentHome()
}
class LoginRouterImpl:LoginRouter{
    fileprivate weak var loginViewController:LoginViewController?
    
    init(loginViewController:LoginViewController) {
        self.loginViewController = loginViewController
    }
    func presentHome() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeVCIdentity") as! HomeViewController
        loginViewController!.present(vc, animated:true, completion:nil)
        
        //loginViewController?.performSegue(withIdentifier: "LoginToHomeSegue", sender: nil)
    }
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let homeViewController = segue.destination as? HomeViewController{
            homeViewController.text = "456789"
        }
    }
    
}
