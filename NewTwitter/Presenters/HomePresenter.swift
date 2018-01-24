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
    //func updateUserAccountInfo(userID:String,imageURL:String)
    func updateHomeAfterPostTweet()
    func updateAfterDeleteTweet()
    func updateAfterLikeTweet(tweetIndex:Int)
    func updateAfterUnLikeTweet(tweetIndex:Int)
}
protocol HomePresenterDeletegate:class {
    
}
protocol HomePresenter {
    var router: HomeRouter{get}
    func viewDidLoad(with session:TWTRSession)
    func refeshTimeline(count:UInt)
    func chooseTweetOptions()
    func TweetPostButtonPressed()
    func tweetSearchReturn(with keyword:String,count:Int)
    func deleteTweet(tweetID:String)
    func likeTweet(tweetID:String,tweetIndex: Int)
    func unlikeTweet(tweetID:String,tweetIndex: Int)
}
class HomePresenterImpl: HomePresenter{



    var userImage = ""
    var userID = ""
    var session:TWTRSession?
    var router: HomeRouter
    var tweetHomeModelsCache:[TweetTableViewCellModel]?
    
    fileprivate weak var view: HomeView?

    init(router: HomeRouter, view: HomeView) {
        self.router = router
        self.view = view
        
    }
    fileprivate weak var delegate:HomePresenterDeletegate?
    
    func deleteTweet(tweetID:String){
        firstly {
            TweetDeleteAPI.deleteStatusTweet(tweetID: tweetID, from: session!)
            }
            .then{ deletedTweets in
                self.handleDeleteTweet()
        }
    }
    
    func tweetSearchReturn(with keyword:String, count:Int) {
        firstly {
            TweetSearchAPI.fetchTweetSearch(keyword: keyword, from: session!, count: count)
            }
            .then{ tweets in
                self.handleFetchTweetsSuccess(tweetModels: self.convertToTweetModels(from: tweets), isSearching: true)
        }
    }

    func likeTweet(tweetID: String, tweetIndex:Int) {
        firstly{
             TweetLikeAPI.likeTweet(with: tweetID, from: session!)
            }.then { (isSuccess) -> (Void) in
                self.handleLikeTweet(tweetIndex:tweetIndex, isSuccess: isSuccess)
        }
       
    }
    
    func unlikeTweet(tweetID: String, tweetIndex: Int) {
        firstly{
            TweetLikeAPI.unlikeTweet(with: tweetID, from: session!)
            }.then { (isSuccess) -> (Void) in
                self.handleUnLikeTweet(tweetIndex:tweetIndex, isSuccess: isSuccess)
        }
    }
    

    func chooseTweetOptions() {
        
    }
    func handleDeleteTweet(){
        
    }
    func handleLikeTweet(tweetIndex:Int,isSuccess:Bool){
        if isSuccess{
            view?.updateAfterLikeTweet(tweetIndex: tweetIndex)
        }
    }
    func handleUnLikeTweet(tweetIndex:Int,isSuccess:Bool){
        if isSuccess{
            view?.updateAfterUnLikeTweet(tweetIndex: tweetIndex)
        }
    }
    func refeshTimeline(count:UInt) {
        firstly {
            HomeTimelineAPI.fetchTimeline(with: session!,count: count)
            }
            .then{ tweets in
                self.handleFetchTweetsSuccess(tweetModels: self.convertToTweetModels(from: tweets), isSearching: false)
        }
    }
    func viewDidLoad(with session: TWTRSession) {
        self.session = session
        firstly{
            HomeTimelineAPI.fetchTimeline(with: session, count: 70)
        }
        .then{ tweets in
            self.handleFetchTweetsSuccess(tweetModels: self.convertToTweetModels(from: tweets), isSearching: false)
        }
        
//        firstly {
//            UserInfoAPI.fetchUserInfo(from: session)
//            }
//            .then{ userInfo -> Void in
////                print("user image url:\(imageURL)")
////                print("user id:\(imageURL)")
//                self.handleFetchUserInfo(userInfo: userInfo)
//            }
//            .then {_ in
//                HomeTimelineAPI.fetchTimeline(with: session, count: 70)
//            }
//            .then{ tweets in
//                self.handleFetchTweetsSuccess(tweetModels: self.convertToTweetModels(from: tweets), isSearching: false)
//        }
    }
//    
//    func handleFetchUserInfo(userInfo:UserInfoResponse){
//        self.userID = "\(userInfo.id!)"
//        self.userImage = userInfo.profileImageUrlHttps!
//        //view?.updateUserAccountInfo(userID: userID, imageURL: userImage)
//    }
    func handleFetchTweetsSuccess(tweetModels: [TweetTableViewCellModel], isSearching:Bool){
        if !isSearching{
            tweetHomeModelsCache = tweetModels
        }
       view?.updateTableView(array: tweetModels)
    }
    func handleFetchTweetsFailed(){
        // send notification to view error
    }
    
    func convertToTweetModels(from tweets:[Tweet]) -> [TweetTableViewCellModel]{
        var tweetModels = [TweetTableViewCellModel]()
        for tweet in tweets{
            print("converted to model with id:\(tweet.idStr!) name: \((tweet.user?.screenName)!)")
            let tweetID = tweet.idStr!
            let ownerPhotoURLString = tweet.user?.profileImageUrlHttps
            let ownerName = tweet.user?.screenName
            let ownerID = "\((tweet.user?.id)!)"
            let tweetTime = tweet.createdAt!
            var tweetContent = ""
            if let content = tweet.fullText{
                tweetContent = content
            }else{
                tweetContent = tweet.text!
            }
            var tweetPhotoArrayURLString = [String]()
            var tweetPhotoSizes = [Sizes]()
            
            if let exEntities = tweet.extendedEntities{
                if let media = exEntities.media{
                    
                    // add url from media to tweetPhotoArrayString
                    for m in media{
                        tweetPhotoArrayURLString.append(m.mediaUrlHttps!)
                        tweetPhotoSizes.append(m.sizes!)
                    }
                }
                
            }
            else if let entities = tweet.entities{
                if let media = entities.media{
                    
                    // add url from media to tweetPhotoArrayString
                    for m in media{
                        tweetPhotoArrayURLString.append(m.mediaUrlHttps!)
                        tweetPhotoSizes.append(m.sizes!)
                    }
                }
            }
            
            let tweetModel = TweetTableViewCellModel.init(TweetID: tweetID,isLiked: tweet.favorited, LikeCount: tweet.favoriteCount, RetweetCount: tweet.retweetCount, ReplyCount: 0, TweetOwnerPhotoURLString: ownerPhotoURLString, TweetOwnerName: ownerName, TweetOwnerID: ownerID, TweetPosedTime: tweetTime, TweetPhotoURLStringArray: tweetPhotoArrayURLString, TweetPhotoSizes: tweetPhotoSizes, TweetContent: tweetContent)
            tweetModels.append(tweetModel)
        }
        return tweetModels
    }
    func TweetPostButtonPressed() {
        router.presentTweetPost(userImageURL: self.userImage, with: session!)
    }
}
