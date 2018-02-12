//
//  TweetPostPresenter.swift
//  NewTwitter
//
//  Created by DavidTran on 1/19/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit
import PromiseKit

protocol TweetPostView: class {
    func updateUserInfo(photo:UIImage,name:String)
    func updateTimeLineAfterPostTweet()
}
protocol TweetPostPresenterDelegate: class {
    
}
protocol TweetPostPresenter {
    
    func viewDidLoad(with session:TWTRSession)
    func postTweet(with content:String,from session:TWTRSession, to statusID:String)
}

class TweetPostPresenterImpl:TweetPostPresenter {
    fileprivate weak var view:TweetPostView?
    var router:TweetPostRouter
    var session:TWTRSession?

init(view: TweetPostView?, router: TweetPostRouter) {
    self.view = view
    self.router = router
    }
   
    
    func viewDidLoad(with session: TWTRSession) {
        fetchUserInfo()
    }
    
    func fetchUserInfo(){
        
    }
    func postTweet(with content: String, from session: TWTRSession, to statusID: String) {
        firstly{
            StatusPostAPI.postStatusUpdate(with: content, from: session, to: statusID)
        }
            .then { (isSuccess) -> Void in
                if(isSuccess){
                    print("post tweet success")
                    self.view?.updateTimeLineAfterPostTweet()
                    
                }
        
            }.catch { (error) in
                print(error)
        }
    }
}
