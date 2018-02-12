//
//  TweetConversationAPI.swift
//  NewTwitter
//
//  Created by DavidTran on 1/24/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation
import PromiseKit
import TwitterKit
import STTwitter
import SwiftyJSON
import ObjectMapper

class TweetConversationAPI{

    static func fetchTweetConversation(tweetID:String, from session:TWTRSession){
         let twitter = STTwitterAPI(oAuthConsumerKey: ApiInfo.consumerKey, consumerSecret: ApiInfo.consumerSecret, oauthToken: session.authToken, oauthTokenSecret: session .authTokenSecret)
        twitter?.verifyCredentials(userSuccessBlock: { (userName, userID) in
            twitter?._getConversationShow(withTweetID: tweetID, successBlock: { (results) in
                print(results)
            }, errorBlock: { (error) in
                print(error!)
            })
//            twitter?._getConversationShow(forStatusID: tweetID, successBlock: { (status) in
//                print(status)
//            }, errorBlock: { (error) in
//                print(error!)
//            })
        }, errorBlock: { (error) in
            print(error!)
        })
    }
}
