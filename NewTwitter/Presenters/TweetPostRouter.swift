//
//  TweetPostRouter.swift
//  NewTwitter
//
//  Created by DavidTran on 1/19/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation

protocol TweetPostRouter:class {
    func presentBackHome()
}
class TweetPostRouterImpl:TweetPostRouter{
    fileprivate weak var tweetPostViewController:TweetPostViewController?


    init(tweetPostViewController: TweetPostViewController?) {
        self.tweetPostViewController = tweetPostViewController
    }
    
    
    func presentBackHome() {
        tweetPostViewController!.view.removeFromSuperview()
        
    }
    
    
}
