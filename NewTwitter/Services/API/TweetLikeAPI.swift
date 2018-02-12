//
//  TweetLikeAPI.swift
//  NewTwitter
//
//  Created by DavidTran on 1/23/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation
import TwitterKit
import STTwitter
import PromiseKit

class TweetLikeAPI{
    static func unlikeTweet(with tweetID:String, from session:TWTRSession) -> Promise<Bool>{
    return Promise{ fullfil, reject in
    let twitter = STTwitterAPI(oAuthConsumerKey: ApiInfo.consumerKey, consumerSecret: ApiInfo.consumerSecret, oauthToken: session.authToken, oauthTokenSecret: session .authTokenSecret)
        twitter?.verifyCredentials(userSuccessBlock: { (userName, userID) in
           
            twitter?.postFavoriteDestroy(withStatusID: tweetID, includeEntities: nil, useExtendedTweetMode: nil, successBlock: { (status) in
                print(status)
                fullfil(true)
            }, errorBlock: { (error) in
                print(error!)
                 fullfil(false)
            })
        }, errorBlock: { (error) in
            print(error!)
             fullfil(false)
        })
        }
    }
    static func likeTweet(with tweetID:String, from session:TWTRSession) -> Promise<Bool>{
        return Promise{ fullfil, reject in
        let twitter = STTwitterAPI(oAuthConsumerKey: ApiInfo.consumerKey, consumerSecret: ApiInfo.consumerSecret, oauthToken: session.authToken, oauthTokenSecret: session .authTokenSecret)
        twitter?.verifyCredentials(userSuccessBlock: { (userName, userID) in
            twitter?.postFavoriteCreate(withStatusID: tweetID, includeEntities: nil, useExtendedTweetMode: nil, successBlock: { (status) in
                print(status)
                fullfil(true)
            }, errorBlock: { (error) in
                print(error!)
                fullfil(false)
            })
        }, errorBlock: { (error) in
            print(error!)
            fullfil(false)
        })
        }
    }
}
