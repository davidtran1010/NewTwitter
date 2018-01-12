//
//  HomeConfigurator.swift
//  NewTwitter
//
//  Created by DavidTran on 1/10/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation

protocol HomeConfigurator {
    func configure(homeViewController:HomeViewController)
}
class HomeConfiguratorImpl:HomeConfigurator{
    func configure(homeViewController: HomeViewController) {
        let router = HomeRouterImpl(homeViewController: homeViewController)
        let presenter = HomePresenterImpl(router: router, view: homeViewController)
        
        homeViewController.presenter = presenter
    }
    
    
}
