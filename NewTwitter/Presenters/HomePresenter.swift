//
//  HomePresenter.swift
//  NewTwitter
//
//  Created by DavidTran on 12/31/17.
//  Copyright © 2017 DavidTran. All rights reserved.
//

import Foundation
import PromiseKit
import TwitterKit
protocol HomeView: class{
    
    func updateTableView(array:[TweetTableViewCellModel])
    func updateUserAccountInfo()
}
protocol HomePresenterDeletegate:class {
    
}
protocol HomePresenter {
    var router: HomeRouter{get}
    func viewDidLoad(with session:TWTRSession)
    func refeshTimeline(count:UInt)
    func searchTweet()
    func chooseTweetOptions()
}
class HomePresenterImpl: HomePresenter{

   
    var session:TWTRSession?

    var router: HomeRouter
    
    fileprivate weak var view: HomeView?

    init(router: HomeRouter, view: HomeView) {
        self.router = router
        self.view = view
        
    }
    fileprivate weak var delegate:HomePresenterDeletegate?
    
    
    func searchTweet() {
        //search Tweet
    }
    
    func chooseTweetOptions() {
        
    }
    func refeshTimeline(count:UInt) {
        firstly {
            HomeTimelineAPI.fetchTimeline(with: session!,count: count)
            }
            .then{ tweets in
                self.handleFetchTweetsSuccess(tweetModels: self.convertToTweetModels(from: tweets))
        }
    }
    func viewDidLoad(with session: TWTRSession) {
        self.session = session
        firstly {
            HomeTimelineAPI.fetchTimeline(with: session, count: 50)
            }
            .then{ tweets in
                self.handleFetchTweetsSuccess(tweetModels: self.convertToTweetModels(from: tweets))
        }
    }
    
    func handleFetchTweetsSuccess(tweetModels: [TweetTableViewCellModel]){
       view?.updateTableView(array: tweetModels)
    }
    func handleFetchTweetsFailed(){
        // send notification to view error
    }
    
    func convertToTweetModels(from tweets:[Tweet]) -> [TweetTableViewCellModel]{
        var tweetModels = [TweetTableViewCellModel]()
        for tweet in tweets{
            let ownerPhotoURLString = tweet.user?.profileImageUrlHttps
            let ownerName = tweet.user?.screenName
            let tweetTime = tweet.createdAt!
            let tweetContent = tweet.text
            var tweetPhotoArrayURLString = [String]()
            
            if let exEntities = tweet.extendedEntities{
                if let media = exEntities.media{
                    
                    // add url from media to tweetPhotoArrayString
                    for m in media{
                        tweetPhotoArrayURLString.append(m.mediaUrlHttps!)
                    }
                }
                
            }
            else if let entities = tweet.entities{
                if let media = entities.media{
                    
                    // add url from media to tweetPhotoArrayString
                    for m in media{
                        tweetPhotoArrayURLString.append(m.mediaUrlHttps!)
                    }
                }
            }
            
            let tweetModel = TweetTableViewCellModel.init(LikeCount: tweet.favoriteCount, RetweetCount: tweet.retweetCount, ReplyCount: 0, TweetOwnerPhotoURLString: ownerPhotoURLString, TweetOwnerName: ownerName, TweetPosedTime: tweetTime, TweetPhotoURLStringArray: tweetPhotoArrayURLString, TweetContent: tweetContent)
            tweetModels.append(tweetModel)
        }
        return tweetModels
    }
}
