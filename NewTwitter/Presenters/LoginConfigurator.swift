//
//  LoginConfigurator.swift
//  NewTwitter
//
//  Created by DavidTran on 12/31/17.
//  Copyright © 2017 DavidTran. All rights reserved.
//

import Foundation

protocol LoginConfiguarator {
    func configure(loginViewController:LoginViewController)
}

class LoginConfiguratorImpl:LoginConfiguarator{
    func configure(loginViewController: LoginViewController) {
        
        
        let router = LoginRouterImpl(loginViewController: loginViewController)
        let presenter = LoginPresenterImpl(view: loginViewController, router: router)
        
        loginViewController.presenter = presenter
    }
    
    
}
