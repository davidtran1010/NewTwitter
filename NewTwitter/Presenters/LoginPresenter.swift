//
//  LoginPresenter.swift
//  NewTwitter
//
//  Created by DavidTran on 12/31/17.
//  Copyright © 2017 DavidTran. All rights reserved.
//

import Foundation
import TwitterKit
import Alamofire
import STTwitter
import SwiftyJSON


protocol LoginView: class {
    func updateLoginState(isSuccess:Bool)
    func displayLoginError(message:String)
    func displayLoginInfo(info:String)
}

protocol LoginPresenterDelegate: class {
    // add some function when login success
}

protocol LoginPresenter {
    var router: LoginRouter{ get }
    func loginButtonPressed()
}

class LoginPresenterImpl:LoginPresenter{
    internal let router: LoginRouter
    
    fileprivate weak var view: LoginView?
    fileprivate weak var delegate:LoginPresenterDelegate?
    
    init(view:LoginView,router:LoginRouter) {
        self.view = view
        self.router = router
    }
    func loginButtonPressed() {
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                
                
                print("signed in as \(session?.userName)");
                self.handleLoginSuccess(session: session)
                
            } else {
                print("error: \(error?.localizedDescription)");
                self.handleLoginError(error!)
            }
        })
        
    }
    fileprivate func handleLoginSuccess(session:Any){
        view?.displayLoginInfo(info: (session as! TWTRSession).userName)
        view?.updateLoginState(isSuccess: true)
        
        router.presentHome(with: (session as! TWTRSession))
    
    }
    fileprivate func handleLoginError(_ error:Error){
        view?.updateLoginState(isSuccess: false)
        view?.displayLoginError(message: "Failed to login")
    }
    
}
