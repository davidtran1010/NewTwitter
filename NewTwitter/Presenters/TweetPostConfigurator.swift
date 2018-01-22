//
//  TweetPostConfigurator.swift
//  NewTwitter
//
//  Created by DavidTran on 1/19/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation
protocol TweetPostConfiguarator {
    func configure(tweetPostViewController:TweetPostViewController)
}

class TweetPostConfiguaratorImpl:TweetPostConfiguarator{
    func configure(tweetPostViewController: TweetPostViewController) {
        
        
        let router = TweetPostRouterImpl(tweetPostViewController: tweetPostViewController)
        let presenter = TweetPostPresenterImpl (view: tweetPostViewController, router: router)
        
        tweetPostViewController.presenter = presenter
    }
    
    
}
